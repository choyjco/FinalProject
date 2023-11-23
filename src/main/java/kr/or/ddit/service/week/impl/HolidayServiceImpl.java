package kr.or.ddit.service.week.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import kr.or.ddit.service.week.IHolidayService;
import kr.or.ddit.vo.HolidayVO;

@Service
public class HolidayServiceImpl implements IHolidayService {

	private final HolidayExplorer holidayExplorer = new HolidayExplorer();
	
	@Override
	@Transactional
	public List<HolidayVO> getHolidayService(String solYear, String solMonth) throws IOException { // 공휴일 가져오기
        // 샘플코드를 활용해서 xml -> jsonObject로 변환
        List<HolidayVO> result = new ArrayList<>();

        JSONObject jsonData = holidayExplorer.getHolidayExplorer(solYear, solMonth);
        JSONObject body = jsonData.getJSONObject("response").getJSONObject("body");

        if (body.getInt("totalCount") != 0) {
            // 공휴일 값이 하나일 때는 item이 jsonObject로 받아지기 때문에 조건문 사용
            if (body.getInt("totalCount") == 1) {
            	HolidayVO holidayVO = new HolidayVO();
                JSONObject item = body.getJSONObject("items").getJSONObject("item");
                if (item.getString("isHoliday").equals("Y")) { // 공휴일이 맞을 경우
                    String holidayDate = String.valueOf(item.getInt("locdate"));
                    String holidayName = item.getString("dateName");
                    holidayVO.setHolidayDate(holidayDate);
                    holidayVO.setHolidayName(holidayName);
                    result.add(holidayVO);
                }
            } else {
                JSONArray items = body.getJSONObject("items").getJSONArray("item");
                for (Object item : items) { // 해당 월 공휴일 개수
                	HolidayVO holidayVO = new HolidayVO();
                    JSONObject map = new JSONObject(new Gson().toJson(item)).getJSONObject("map");
                    if (map.getString("isHoliday").equals("Y")) { // 공휴일이 맞을 경우
                        String holidayDate = String.valueOf(map.getInt("locdate"));
                        String holidayName = map.getString("dateName");
                        holidayVO.setHolidayDate(holidayDate);
                        holidayVO.setHolidayName(holidayName);
                        result.add(holidayVO);
                    }
                }
            }
        }
        return result;
    }

}

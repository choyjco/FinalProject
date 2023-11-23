package kr.or.ddit.controller.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Controller
public class ImageUpload {
	
	@RequestMapping(value = "/imageUpload.do")
	public String imageUpload(
			HttpServletRequest req, HttpServletResponse resp,
			MultipartHttpServletRequest multiFile
			) throws IOException {
		// CKEditor4 특정 버전 이후부터 html 형식의 데이터를 리턴하는 방법에서 Json 데이터를 구성해서 리턴하는 방식으로 변경됨
		JsonObject json = new JsonObject();	// JSON 객체를 만들기 위한 준비
		PrintWriter printWriter = null;		// 외부 응답으로 내보낼때 사용할 객체
		OutputStream out = null;			// 본문내용에 추가한 이미지 파일로 생성할 객체
		long limitSize = 1024 * 1024 * 5;	// 업로드 파일 최대 크기(5MB)
		
		// CKEditor 본문 내용에 이미지를 업로드 해보면 'upload'라는 키로 파일 데이터가 전달되는걸 확인할 수 있다.
		MultipartFile file = multiFile.getFile("upload");	// 'upload'라는 키로 MultipartFile 타입의 파일 데이터를 꺼낸다.
		
		// 파일 객체가 null이 아니고 파일 사이즈가 0보다 크고 파일명이 공백이 아닌 경우는 무조건 파일 데이터가 존재하는 경우
		if(file != null && file.getSize() > 0 && StringUtils.isNoneBlank(file.getName())) {
			// 데이터 Mime 타입이 'image/'를 포함한 이미지 파일인지 체크
			if(file.getContentType().toLowerCase().startsWith("image/")) {
				// 업로드 한 파일 크기 체크
				if(file.getSize() > limitSize) {	// 최대 크기 5MB 보다 클 때
					/*
					 * {
					 * 		"uploaded" : 0,
					 * 		"error"	: [
					 * 			{
					 * 				"message" : "2MB 미만의 이미지만 업로드 가능합니다."
					 * 			}
					 * 		]
					 * }
					 */
					
					// 에러가 발생했을 때 추력 형태를 위와 같은 형식으로 만든다.
					JsonObject jsonMsg = new JsonObject();
					JsonArray jsonArr = new JsonArray();
					jsonMsg.addProperty("message", "5MB 미만의 이미지만 업로드 가능합니다.");
					jsonArr.add(jsonMsg);
					json.addProperty("uploaded", 0);
					json.add("error", jsonArr.get(0));
					
					// 위 형식의 json 데이터를 출력한다.
					resp.setCharacterEncoding("UTF-8");
					printWriter = resp.getWriter();
					printWriter.println(json);
				}else {
					try {
						String fileName = file.getName();	// 파일명 얻어오기
						byte[] bytes = file.getBytes();		// 파일 데이터 얻어오기
						String uploadPath = req.getServletContext().getRealPath("/resources/img");	// 업로드 경로 설정
						
						// 업로드 경로로 설정된 폴더구조가 존재하지 않는 경우, 파일을 복사할 수 없으므로 폴더 구조가 존재하지 않는 경우 생성하고
						// 존재하는 경우 건너뛰도록 한다.
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()) {
							uploadFile.mkdirs();
						}
						
						fileName = UUID.randomUUID().toString();		// UUID의 random 파일명을 생성한다.
						uploadPath = uploadPath + "/" + fileName + ".jpg";
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);		//파일 복사
						
						printWriter = resp.getWriter();
						
						/*
						 * {
						 * 		"uploaded" : 1,
						 * 		"fileName" : "xxxxxxxx-xxxxxxxx.jpg",
						 * 		"url" : "/resources/img/xxxxxxx-xxxxxxx.jpg"
						 * }
						 */
						String fileUrl = req.getContextPath() + "/resources/img/" + fileName + ".jpg";
						
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						// 위 형식의 json 데이터를 출력한다.
						printWriter.println(json);
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						if(out != null) {
							out.close();
						}
						if(printWriter != null) {
							printWriter.close();
						}
					}
				}
			}
		}
		return null;
	}
}

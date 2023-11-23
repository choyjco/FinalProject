package kr.or.ddit.controller.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.SocketVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebSocketHandler extends TextWebSocketHandler {
		// 소켓에 접속한 인원들을 담기 위한 리스트 객체 생성
		List<SocketVO> socketList = new ArrayList<SocketVO>();
		
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			log.info("afterConnectionEstablished() 실행...!! 클라이언트 서버 접속 연결 성공...! : {}", session);
			log.info("session : {}", session.getId());
			
			// 현재 소켓에 접속한 인원들 리스트에 모두 담는다.
//			CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			SocketVO socketVO = getsocketVO(session);
			if(socketList != null && socketList.size() > 0) {
				for(int i = 0; i < socketList.size(); i++) {
					if(socketVO.getEmpNo().equals(socketList.get(i).getEmpNo())) {	// 세션 중복필터
						socketList.get(i).setSession(session);
						return;
					}
				}
				socketList.add(socketVO);
			}else {
				socketList.add(socketVO);
			}
			log.info("socketList : {}", socketList);
		}


		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			// 1. JSP페이지에서 소켓 이벤트와 비동기 통신이 동시에 일어나는거
			
			// 2. JSP페이지에서 소켓 이벤트로 넘어온 핸들을 처리하고 그안에서 Mapper를 통한 DB처리 일어나는것
			////////////////////////////////////////////////////////////////////////////////////////////////////
			log.info("handleTextMessage() 실행...!! 메세지 전송 시도 성공...!");
			log.info("메세지야 들어오아라..."+ message.getPayload().toString()); 
			
			SocketVO socketVO = getsocketVO(session);
			String senderId = socketVO.getEmpNo();
			log.info("소켓 컨트롤러에서 로그인한 아이디 값 추출 : " + senderId);
			
//			CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			String[] strs = message.getPayload().toString().split(",");
			
			// 메세지가 존재할때 실행
			if(!(message.getPayload().toString() == null || message.getPayload().toString().equals(""))) {
//				if(user.getEmp().getEmpNo().equals(senderId)) {
					// 모든 유저에게 보내기
					
					for(int i = 0; i < socketList.size(); i++) {
						for(int j = 0; j < strs.length-1; j++ ) {
							if(socketList.get(i).getEmpNo().equals(strs[j])) {
								socketList.get(i).getSession().sendMessage(new TextMessage(strs[strs.length-1]));
							}
						}
					}
//				}
			}
			
//			for(WebSocketSession sessionOne : sessionList) {
//				// jsp 페이지에 ws.onmessage로 메세지를 보내준다. 
//				sessionOne.sendMessage(new TextMessage(senderId + " : " + message));
//			}
			
			// protocol: 명령, 댓글작성자, 게시글작성자, 글번호?		(reply, user2, user1, 234)
//			String msg = message.getPayload();
//			if(StringUtils.isNotEmpty(msg)) {
//				String[] strs = msg.split(",");
//				
//				if(strs != null && strs.length == 4) {
//					String alarmCnt = strs[0];
//					String aContent = strs[1];
//					String boardWriter = strs[2];
//					String aNo = strs[3];
					
////////////////////////////////////////////////////////////////////////////////////////////////////
//					WebSocketSession boardWriterSession = session;
//					
//					for(SocketVO socket : socketList) {
//						if(socket.getEmpNo().equals(boardWriter)) {
//							boardWriterSession = socket.getSession();
//						}
//					}
////////////////////////////////////////////////////////////////////////////////////////////////////
					
//					WebSocketSession boardWriterSession = userSessions.get(boardWriter);
//					log.info("boardWriterSession >>>>>>>>>>>>>" + boardWriterSession);
//					if(boardWriterSession != null) {
//						TextMessage tmpMsg = new TextMessage("미확인 알람 갯수 : "+alarmCnt+"<br>"+"<a href='/notice/updateAlarm.do?aNo="+aNo+"'>"+aContent+"</a>");
//						boardWriterSession.sendMessage(tmpMsg);
//					}
//				}
//				
//			}
			
			// 받은 메시지를 
//			super.handleTextMessage(session, message);
		}

		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			log.info("afterConnectionClosed() 실행...!! 서버 연결 종료...! {} : {}", session, status);
			SocketVO socketVO = getsocketVO(session);
			socketList.remove(socketVO);
			
			session.close();
			
		}
		
		private SocketVO getsocketVO(WebSocketSession session) {
			SecurityContextImpl loginUser = null;
			String id = null;
			Map<String, Object> httpSession = session.getAttributes();
			Set<Entry<String, Object>> entrySet = httpSession.entrySet();
			Iterator<Entry<String, Object>> entryIte = entrySet.iterator();
			while(entryIte.hasNext()) {
				Entry<String, Object> entry = entryIte.next();
				String key = entry.getKey();
				log.info("key : " + key);
				if(key.equals("SPRING_SECURITY_CONTEXT")){
					loginUser = (SecurityContextImpl)httpSession.get("SPRING_SECURITY_CONTEXT");
					log.info("loginUser : " + loginUser);
					
				}
			}
			CustomUser user = (CustomUser) loginUser.getAuthentication().getPrincipal();
			log.info("principal id  : " + user.getUsername());
			log.info("member id : " + user.getEmp().getEmpNo());
			
			id =  user.getEmp().getEmpNo();
			if(null == user.getUsername()) {
				id = session.getId();
			}
			
			SocketVO socketVO = new SocketVO();
			socketVO.setSession(session);
			socketVO.setEmpNo(id);
			socketVO.setEmpName(user.getEmp().getEmpName());
			log.info("socketVO : {}", socketVO);
			
			return socketVO;
		}
	
}

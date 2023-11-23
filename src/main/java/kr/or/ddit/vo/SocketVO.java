package kr.or.ddit.vo;

import org.springframework.web.socket.WebSocketSession;

import lombok.Data;

@Data
public class SocketVO {
	private WebSocketSession session;
	private String empNo;
	private String empName;
}

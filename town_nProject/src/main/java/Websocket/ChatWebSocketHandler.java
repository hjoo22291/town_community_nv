package Websocket;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

@Component
public class ChatWebSocketHandler implements WebSocketHandler {
	
	List<WebSocketSession> list = new ArrayList<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//웹소캣 연결 시 1번 실행
		list.add(session);
		System.out.println(session.getRemoteAddress() + "ip에서 접속");
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		//연결 도중 여러번 실행
		//1. 1개 클라이언트 메시지 수신
		String msg = (String)message.getPayload();
		//msg ="{messsg: xxx , sender:xxx}"
		//msg.메소드(마지막글자 ㅅ삭제);
		msg.replace("}", ",\"count\":list.size()}");
		//msg += ",count:list.size +  }"
		//2. 접속된 모든 클라이언트 메시지 송신
		for(WebSocketSession socket : list) {
			WebSocketMessage<String> sendmsg = new TextMessage(msg);
			socket.sendMessage(sendmsg);
		}
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		//오류 처리. 사용 X
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
		//웹소캣 연결 해제 시 1번 실행
		list.remove(session);
		System.out.println(session.getRemoteAddress() + "ip에서 접속해제");
	}

	@Override
	public boolean supportsPartialMessages() {
		//부가정보 생성. 사용 X
		return false;
	}
	
}

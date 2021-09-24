package com.braker.common.webSocket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.OnMessage;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.braker.core.model.User;

/**
 * 
* @Description: 消息处理(仅限于处理待办事项数目的事实更新问题)
* @author zhangxun
* @date 2018-10-30 
 */
public class MyWebSocketHandler implements WebSocketHandler{

	    // 保存所有的用户session
		private static CopyOnWriteArraySet<WebSocketSession> users = new CopyOnWriteArraySet<WebSocketSession>();
		//下面是旧的，总是报错  The WebSocket session [4] has been closed and no method (apart from close()) may be called on a closed session
	   // private static final ArrayList<WebSocketSession> users = new ArrayList<WebSocketSession>();

	    // 连接 就绪时 
	    @Override
	    public void afterConnectionEstablished(WebSocketSession session)
	            throws Exception {
	        users.add(session);
	    }
	    // 处理信息
	    @Override
	    public void handleMessage(WebSocketSession session,
	            WebSocketMessage<?> message) throws Exception {
	    	session.sendMessage(message);
	        /*// 处理消息 msgContent消息内容
	        TextMessage textMessage = new TextMessage(message.getPayload().toString(), true);
	        // 调用方法（发送消息给所有人）
	        sendMsgToAllUsers(textMessage);*/
	    }
	    // 处理传输时异常
	    @Override
	    public void handleTransportError(WebSocketSession session,
	            Throwable exception) throws Exception {
	    }

	    // 关闭 连接时
	    @Override
	    public void afterConnectionClosed(WebSocketSession session,
	            CloseStatus closeStatus) throws Exception {
	        users.remove(session);
	    }

	    @Override
	    public boolean supportsPartialMessages() {
	        return false;
	    }

	    // 给所有用户发送 信息 (暂停使用)
	    public void sendMsgToAllUsers(WebSocketMessage<?> message) throws Exception{
	        for (WebSocketSession user : users) {
	            user.sendMessage(message);
	        }
	    }
	    
	    // 广播信息
	    public boolean sendTest(TextMessage message){
	    	boolean allSendSuccess = true;
	    	for (WebSocketSession user : users) {
	            try {
					user.sendMessage(message);
				} catch (IOException e) {
					e.printStackTrace();
					allSendSuccess = false;
				}
	        }
	    	return allSendSuccess;
	    }
	    
	    //单发信息
	    public boolean sendMessageToUser(String userId, TextMessage message) {
	    	boolean oneSendSuccess = true;
	    	for (WebSocketSession session : users) {
	    		Map<String, Object> map = session.getAttributes();
            	User user = (User) map.get("currentUser");
            	if (user != null && user.getId().equals(userId)) {
            		try {
            			session.sendMessage(message);
            		} catch (IOException e) {
            			e.printStackTrace();
            		}
            	}
	        }
	    	return oneSendSuccess;
	    }
	    
	 // 收到客户端消息后调用的方法 
	    @OnMessage
	    public void onMessage(String message, WebSocketSession session) {  
	        if(message.equals("ping")){
	        	System.out.println("1");
	        }else{
	        	
	        }
	   }
	    
	    /**
	     * 
	    * @author:安达
	    * @Title: checkSessionExists 
	    * @Description:  还在测试中，开发尚未完成
	    * @param userId
	    * @return
	    * @return boolean    返回类型 
	    * @date： 2019年9月4日下午6:06:26 
	    * @throws
	     */
	    private boolean checkSessionExists(String userId){
	    	for (WebSocketSession session : users) {
	    		Map<String, Object> map = session.getAttributes();
            	User user = (User) map.get("currentUser");
            	if (user != null && user.getId().equals(userId)) {
            		return true;
            	}
	    	}
	    	return false;
	    }

}

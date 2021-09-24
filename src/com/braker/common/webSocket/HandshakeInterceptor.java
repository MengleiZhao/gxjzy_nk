package com.braker.common.webSocket;

import java.util.Map;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;
/**
 * 
* @Description: 握手拦截器
* @author zhangxun
* @date 2018-10-30
 */
public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor{
	   // 握手前
    @Override
    public boolean beforeHandshake(ServerHttpRequest request,
            ServerHttpResponse response, WebSocketHandler wsHandler,
            Map<String, Object> attributes) throws Exception {
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }

    // 握手后
    @Override
    public void afterHandshake(ServerHttpRequest request,
            ServerHttpResponse response, WebSocketHandler wsHandler,
            Exception ex) {
        super.afterHandshake(request, response, wsHandler, ex);
    }
}

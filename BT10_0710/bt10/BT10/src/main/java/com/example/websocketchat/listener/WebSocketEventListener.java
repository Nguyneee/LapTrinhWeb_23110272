package com.example.websocketchat.listener;

import com.example.websocketchat.dto.ChatMessageDTO;
import com.example.websocketchat.entity.ChatMessage;
import com.example.websocketchat.entity.User;
import com.example.websocketchat.service.ChatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class WebSocketEventListener {

    private static final Logger logger = LoggerFactory.getLogger(WebSocketEventListener.class);

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;

    @Autowired
    private ChatService chatService;

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

    @EventListener
    public void handleWebSocketConnectListener(SessionConnectedEvent event) {
        logger.info("Received a new web socket connection");
    }

    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

        String username = (String) headerAccessor.getSessionAttributes().get("username");
        User.UserRole role = (User.UserRole) headerAccessor.getSessionAttributes().get("role");

        if (username != null) {
            logger.info("User Disconnected: " + username);

            // Set user offline
            chatService.setUserOnlineStatus(username, false);

            // Create leave message
            ChatMessageDTO chatMessage = new ChatMessageDTO();
            chatMessage.setMessageType(ChatMessage.MessageType.LEAVE);
            chatMessage.setSender(username);
            chatMessage.setSenderRole(role);
            chatMessage.setTimestamp(LocalDateTime.now().format(formatter));

            messagingTemplate.convertAndSend("/topic/public", chatMessage);
        }
    }
}

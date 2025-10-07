package com.example.websocketchat.dto;

import com.example.websocketchat.entity.ChatMessage;
import com.example.websocketchat.entity.User;

public class ChatMessageDTO {
    private String content;
    private String sender;
    private User.UserRole senderRole;
    private String chatRoom;
    private ChatMessage.MessageType messageType;
    private String timestamp;

    // Constructors
    public ChatMessageDTO() {}

    public ChatMessageDTO(String content, String sender, User.UserRole senderRole, String chatRoom) {
        this.content = content;
        this.sender = sender;
        this.senderRole = senderRole;
        this.chatRoom = chatRoom;
        this.messageType = ChatMessage.MessageType.CHAT;
    }

    // Getters and Setters
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public User.UserRole getSenderRole() {
        return senderRole;
    }

    public void setSenderRole(User.UserRole senderRole) {
        this.senderRole = senderRole;
    }

    public String getChatRoom() {
        return chatRoom;
    }

    public void setChatRoom(String chatRoom) {
        this.chatRoom = chatRoom;
    }

    public ChatMessage.MessageType getMessageType() {
        return messageType;
    }

    public void setMessageType(ChatMessage.MessageType messageType) {
        this.messageType = messageType;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}

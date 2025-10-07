package com.example.websocketchat.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "chat_messages")
public class ChatMessage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String content;
    
    @Column(nullable = false)
    private String sender;
    
    @Column(name = "sender_role")
    @Enumerated(EnumType.STRING)
    private User.UserRole senderRole;
    
    @Column(name = "chat_room")
    private String chatRoom;
    
    @Column(name = "message_type")
    @Enumerated(EnumType.STRING)
    private MessageType messageType;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // Constructors
    public ChatMessage() {
        this.createdAt = LocalDateTime.now();
        this.messageType = MessageType.CHAT;
    }

    public ChatMessage(String content, String sender, User.UserRole senderRole, String chatRoom) {
        this();
        this.content = content;
        this.sender = sender;
        this.senderRole = senderRole;
        this.chatRoom = chatRoom;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public MessageType getMessageType() {
        return messageType;
    }

    public void setMessageType(MessageType messageType) {
        this.messageType = messageType;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public enum MessageType {
        CHAT, JOIN, LEAVE
    }
}

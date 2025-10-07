package com.example.websocketchat.service;

import com.example.websocketchat.dto.ChatMessageDTO;
import com.example.websocketchat.entity.ChatMessage;
import com.example.websocketchat.entity.User;
import com.example.websocketchat.repository.ChatMessageRepository;
import com.example.websocketchat.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ChatService {

    @Autowired
    private ChatMessageRepository chatMessageRepository;

    @Autowired
    private UserRepository userRepository;

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");

    public ChatMessage saveMessage(ChatMessageDTO messageDTO) {
        ChatMessage message = new ChatMessage();
        message.setContent(messageDTO.getContent());
        message.setSender(messageDTO.getSender());
        message.setSenderRole(messageDTO.getSenderRole());
        message.setChatRoom(messageDTO.getChatRoom());
        message.setMessageType(messageDTO.getMessageType());
        
        return chatMessageRepository.save(message);
    }

    public List<ChatMessageDTO> getChatHistory(String chatRoom) {
        List<ChatMessage> messages = chatMessageRepository.findByChatRoomOrderByCreatedAtAsc(chatRoom);
        return messages.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    public User createOrGetUser(String username, String displayName, User.UserRole role) {
        return userRepository.findByUsername(username)
                .orElseGet(() -> {
                    User newUser = new User(username, displayName, role);
                    return userRepository.save(newUser);
                });
    }

    public void setUserOnlineStatus(String username, boolean isOnline) {
        userRepository.findByUsername(username)
                .ifPresent(user -> {
                    user.setOnline(isOnline);
                    userRepository.save(user);
                });
    }

    public List<User> getOnlineUsers() {
        return userRepository.findByIsOnlineTrue();
    }

    public List<User> getSupportAgents() {
        return userRepository.findByRole(User.UserRole.SUPPORT_AGENT);
    }

    private ChatMessageDTO convertToDTO(ChatMessage message) {
        ChatMessageDTO dto = new ChatMessageDTO();
        dto.setContent(message.getContent());
        dto.setSender(message.getSender());
        dto.setSenderRole(message.getSenderRole());
        dto.setChatRoom(message.getChatRoom());
        dto.setMessageType(message.getMessageType());
        dto.setTimestamp(message.getCreatedAt().format(formatter));
        return dto;
    }
}

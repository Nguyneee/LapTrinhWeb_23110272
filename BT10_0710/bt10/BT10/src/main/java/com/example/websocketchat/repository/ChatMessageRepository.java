package com.example.websocketchat.repository;

import com.example.websocketchat.entity.ChatMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
    List<ChatMessage> findByChatRoomOrderByCreatedAtAsc(String chatRoom);
    List<ChatMessage> findTop50ByChatRoomOrderByCreatedAtDesc(String chatRoom);
}

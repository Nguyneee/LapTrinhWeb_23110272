'use strict';

let stompClient = null;
let username = null;
let currentChatRoom = 'public';

// DOM Elements
const usernameModal = new bootstrap.Modal(document.getElementById('usernameModal'));
const messageArea = document.getElementById('messageArea');
const messageInput = document.getElementById('messageInput');
const sendButton = document.getElementById('sendButton');
const connectButton = document.getElementById('connectButton');
const usernameInput = document.getElementById('usernameInput');

// Show username modal on page load
window.addEventListener('load', () => {
    usernameModal.show();
});

// Event Listeners
connectButton.addEventListener('click', connect);
sendButton.addEventListener('click', sendMessage);
messageInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        sendMessage();
    }
});

function connect() {
    username = usernameInput.value.trim();
    
    if (username) {
        // Hide modal
        usernameModal.hide();
        
        // Enable input
        messageInput.disabled = false;
        sendButton.disabled = false;
        messageInput.focus();
        
        // Clear welcome message
        messageArea.innerHTML = '';
        
        // Connect to WebSocket
        const socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
        
        stompClient.connect({}, onConnected, onError);
    }
}

function onConnected() {
    console.log('Connected to WebSocket');
    
    // Subscribe to public topic
    stompClient.subscribe('/topic/public', onMessageReceived);
    
    // Tell server about new user
    stompClient.send("/app/chat.addUser", {}, JSON.stringify({
        sender: username,
        senderRole: 'CUSTOMER',
        messageType: 'JOIN'
    }));
    
    addSystemMessage(`Bạn đã tham gia chat với tên "${username}"`);
}

function onError(error) {
    console.error('WebSocket connection error:', error);
    addSystemMessage('Không thể kết nối đến server. Vui lòng thử lại sau.', 'error');
}

function sendMessage() {
    const messageContent = messageInput.value.trim();
    
    if (messageContent && stompClient) {
        const chatMessage = {
            sender: username,
            content: messageContent,
            senderRole: 'CUSTOMER',
            chatRoom: currentChatRoom,
            messageType: 'CHAT'
        };
        
        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
        messageInput.value = '';
    }
}

function onMessageReceived(payload) {
    const message = JSON.parse(payload.body);
    
    if (message.messageType === 'JOIN') {
        if (message.sender !== username) {
            if (message.senderRole === 'SUPPORT_AGENT') {
                addSystemMessage(`Nhân viên hỗ trợ "${message.sender}" đã tham gia chat`);
            } else {
                addSystemMessage(`"${message.sender}" đã tham gia chat`);
            }
        }
    } else if (message.messageType === 'LEAVE') {
        if (message.senderRole === 'SUPPORT_AGENT') {
            addSystemMessage(`Nhân viên hỗ trợ "${message.sender}" đã rời khỏi chat`);
        } else {
            addSystemMessage(`"${message.sender}" đã rời khỏi chat`);
        }
    } else {
        addChatMessage(message);
    }
}

function addChatMessage(message) {
    const messageElement = document.createElement('div');
    messageElement.classList.add('message');
    
    const isOwnMessage = message.sender === username;
    if (isOwnMessage) {
        messageElement.classList.add('own');
    } else {
        messageElement.classList.add('other');
    }
    
    const senderName = message.senderRole === 'SUPPORT_AGENT' 
        ? `${message.sender} (Hỗ trợ)` 
        : message.sender;
    
    messageElement.innerHTML = `
        <div class="message-content">
            ${escapeHtml(message.content)}
            <div class="message-info">
                ${isOwnMessage ? 'Bạn' : senderName} • ${message.timestamp || getCurrentTime()}
            </div>
        </div>
    `;
    
    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;
}

function addSystemMessage(content, type = 'info') {
    const messageElement = document.createElement('div');
    messageElement.classList.add('text-center', 'my-3');
    
    const badgeClass = type === 'error' ? 'bg-danger' : 'bg-info';
    messageElement.innerHTML = `
        <span class="badge ${badgeClass}">
            <i class="fas fa-info-circle"></i> ${escapeHtml(content)}
        </span>
    `;
    
    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function getCurrentTime() {
    return new Date().toLocaleTimeString('vi-VN', {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
    });
}

// Handle page unload
window.addEventListener('beforeunload', () => {
    if (stompClient) {
        stompClient.disconnect();
    }
});

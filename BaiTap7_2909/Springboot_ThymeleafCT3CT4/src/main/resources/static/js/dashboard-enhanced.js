// Enhanced Dashboard JavaScript
document.addEventListener('DOMContentLoaded', function() {
    initializeDashboard();
    startRealTimeClock();
    initializeCharts();
    animateCounters();
    setupEventListeners();
});

// Initialize dashboard
function initializeDashboard() {
    // Add loading states
    showLoadingStates();
    
    // Initialize tooltips
    if (typeof bootstrap !== 'undefined') {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    }
    
    // Add smooth scrolling
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// Show loading states
function showLoadingStates() {
    const counters = document.querySelectorAll('.counter');
    counters.forEach(counter => {
        counter.innerHTML = '<div class="loading-spinner"></div>';
    });
}

// Real-time clock
function startRealTimeClock() {
    function updateClock() {
        const now = new Date();
        const timeString = now.toLocaleTimeString('vi-VN', {
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        });
        
        document.querySelectorAll('.real-time-clock').forEach(el => {
            el.textContent = timeString;
        });
    }
    
    updateClock(); // Initial call
    setInterval(updateClock, 1000);
}

// Enhanced counter animation
function animateCounters() {
    const counters = document.querySelectorAll('.counter');
    
    counters.forEach((counter, index) => {
        const target = parseInt(counter.textContent) || parseInt(counter.dataset.target) || 0;
        
        // Delay animation for staggered effect
        setTimeout(() => {
            animateCounter(counter, target, 1500);
        }, index * 200);
    });
}

function animateCounter(element, target, duration = 1500) {
    const start = 0;
    const startTime = performance.now();
    
    const step = (currentTime) => {
        const progress = Math.min((currentTime - startTime) / duration, 1);
        const easeOutCubic = 1 - Math.pow(1 - progress, 3);
        const current = Math.floor(start + (target - start) * easeOutCubic);
        
        element.textContent = current;
        
        if (progress < 1) {
            requestAnimationFrame(step);
        } else {
            element.textContent = target;
            // Add pulse effect when animation completes
            element.classList.add('pulse');
            setTimeout(() => element.classList.remove('pulse'), 1000);
        }
    };
    
    requestAnimationFrame(step);
}

// Initialize charts
function initializeCharts() {
    initializeAreaChart();
    initializePieChart();
}

function initializeAreaChart() {
    const areaCtx = document.getElementById('areaChart');
    if (!areaCtx) return;
    
    const gradient = areaCtx.getContext('2d').createLinearGradient(0, 0, 0, 320);
    gradient.addColorStop(0, 'rgba(78,115,223,0.35)');
    gradient.addColorStop(1, 'rgba(78,115,223,0.05)');
    
    const gradient2 = areaCtx.getContext('2d').createLinearGradient(0, 0, 0, 320);
    gradient2.addColorStop(0, 'rgba(28,200,138,0.35)');
    gradient2.addColorStop(1, 'rgba(28,200,138,0.05)');
    
    window.areaChart = new Chart(areaCtx, {
        type: 'line',
        data: {
            labels: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
            datasets: [{
                label: 'Danh mục',
                data: [5, 10, 8, 15, 12, 18, 20],
                borderColor: 'rgba(78,115,223,1)',
                backgroundColor: gradient,
                borderWidth: 3,
                fill: true,
                tension: 0.4,
                pointRadius: 5,
                pointBackgroundColor: 'rgba(78,115,223,1)',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointHoverRadius: 7,
                pointHoverBackgroundColor: 'rgba(78,115,223,1)',
                pointHoverBorderColor: '#fff',
                pointHoverBorderWidth: 2
            }, {
                label: 'Người dùng',
                data: [2, 5, 8, 12, 15, 20, 25],
                borderColor: 'rgba(28,200,138,1)',
                backgroundColor: gradient2,
                borderWidth: 3,
                fill: true,
                tension: 0.4,
                pointRadius: 5,
                pointBackgroundColor: 'rgba(28,200,138,1)',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointHoverRadius: 7,
                pointHoverBackgroundColor: 'rgba(28,200,138,1)',
                pointHoverBorderColor: '#fff',
                pointHoverBorderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                    labels: {
                        usePointStyle: true,
                        padding: 20,
                        font: {
                            size: 12,
                            weight: '500'
                        }
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(0,0,0,0.8)',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    borderColor: 'rgba(255,255,255,0.1)',
                    borderWidth: 1,
                    cornerRadius: 8,
                    displayColors: true,
                    intersect: false,
                    mode: 'index'
                }
            },
            interaction: {
                mode: 'index',
                intersect: false
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        font: {
                            size: 11,
                            weight: '500'
                        }
                    }
                },
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0,0,0,0.05)'
                    },
                    ticks: {
                        font: {
                            size: 11,
                            weight: '500'
                        }
                    }
                }
            },
            animation: {
                duration: 2000,
                easing: 'easeInOutQuart'
            }
        }
    });
}

function initializePieChart() {
    const pieCtx = document.getElementById('pieChart');
    if (!pieCtx) return;
    
    window.pieChart = new Chart(pieCtx, {
        type: 'doughnut',
        data: {
            labels: ['Hiển thị', 'Trang chủ', 'Ẩn'],
            datasets: [{
                data: [8, 4, 2],
                backgroundColor: [
                    'rgba(78,115,223,0.85)',
                    'rgba(28,200,138,0.85)',
                    'rgba(255,193,7,0.85)'
                ],
                borderColor: [
                    'rgba(78,115,223,1)',
                    'rgba(28,200,138,1)',
                    'rgba(255,193,7,1)'
                ],
                borderWidth: 2,
                hoverOffset: 10
            }]
        },
        options: {
            maintainAspectRatio: false,
            cutout: '65%',
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: 'rgba(0,0,0,0.8)',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    borderColor: 'rgba(255,255,255,0.1)',
                    borderWidth: 1,
                    cornerRadius: 8,
                    callbacks: {
                        label: function(context) {
                            const label = context.label || '';
                            const value = context.parsed;
                            const total = context.dataset.data.reduce((a, b) => a + b, 0);
                            const percentage = ((value / total) * 100).toFixed(1);
                            return `${label}: ${value} (${percentage}%)`;
                        }
                    }
                }
            },
            animation: {
                animateRotate: true,
                animateScale: true,
                duration: 2000,
                easing: 'easeInOutQuart'
            }
        }
    });
}

// Chart period change
function changeChartPeriod(period) {
    const dataMap = {
        week: {
            categories: [5, 10, 8, 15, 12, 18, 20],
            users: [2, 5, 8, 12, 15, 20, 25]
        },
        month: {
            categories: [50, 65, 45, 80, 70, 90, 85],
            users: [40, 55, 35, 70, 60, 80, 75]
        },
        year: {
            categories: [500, 650, 450, 800, 700, 900, 850],
            users: [400, 550, 350, 700, 600, 800, 750]
        }
    };
    
    // Update button states
    document.querySelectorAll('.btn-outline-light').forEach(btn => {
        btn.classList.remove('active');
    });
    event.target.classList.add('active');
    
    // Update chart data
    if (window.areaChart && dataMap[period]) {
        window.areaChart.data.datasets[0].data = dataMap[period].categories;
        window.areaChart.data.datasets[1].data = dataMap[period].users;
        window.areaChart.update('active');
    }
}

// Refresh dashboard data
function refreshDashboardData() {
    const button = event.target;
    const originalText = button.innerHTML;
    
    // Show loading state
    button.innerHTML = '<div class="loading-spinner me-2"></div>Đang làm mới...';
    button.disabled = true;
    
    // Simulate API call
    setTimeout(() => {
        // Update counters with random changes
        document.querySelectorAll('.counter').forEach(counter => {
            const current = parseInt(counter.textContent) || 0;
            const delta = Math.floor(Math.random() * 5) - 2; // -2 to +2
            const next = Math.max(0, current + delta);
            animateCounter(counter, next, 800);
        });
        
        // Update charts with new data
        if (window.areaChart) {
            const newData = window.areaChart.data.datasets[0].data.map(value => 
                Math.max(0, value + Math.floor(Math.random() * 3) - 1)
            );
            window.areaChart.data.datasets[0].data = newData;
            window.areaChart.data.datasets[1].data = newData.map(value => 
                Math.floor(value * 0.8)
            );
            window.areaChart.update('active');
        }
        
        // Show success notification
        showNotification('Dữ liệu đã được làm mới thành công!', 'success');
        
        // Restore button
        button.innerHTML = originalText;
        button.disabled = false;
    }, 1500);
}

// Check system health
function checkSystemHealth() {
    const button = event.target;
    const originalText = button.innerHTML;
    
    // Show loading state
    button.innerHTML = '<div class="loading-spinner me-2"></div>Đang kiểm tra...';
    button.disabled = true;
    
    // Simulate health check
    setTimeout(() => {
        const isHealthy = Math.random() > 0.2; // 80% chance of being healthy
        
        if (isHealthy) {
            showNotification('Hệ thống hoạt động bình thường!', 'success');
        } else {
            showNotification('Có cảnh báo cần kiểm tra!', 'warning');
        }
        
        // Restore button
        button.innerHTML = originalText;
        button.disabled = false;
    }, 2000);
}

// Notification system
function showNotification(message, type = 'info') {
    const alertClass = {
        'success': 'alert-success',
        'warning': 'alert-warning',
        'error': 'alert-danger',
        'info': 'alert-info'
    }[type] || 'alert-info';
    
    const icon = {
        'success': 'fa-check-circle',
        'warning': 'fa-exclamation-triangle',
        'error': 'fa-times-circle',
        'info': 'fa-info-circle'
    }[type] || 'fa-info-circle';
    
    const notification = document.createElement('div');
    notification.className = `alert ${alertClass} alert-dismissible fade show position-fixed`;
    notification.style.cssText = `
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        border: none;
    `;
    
    notification.innerHTML = `
        <i class="fas ${icon} me-2"></i>${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    // Remove existing notifications
    document.querySelectorAll('.alert.position-fixed').forEach(alert => alert.remove());
    
    // Add new notification
    document.body.appendChild(notification);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        if (notification.parentNode) {
            notification.classList.remove('show');
            setTimeout(() => notification.remove(), 150);
        }
    }, 5000);
}

// Setup event listeners
function setupEventListeners() {
    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey) {
            switch(e.keyCode) {
                case 82: // Ctrl + R
                    e.preventDefault();
                    refreshDashboardData();
                    break;
                case 72: // Ctrl + H
                    e.preventDefault();
                    checkSystemHealth();
                    break;
            }
        }
    });
    
    // Card hover effects
    document.querySelectorAll('.stats-card, .chart-card, .list-card, .activity-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });
    
    // Button click effects
    document.querySelectorAll('.btn-enhanced').forEach(btn => {
        btn.addEventListener('click', function(e) {
            // Create ripple effect
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;
            
            ripple.style.cssText = `
                position: absolute;
                width: ${size}px;
                height: ${size}px;
                left: ${x}px;
                top: ${y}px;
                background: rgba(255,255,255,0.3);
                border-radius: 50%;
                transform: scale(0);
                animation: ripple 0.6s linear;
                pointer-events: none;
            `;
            
            this.style.position = 'relative';
            this.style.overflow = 'hidden';
            this.appendChild(ripple);
            
            setTimeout(() => ripple.remove(), 600);
        });
    });
}

// Add ripple animation CSS
const style = document.createElement('style');
style.textContent = `
    @keyframes ripple {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Auto-refresh functionality
function startAutoRefresh() {
    setInterval(() => {
        // Only refresh if page is visible
        if (!document.hidden) {
            refreshDashboardData();
        }
    }, 30000); // Refresh every 30 seconds
}

// Start auto-refresh when page becomes visible
document.addEventListener('visibilitychange', function() {
    if (!document.hidden) {
        startAutoRefresh();
    }
});

// Initialize auto-refresh
startAutoRefresh();

// Export functions for global access
window.changeChartPeriod = changeChartPeriod;
window.refreshDashboardData = refreshDashboardData;
window.checkSystemHealth = checkSystemHealth;

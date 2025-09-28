/**
 * ECSHOP Admin Dashboard JavaScript
 * Enhanced functionality for the admin interface
 */

(function() {
    'use strict';

    // Global variables
    let notifications = [];
    let darkMode = localStorage.getItem('darkMode') === 'true';
    
    // Initialize when DOM is ready
    document.addEventListener('DOMContentLoaded', function() {
        initializeApp();
    });

    function initializeApp() {
        initializeTooltips();
        initializeSidebar();
        initializeTheme();
        initializeNotifications();
        initializeSearch();
        initializeFormValidation();
        initializeImageUpload();
        initializeDataTables();
        initializeCharts();
        initializeRealTimeUpdates();
        bindEventListeners();
    }

    // Initialize Bootstrap tooltips
    function initializeTooltips() {
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, {
                delay: { show: 500, hide: 100 }
            });
        });
    }

    // Sidebar functionality
    function initializeSidebar() {
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebarToggleTop = document.getElementById('sidebarToggleTop');
        
        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', function() {
                toggleSidebar();
            });
        }
        
        if (sidebarToggleTop) {
            sidebarToggleTop.addEventListener('click', function() {
                toggleSidebar();
            });
        }

        // Auto-collapse sidebar on mobile
        if (window.innerWidth < 768) {
            sidebar?.classList.add('sidebar-collapsed');
        }

        // Handle window resize
        window.addEventListener('resize', function() {
            if (window.innerWidth < 768) {
                sidebar?.classList.add('sidebar-collapsed');
            } else if (window.innerWidth > 768 && !localStorage.getItem('sidebarCollapsed')) {
                sidebar?.classList.remove('sidebar-collapsed');
            }
        });
    }

    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const isCollapsed = sidebar?.classList.contains('sidebar-collapsed');
        
        if (isCollapsed) {
            sidebar.classList.remove('sidebar-collapsed');
            localStorage.removeItem('sidebarCollapsed');
        } else {
            sidebar?.classList.add('sidebar-collapsed');
            localStorage.setItem('sidebarCollapsed', 'true');
        }

        // Update toggle button icon
        const toggleIcon = document.querySelector('#sidebarToggle i');
        if (toggleIcon) {
            toggleIcon.className = isCollapsed ? 'fas fa-angle-left' : 'fas fa-angle-right';
        }

        // Trigger resize event for charts
        setTimeout(() => {
            window.dispatchEvent(new Event('resize'));
        }, 300);
    }

    // Theme management
    function initializeTheme() {
        if (darkMode) {
            document.body.classList.add('dark-mode');
        }

        // Add theme toggle button if not exists
        const topbar = document.querySelector('.topbar .navbar-nav');
        if (topbar && !document.getElementById('themeToggle')) {
            const themeToggle = createThemeToggle();
            topbar.insertBefore(themeToggle, topbar.firstChild);
        }
    }

    function createThemeToggle() {
        const li = document.createElement('li');
        li.className = 'nav-item dropdown no-arrow mx-1';
        
        li.innerHTML = `
            <a class="nav-link" href="#" id="themeToggle" role="button" data-bs-toggle="tooltip" title="Chuyển đổi theme">
                <i class="fas fa-${darkMode ? 'sun' : 'moon'} fa-fw"></i>
            </a>
        `;

        li.querySelector('#themeToggle').addEventListener('click', function(e) {
            e.preventDefault();
            toggleTheme();
        });

        return li;
    }

    function toggleTheme() {
        darkMode = !darkMode;
        document.body.classList.toggle('dark-mode', darkMode);
        localStorage.setItem('darkMode', darkMode);
        
        const themeIcon = document.querySelector('#themeToggle i');
        if (themeIcon) {
            themeIcon.className = `fas fa-${darkMode ? 'sun' : 'moon'} fa-fw`;
        }

        showNotification(
            darkMode ? 'Đã chuyển sang chế độ tối' : 'Đã chuyển sang chế độ sáng',
            'info'
        );
    }

    // Notification system
    function initializeNotifications() {
        createNotificationContainer();
        
        // Check for flash messages
        const flashMessages = document.querySelectorAll('[data-flash-message]');
        flashMessages.forEach(message => {
            const type = message.dataset.flashType || 'info';
            const text = message.dataset.flashMessage;
            showNotification(text, type);
            message.remove();
        });
    }

    function createNotificationContainer() {
        if (document.getElementById('notificationContainer')) return;

        const container = document.createElement('div');
        container.id = 'notificationContainer';
        container.className = 'notification-container';
        container.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            max-width: 400px;
        `;
        document.body.appendChild(container);
    }

    function showNotification(message, type = 'info', duration = 5000) {
        const container = document.getElementById('notificationContainer');
        if (!container) return;

        const notification = document.createElement('div');
        const id = 'notification-' + Date.now();
        notification.id = id;
        notification.className = `alert alert-${type} alert-dismissible fade show notification-item`;
        notification.style.cssText = `
            margin-bottom: 10px;
            animation: slideInRight 0.3s ease-out;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            border: none;
            border-radius: 8px;
        `;

        const icons = {
            success: 'fas fa-check-circle',
            error: 'fas fa-exclamation-circle',
            warning: 'fas fa-exclamation-triangle',
            info: 'fas fa-info-circle'
        };

        notification.innerHTML = `
            <i class="${icons[type] || icons.info} me-2"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;

        container.appendChild(notification);

        // Auto remove after duration
        if (duration > 0) {
            setTimeout(() => {
                removeNotification(id);
            }, duration);
        }

        notifications.push({ id, element: notification });
    }

    function removeNotification(id) {
        const notification = document.getElementById(id);
        if (notification) {
            notification.style.animation = 'slideOutRight 0.3s ease-out';
            setTimeout(() => {
                notification.remove();
                notifications = notifications.filter(n => n.id !== id);
            }, 300);
        }
    }

    // Enhanced search functionality
    function initializeSearch() {
        const searchInput = document.querySelector('.navbar-search input');
        if (!searchInput) return;

        let searchTimeout;
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                performSearch(this.value);
            }, 300);
        });

        // Add search suggestions
        createSearchSuggestions(searchInput);
    }

    function createSearchSuggestions(input) {
        const suggestions = document.createElement('div');
        suggestions.className = 'search-suggestions';
        suggestions.style.cssText = `
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #dee2e6;
            border-top: none;
            border-radius: 0 0 0.375rem 0.375rem;
            max-height: 300px;
            overflow-y: auto;
            z-index: 1000;
            display: none;
        `;

        input.parentElement.style.position = 'relative';
        input.parentElement.appendChild(suggestions);

        input.addEventListener('focus', () => {
            if (input.value.length > 0) {
                suggestions.style.display = 'block';
            }
        });

        document.addEventListener('click', (e) => {
            if (!input.parentElement.contains(e.target)) {
                suggestions.style.display = 'none';
            }
        });
    }

    function performSearch(query) {
        if (query.length < 2) return;

        // Mock search results - in real app, this would be an API call
        const mockResults = [
            { type: 'category', name: 'Son môi', url: '/categories' },
            { type: 'category', name: 'Kem dưỡng da', url: '/categories' },
            { type: 'user', name: 'Admin User', url: '/users' },
            { type: 'setting', name: 'Cài đặt hệ thống', url: '/settings' }
        ];

        const results = mockResults.filter(item => 
            item.name.toLowerCase().includes(query.toLowerCase())
        );

        displaySearchResults(results);
    }

    function displaySearchResults(results) {
        const suggestions = document.querySelector('.search-suggestions');
        if (!suggestions) return;

        if (results.length === 0) {
            suggestions.innerHTML = '<div class="p-3 text-muted">Không tìm thấy kết quả</div>';
        } else {
            suggestions.innerHTML = results.map(result => `
                <a href="${result.url}" class="d-block p-3 text-decoration-none border-bottom">
                    <i class="fas fa-${getIconForType(result.type)} me-2"></i>
                    ${result.name}
                    <small class="text-muted d-block">${result.type}</small>
                </a>
            `).join('');
        }

        suggestions.style.display = 'block';
    }

    function getIconForType(type) {
        const icons = {
            category: 'folder',
            user: 'user',
            product: 'box',
            setting: 'cog'
        };
        return icons[type] || 'search';
    }

    // Form validation enhancements
    function initializeFormValidation() {
        const forms = document.querySelectorAll('.needs-validation');
        forms.forEach(form => {
            enhanceFormValidation(form);
        });
    }

    function enhanceFormValidation(form) {
        const inputs = form.querySelectorAll('input, textarea, select');
        
        inputs.forEach(input => {
            // Real-time validation
            input.addEventListener('blur', () => validateField(input));
            input.addEventListener('input', () => {
                if (input.classList.contains('is-invalid')) {
                    validateField(input);
                }
            });
        });

        form.addEventListener('submit', function(e) {
            e.preventDefault();
            e.stopPropagation();

            let isValid = true;
            inputs.forEach(input => {
                if (!validateField(input)) {
                    isValid = false;
                }
            });

            if (isValid) {
                submitForm(form);
            } else {
                // Focus first invalid field
                const firstInvalid = form.querySelector('.is-invalid');
                if (firstInvalid) {
                    firstInvalid.focus();
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
                showNotification('Vui lòng kiểm tra lại thông tin!', 'error');
            }

            form.classList.add('was-validated');
        });
    }

    function validateField(field) {
        const value = field.value.trim();
        let isValid = true;
        let message = '';

        // Required field validation
        if (field.hasAttribute('required') && !value) {
            isValid = false;
            message = 'Trường này là bắt buộc';
        }

        // Email validation
        if (field.type === 'email' && value) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(value)) {
                isValid = false;
                message = 'Email không hợp lệ';
            }
        }

        // Password validation
        if (field.type === 'password' && value) {
            if (value.length < 6) {
                isValid = false;
                message = 'Mật khẩu phải có ít nhất 6 ký tự';
            }
        }

        // Update field appearance
        if (isValid) {
            field.classList.remove('is-invalid');
            field.classList.add('is-valid');
        } else {
            field.classList.remove('is-valid');
            field.classList.add('is-invalid');
            
            // Update error message
            let feedback = field.parentElement.querySelector('.invalid-feedback');
            if (feedback) {
                feedback.textContent = message;
            }
        }

        return isValid;
    }

    function submitForm(form) {
        const submitBtn = form.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        
        // Add loading state
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
        submitBtn.disabled = true;

        // Simulate form submission (in real app, this would be actual submission)
        setTimeout(() => {
            form.submit();
        }, 1000);
    }

    // Image upload enhancements
    function initializeImageUpload() {
        const imageInputs = document.querySelectorAll('input[type="file"][accept*="image"]');
        imageInputs.forEach(input => {
            enhanceImageUpload(input);
        });
    }

    function enhanceImageUpload(input) {
        const preview = input.closest('.card-body')?.querySelector('.image-preview');
        if (!preview) return;

        // Drag and drop functionality
        preview.addEventListener('dragover', handleDragOver);
        preview.addEventListener('dragleave', handleDragLeave);
        preview.addEventListener('drop', (e) => handleDrop(e, input));

        // File selection
        input.addEventListener('change', () => handleFileSelect(input, preview));

        // Click to select
        preview.addEventListener('click', () => input.click());
    }

    function handleDragOver(e) {
        e.preventDefault();
        e.currentTarget.style.borderColor = '#007bff';
        e.currentTarget.style.backgroundColor = 'rgba(0, 123, 255, 0.1)';
    }

    function handleDragLeave(e) {
        e.preventDefault();
        e.currentTarget.style.borderColor = '#dee2e6';
        e.currentTarget.style.backgroundColor = '#f8f9fa';
    }

    function handleDrop(e, input) {
        e.preventDefault();
        handleDragLeave(e);
        
        const files = e.dataTransfer.files;
        if (files.length > 0) {
            input.files = files;
            handleFileSelect(input, e.currentTarget);
        }
    }

    function handleFileSelect(input, preview) {
        const file = input.files[0];
        if (!file) return;

        // Validate file
        if (!file.type.startsWith('image/')) {
            showNotification('Vui lòng chọn file hình ảnh!', 'error');
            return;
        }

        if (file.size > 2 * 1024 * 1024) {
            showNotification('Kích thước file không được vượt quá 2MB!', 'error');
            return;
        }

        // Show preview
        const reader = new FileReader();
        reader.onload = (e) => {
            preview.innerHTML = `
                <img src="${e.target.result}" alt="Preview" 
                     style="max-width: 100%; max-height: 100%; object-fit: contain; border-radius: 8px;">
                <div class="position-absolute top-0 end-0 p-2">
                    <button type="button" class="btn btn-sm btn-danger rounded-circle remove-image">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
            `;
            
            // Add remove functionality
            preview.querySelector('.remove-image').addEventListener('click', (e) => {
                e.stopPropagation();
                removeImage(input, preview);
            });
        };
        reader.readAsDataURL(file);
    }

    function removeImage(input, preview) {
        input.value = '';
        preview.innerHTML = `
            <div class="text-center text-muted">
                <i class="fas fa-cloud-upload-alt fa-3x mb-3"></i>
                <h6>Kéo thả hoặc click để chọn ảnh</h6>
                <small>Định dạng: JPG, PNG (tối đa 2MB)</small>
            </div>
        `;
    }

    // DataTables enhancement
    function initializeDataTables() {
        const tables = document.querySelectorAll('table.table');
        tables.forEach(table => {
            if (table.rows.length > 1) {
                enhanceTable(table);
            }
        });
    }

    function enhanceTable(table) {
        // Add sorting functionality
        const headers = table.querySelectorAll('th');
        headers.forEach((header, index) => {
            if (!header.classList.contains('no-sort')) {
                header.style.cursor = 'pointer';
                header.innerHTML += ' <i class="fas fa-sort text-muted"></i>';
                header.addEventListener('click', () => sortTable(table, index));
            }
        });

        // Add row hover effects
        const rows = table.querySelectorAll('tbody tr');
        rows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.01)';
                this.style.boxShadow = '0 2px 8px rgba(0,0,0,0.1)';
                this.style.transition = 'all 0.2s ease';
            });
            
            row.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
                this.style.boxShadow = 'none';
            });
        });
    }

    function sortTable(table, column) {
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));
        const isAscending = !table.dataset.sortAsc || table.dataset.sortAsc === 'false';
        
        rows.sort((a, b) => {
            const aVal = a.cells[column].textContent.trim();
            const bVal = b.cells[column].textContent.trim();
            
            const aNum = parseFloat(aVal);
            const bNum = parseFloat(bVal);
            
            if (!isNaN(aNum) && !isNaN(bNum)) {
                return isAscending ? aNum - bNum : bNum - aNum;
            } else {
                return isAscending ? aVal.localeCompare(bVal) : bVal.localeCompare(aVal);
            }
        });
        
        rows.forEach(row => tbody.appendChild(row));
        table.dataset.sortAsc = isAscending;
        
        // Update sort icon
        const headers = table.querySelectorAll('th');
        headers.forEach((header, index) => {
            const icon = header.querySelector('i');
            if (icon) {
                if (index === column) {
                    icon.className = `fas fa-sort-${isAscending ? 'up' : 'down'} text-primary`;
                } else {
                    icon.className = 'fas fa-sort text-muted';
                }
            }
        });
    }

    // Charts initialization
    function initializeCharts() {
        // This would initialize any additional charts beyond what's in dashboard.html
        if (typeof Chart !== 'undefined') {
            Chart.defaults.font.family = 'Inter, sans-serif';
            Chart.defaults.color = '#858796';
        }
    }

    // Real-time updates
    function initializeRealTimeUpdates() {
        // Simulate real-time updates (in real app, this would use WebSockets)
        setInterval(() => {
            updateStats();
        }, 30000); // Update every 30 seconds
    }

    function updateStats() {
        // Update dashboard stats
        const statElements = document.querySelectorAll('[data-stat]');
        statElements.forEach(element => {
            const currentValue = parseInt(element.textContent);
            const change = Math.floor(Math.random() * 3) - 1; // -1, 0, or 1
            const newValue = Math.max(0, currentValue + change);
            
            if (newValue !== currentValue) {
                animateNumber(element, newValue);
            }
        });
    }

    function animateNumber(element, target) {
        const start = parseInt(element.textContent);
        const duration = 1000;
        const startTime = performance.now();
        
        function update(currentTime) {
            const elapsed = currentTime - startTime;
            const progress = Math.min(elapsed / duration, 1);
            
            const current = Math.floor(start + (target - start) * progress);
            element.textContent = current;
            
            if (progress < 1) {
                requestAnimationFrame(update);
            }
        }
        
        requestAnimationFrame(update);
    }

    // Event listeners
    function bindEventListeners() {
        // Confirm delete dialogs
        document.addEventListener('click', function(e) {
            if (e.target.matches('[data-confirm]') || e.target.closest('[data-confirm]')) {
                e.preventDefault();
                const element = e.target.matches('[data-confirm]') ? e.target : e.target.closest('[data-confirm]');
                const message = element.dataset.confirm || 'Bạn có chắc chắn muốn thực hiện hành động này?';
                
                if (confirm(message)) {
                    if (element.tagName === 'A') {
                        window.location.href = element.href;
                    } else if (element.tagName === 'FORM') {
                        element.submit();
                    }
                }
            }
        });

        // Auto-save functionality
        const autoSaveForms = document.querySelectorAll('[data-auto-save]');
        autoSaveForms.forEach(form => {
            let saveTimeout;
            form.addEventListener('input', function() {
                clearTimeout(saveTimeout);
                saveTimeout = setTimeout(() => {
                    autoSaveForm(form);
                }, 2000);
            });
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl+S to save
            if (e.ctrlKey && e.key === 's') {
                e.preventDefault();
                const form = document.querySelector('form');
                if (form) {
                    form.dispatchEvent(new Event('submit'));
                }
            }
            
            // Ctrl+N for new item
            if (e.ctrlKey && e.key === 'n') {
                e.preventDefault();
                const addButton = document.querySelector('[href*="/add"]');
                if (addButton) {
                    window.location.href = addButton.href;
                }
            }
            
            // ESC to close modals
            if (e.key === 'Escape') {
                const openModal = document.querySelector('.modal.show');
                if (openModal) {
                    const modal = bootstrap.Modal.getInstance(openModal);
                    modal?.hide();
                }
            }
        });
    }

    function autoSaveForm(form) {
        const formData = new FormData(form);
        showNotification('Đang tự động lưu...', 'info', 2000);
        
        // In real app, this would send data to server
        setTimeout(() => {
            showNotification('Đã tự động lưu', 'success', 2000);
        }, 1000);
    }

    // Utility functions
    window.ECSHOP = {
        showNotification,
        removeNotification,
        toggleTheme,
        toggleSidebar,
        animateNumber
    };

    // CSS for animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        
        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }
        
        .dark-mode {
            --bs-body-bg: #1a1a1a;
            --bs-body-color: #e9ecef;
            --bs-card-bg: #2d3748;
            --bs-border-color: #4a5568;
        }
        
        .dark-mode .card {
            background-color: var(--bs-card-bg);
            border-color: var(--bs-border-color);
        }
        
        .dark-mode .sidebar {
            background: linear-gradient(180deg, #2d3748 10%, #1a202c 100%);
        }
        
        .dark-mode .topbar {
            background-color: var(--bs-card-bg);
            border-bottom-color: var(--bs-border-color);
        }
        
        .position-absolute {
            position: absolute !important;
        }
        
        .top-0 { top: 0 !important; }
        .end-0 { right: 0 !important; }
    `;
    document.head.appendChild(style);

})();

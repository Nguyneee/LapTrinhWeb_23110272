/**
 * User Management JavaScript
 * Enhanced functionality for user management interface
 */

(function() {
    'use strict';

    // Global variables
    let selectedUsers = [];
    let currentSort = { column: null, direction: 'asc' };
    
    // Initialize when DOM is ready
    document.addEventListener('DOMContentLoaded', function() {
        initializeUserManagement();
    });

    function initializeUserManagement() {
        initializeSelectionHandlers();
        initializeBulkActions();
        initializeStatusToggles();
        initializeSearchAndFilter();
        initializeFormValidation();
        initializeAvatarUpload();
        initializeTableSorting();
        initializeKeyboardShortcuts();
        bindUserEvents();
    }

    // Selection handlers
    function initializeSelectionHandlers() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const userCheckboxes = document.querySelectorAll('.user-checkbox');
        
        if (selectAllCheckbox) {
            selectAllCheckbox.addEventListener('change', function() {
                userCheckboxes.forEach(checkbox => {
                    checkbox.checked = this.checked;
                    updateUserSelection(checkbox);
                });
                updateBulkActionsVisibility();
            });
        }
        
        userCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                updateUserSelection(this);
                updateSelectAllState();
                updateBulkActionsVisibility();
            });
        });
    }

    function updateUserSelection(checkbox) {
        const userId = parseInt(checkbox.value);
        if (checkbox.checked) {
            if (!selectedUsers.includes(userId)) {
                selectedUsers.push(userId);
            }
        } else {
            selectedUsers = selectedUsers.filter(id => id !== userId);
        }
    }

    function updateSelectAllState() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const userCheckboxes = document.querySelectorAll('.user-checkbox');
        const checkedCount = document.querySelectorAll('.user-checkbox:checked').length;
        
        if (selectAllCheckbox) {
            selectAllCheckbox.checked = checkedCount === userCheckboxes.length;
            selectAllCheckbox.indeterminate = checkedCount > 0 && checkedCount < userCheckboxes.length;
        }
    }

    function updateBulkActionsVisibility() {
        const bulkActions = document.querySelector('.bulk-actions');
        const selectedCount = document.getElementById('selectedCount');
        
        if (selectedCount) {
            selectedCount.textContent = selectedUsers.length;
        }
        
        if (bulkActions) {
            if (selectedUsers.length > 0) {
                bulkActions.classList.remove('d-none');
            } else {
                bulkActions.classList.add('d-none');
            }
        }
    }

    // Bulk actions
    function initializeBulkActions() {
        const bulkActivateBtn = document.getElementById('bulkActivate');
        const bulkDeactivateBtn = document.getElementById('bulkDeactivate');
        const bulkDeleteBtn = document.getElementById('bulkDelete');
        
        if (bulkActivateBtn) {
            bulkActivateBtn.addEventListener('click', () => performBulkAction('activate'));
        }
        
        if (bulkDeactivateBtn) {
            bulkDeactivateBtn.addEventListener('click', () => performBulkAction('deactivate'));
        }
        
        if (bulkDeleteBtn) {
            bulkDeleteBtn.addEventListener('click', () => {
                if (confirm(`Bạn có chắc chắn muốn xóa ${selectedUsers.length} người dùng đã chọn?`)) {
                    performBulkAction('delete');
                }
            });
        }
    }

    function performBulkAction(action) {
        if (selectedUsers.length === 0) {
            ECSHOP.showNotification('Vui lòng chọn ít nhất một người dùng!', 'warning');
            return;
        }

        showLoadingOverlay();
        
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/users/bulk-action';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = action;
        form.appendChild(actionInput);
        
        selectedUsers.forEach(id => {
            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'userIds';
            idInput.value = id;
            form.appendChild(idInput);
        });
        
        document.body.appendChild(form);
        
        setTimeout(() => {
            form.submit();
        }, 1000);
    }

    // Status toggles
    function initializeStatusToggles() {
        const statusToggles = document.querySelectorAll('.status-toggle');
        
        statusToggles.forEach(toggle => {
            toggle.addEventListener('change', function() {
                const userId = this.dataset.id;
                const isActive = this.checked;
                const row = this.closest('tr');
                
                // Add loading state
                this.disabled = true;
                row.classList.add('loading-state');
                
                // Send AJAX request
                fetch(`/users/toggle-status/${userId}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                })
                .then(response => response.text())
                .then(data => {
                    this.disabled = false;
                    row.classList.remove('loading-state');
                    
                    if (data === 'success') {
                        row.classList.add('success-state');
                        ECSHOP.showNotification(
                            `Đã ${isActive ? 'kích hoạt' : 'vô hiệu hóa'} người dùng`, 
                            'success'
                        );
                        
                        setTimeout(() => {
                            row.classList.remove('success-state');
                        }, 2000);
                    } else {
                        this.checked = !isActive; // Revert
                        row.classList.add('error-state');
                        ECSHOP.showNotification('Có lỗi xảy ra khi cập nhật trạng thái', 'error');
                        
                        setTimeout(() => {
                            row.classList.remove('error-state');
                        }, 2000);
                    }
                })
                .catch(error => {
                    this.disabled = false;
                    this.checked = !isActive; // Revert
                    row.classList.remove('loading-state');
                    row.classList.add('error-state');
                    ECSHOP.showNotification('Có lỗi xảy ra khi kết nối server', 'error');
                    
                    setTimeout(() => {
                        row.classList.remove('error-state');
                    }, 2000);
                });
            });
        });
    }

    // Search and filter
    function initializeSearchAndFilter() {
        const searchInput = document.querySelector('input[name="keyword"]');
        const roleSelect = document.querySelector('select[name="role"]');
        
        if (searchInput) {
            let searchTimeout;
            searchInput.addEventListener('input', function() {
                clearTimeout(searchTimeout);
                searchTimeout = setTimeout(() => {
                    highlightSearchResults(this.value);
                }, 300);
            });
        }
        
        if (roleSelect) {
            roleSelect.addEventListener('change', function() {
                if (this.value) {
                    highlightRoleFilter(this.value);
                } else {
                    clearHighlights();
                }
            });
        }
    }

    function highlightSearchResults(keyword) {
        if (!keyword || keyword.length < 2) {
            clearHighlights();
            return;
        }
        
        const rows = document.querySelectorAll('.user-row');
        rows.forEach(row => {
            const userInfo = row.querySelector('.user-info');
            const text = userInfo.textContent.toLowerCase();
            
            if (text.includes(keyword.toLowerCase())) {
                row.style.backgroundColor = 'rgba(255, 193, 7, 0.1)';
                row.style.borderLeft = '3px solid #ffc107';
            } else {
                row.style.backgroundColor = '';
                row.style.borderLeft = '';
            }
        });
    }

    function highlightRoleFilter(role) {
        const rows = document.querySelectorAll('.user-row');
        rows.forEach(row => {
            const roleBadge = row.querySelector('.badge');
            const roleText = roleBadge.textContent.toLowerCase();
            
            let matches = false;
            switch(role.toUpperCase()) {
                case 'ADMIN':
                    matches = roleText.includes('admin');
                    break;
                case 'MANAGER':
                    matches = roleText.includes('manager');
                    break;
                case 'USER':
                    matches = roleText.includes('user') && !roleText.includes('admin') && !roleText.includes('manager');
                    break;
            }
            
            if (matches) {
                row.style.backgroundColor = 'rgba(23, 162, 184, 0.1)';
                row.style.borderLeft = '3px solid #17a2b8';
            } else {
                row.style.backgroundColor = '';
                row.style.borderLeft = '';
            }
        });
    }

    function clearHighlights() {
        const rows = document.querySelectorAll('.user-row');
        rows.forEach(row => {
            row.style.backgroundColor = '';
            row.style.borderLeft = '';
        });
    }

    // Form validation enhancements
    function initializeFormValidation() {
        const forms = document.querySelectorAll('.needs-validation');
        
        forms.forEach(form => {
            const inputs = form.querySelectorAll('input, select, textarea');
            
            inputs.forEach(input => {
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
                
                // Check password confirmation
                const password = form.querySelector('#password, #newPassword');
                const confirmPassword = form.querySelector('#confirmPassword, #confirmNewPassword');
                
                if (password && confirmPassword && password.value && password.value !== confirmPassword.value) {
                    confirmPassword.setCustomValidity('Mật khẩu xác nhận không khớp');
                    confirmPassword.classList.add('is-invalid');
                    isValid = false;
                }
                
                if (isValid) {
                    submitUserForm(form);
                } else {
                    const firstInvalid = form.querySelector('.is-invalid');
                    if (firstInvalid) {
                        firstInvalid.focus();
                        firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }
                    ECSHOP.showNotification('Vui lòng kiểm tra lại thông tin!', 'error');
                }
                
                form.classList.add('was-validated');
            });
        });
    }

    function validateField(field) {
        const value = field.value.trim();
        let isValid = true;
        let message = '';

        // Required validation
        if (field.hasAttribute('required') && !value) {
            isValid = false;
            message = 'Trường này là bắt buộc';
        }

        // Specific field validation
        switch(field.id) {
            case 'fullName':
                if (value && value.length < 2) {
                    isValid = false;
                    message = 'Họ tên phải có ít nhất 2 ký tự';
                }
                break;
            case 'username':
                if (value && (value.length < 3 || value.length > 20 || !/^[a-zA-Z0-9_]+$/.test(value))) {
                    isValid = false;
                    message = 'Tên đăng nhập phải từ 3-20 ký tự, chỉ chứa chữ, số và dấu gạch dưới';
                }
                break;
            case 'email':
                if (value && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
                    isValid = false;
                    message = 'Email không hợp lệ';
                }
                break;
            case 'phoneNumber':
                if (value && !/^[0-9+\-\s()]{10,15}$/.test(value)) {
                    isValid = false;
                    message = 'Số điện thoại không hợp lệ';
                }
                break;
            case 'password':
            case 'newPassword':
                if (value && value.length < 6) {
                    isValid = false;
                    message = 'Mật khẩu phải có ít nhất 6 ký tự';
                }
                break;
        }

        // Update field appearance
        if (isValid) {
            field.classList.remove('is-invalid');
            field.classList.add('is-valid');
        } else {
            field.classList.remove('is-valid');
            field.classList.add('is-invalid');
            
            // Update error message
            const feedback = field.parentElement.querySelector('.invalid-feedback');
            if (feedback && message) {
                feedback.textContent = message;
            }
        }

        return isValid;
    }

    function submitUserForm(form) {
        const submitBtn = form.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        
        // Add loading state
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
        submitBtn.disabled = true;
        
        showLoadingOverlay();
        
        // Submit form after delay
        setTimeout(() => {
            form.submit();
        }, 1000);
    }

    // Avatar upload functionality
    function initializeAvatarUpload() {
        const avatarInput = document.getElementById('avatarInput');
        const avatarPreview = document.getElementById('avatarPreview');
        const selectAvatarBtn = document.getElementById('selectAvatarBtn');
        const removeAvatarBtn = document.getElementById('removeAvatarBtn');
        
        if (!avatarInput || !avatarPreview) return;
        
        // Click handlers
        if (selectAvatarBtn) {
            selectAvatarBtn.addEventListener('click', () => avatarInput.click());
        }
        
        avatarPreview.addEventListener('click', () => avatarInput.click());
        
        // Drag and drop
        avatarPreview.addEventListener('dragover', handleDragOver);
        avatarPreview.addEventListener('dragleave', handleDragLeave);
        avatarPreview.addEventListener('drop', (e) => handleDrop(e, avatarInput));
        
        // File selection
        avatarInput.addEventListener('change', () => handleAvatarSelect(avatarInput.files[0]));
        
        // Remove avatar
        if (removeAvatarBtn) {
            removeAvatarBtn.addEventListener('click', removeAvatar);
        }
    }

    function handleDragOver(e) {
        e.preventDefault();
        e.currentTarget.classList.add('dragover');
    }

    function handleDragLeave(e) {
        e.preventDefault();
        e.currentTarget.classList.remove('dragover');
    }

    function handleDrop(e, input) {
        e.preventDefault();
        e.currentTarget.classList.remove('dragover');
        
        const files = e.dataTransfer.files;
        if (files.length > 0) {
            handleAvatarSelect(files[0]);
        }
    }

    function handleAvatarSelect(file) {
        if (!file) return;

        // Validate file
        if (!file.type.startsWith('image/')) {
            ECSHOP.showNotification('Vui lòng chọn file hình ảnh!', 'error');
            return;
        }

        if (file.size > 2 * 1024 * 1024) {
            ECSHOP.showNotification('Kích thước file không được vượt quá 2MB!', 'error');
            return;
        }

        // Show preview
        const reader = new FileReader();
        reader.onload = (e) => {
            const avatarPreview = document.getElementById('avatarPreview');
            const removeAvatarBtn = document.getElementById('removeAvatarBtn');
            
            avatarPreview.innerHTML = `
                <img src="${e.target.result}" alt="Avatar Preview" 
                     style="max-width: 100%; max-height: 100%; object-fit: contain; border-radius: 8px;">
            `;
            
            if (removeAvatarBtn) {
                removeAvatarBtn.classList.remove('d-none');
            }
        };
        reader.readAsDataURL(file);
    }

    function removeAvatar() {
        const avatarInput = document.getElementById('avatarInput');
        const avatarPreview = document.getElementById('avatarPreview');
        const removeAvatarBtn = document.getElementById('removeAvatarBtn');
        
        avatarInput.value = '';
        avatarPreview.innerHTML = `
            <div class="text-center text-muted">
                <i class="fas fa-user-circle fa-5x mb-3"></i>
                <h6>Kéo thả hoặc click để chọn avatar</h6>
                <small>Định dạng: JPG, PNG (tối đa 2MB)</small>
            </div>
        `;
        
        if (removeAvatarBtn) {
            removeAvatarBtn.classList.add('d-none');
        }
    }

    // Table sorting
    function initializeTableSorting() {
        const headers = document.querySelectorAll('#usersTable th');
        
        headers.forEach((header, index) => {
            if (!header.classList.contains('no-sort') && index > 1) { // Skip checkbox and # columns
                header.style.cursor = 'pointer';
                header.innerHTML += ' <i class="fas fa-sort text-muted ms-1"></i>';
                header.addEventListener('click', () => sortTable(index));
            }
        });
    }

    function sortTable(columnIndex) {
        const table = document.getElementById('usersTable');
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr:not(.empty-row)'));
        
        // Determine sort direction
        const isAscending = currentSort.column !== columnIndex || currentSort.direction === 'desc';
        currentSort = { column: columnIndex, direction: isAscending ? 'asc' : 'desc' };
        
        // Sort rows
        rows.sort((a, b) => {
            const aVal = a.cells[columnIndex].textContent.trim().toLowerCase();
            const bVal = b.cells[columnIndex].textContent.trim().toLowerCase();
            
            const aNum = parseFloat(aVal);
            const bNum = parseFloat(bVal);
            
            let comparison;
            if (!isNaN(aNum) && !isNaN(bNum)) {
                comparison = aNum - bNum;
            } else {
                comparison = aVal.localeCompare(bVal);
            }
            
            return isAscending ? comparison : -comparison;
        });
        
        // Update DOM
        rows.forEach(row => tbody.appendChild(row));
        
        // Update sort icons
        updateSortIcons(columnIndex, isAscending);
    }

    function updateSortIcons(activeColumn, isAscending) {
        const headers = document.querySelectorAll('#usersTable th');
        
        headers.forEach((header, index) => {
            const icon = header.querySelector('i');
            if (icon) {
                if (index === activeColumn) {
                    icon.className = `fas fa-sort-${isAscending ? 'up' : 'down'} text-primary ms-1`;
                } else {
                    icon.className = 'fas fa-sort text-muted ms-1';
                }
            }
        });
    }

    // Keyboard shortcuts
    function initializeKeyboardShortcuts() {
        document.addEventListener('keydown', function(e) {
            // Ctrl+A to select all
            if (e.ctrlKey && e.key === 'a' && e.target.tagName !== 'INPUT' && e.target.tagName !== 'TEXTAREA') {
                e.preventDefault();
                const selectAllCheckbox = document.getElementById('selectAll');
                if (selectAllCheckbox) {
                    selectAllCheckbox.checked = true;
                    selectAllCheckbox.dispatchEvent(new Event('change'));
                }
            }
            
            // Delete key to delete selected
            if (e.key === 'Delete' && selectedUsers.length > 0) {
                e.preventDefault();
                if (confirm(`Bạn có chắc chắn muốn xóa ${selectedUsers.length} người dùng đã chọn?`)) {
                    performBulkAction('delete');
                }
            }
            
            // Ctrl+N for new user
            if (e.ctrlKey && e.key === 'n') {
                e.preventDefault();
                window.location.href = '/users/add';
            }
        });
    }

    // Event bindings
    function bindUserEvents() {
        // Delete button handlers
        const deleteButtons = document.querySelectorAll('.delete-btn');
        deleteButtons.forEach(button => {
            button.addEventListener('click', function() {
                const userId = this.dataset.id;
                const userName = this.dataset.name;
                
                showDeleteConfirmation(userId, userName);
            });
        });
        
        // Row hover effects
        const userRows = document.querySelectorAll('.user-row');
        userRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(5px)';
                this.style.boxShadow = '0 2px 8px rgba(0,0,0,0.1)';
            });
            
            row.addEventListener('mouseleave', function() {
                this.style.transform = 'translateX(0)';
                this.style.boxShadow = 'none';
            });
        });
    }

    // Utility functions
    function showDeleteConfirmation(userId, userName) {
        const modal = document.getElementById('deleteModal');
        if (modal) {
            document.getElementById('deleteItemName').textContent = userName;
            document.getElementById('confirmDeleteBtn').href = `/users/delete/${userId}`;
            new bootstrap.Modal(modal).show();
        } else {
            if (confirm(`Bạn có chắc chắn muốn xóa người dùng ${userName}?`)) {
                window.location.href = `/users/delete/${userId}`;
            }
        }
    }

    function showLoadingOverlay() {
        let overlay = document.getElementById('loadingOverlay');
        if (!overlay) {
            overlay = document.createElement('div');
            overlay.id = 'loadingOverlay';
            overlay.className = 'loading-overlay';
            overlay.innerHTML = `
                <div class="text-center text-white">
                    <div class="loading-spinner mb-3"></div>
                    <h5>Đang xử lý...</h5>
                </div>
            `;
            document.body.appendChild(overlay);
        }
        
        overlay.classList.add('show');
    }

    function hideLoadingOverlay() {
        const overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            overlay.classList.remove('show');
        }
    }

    // Password strength checker
    function checkPasswordStrength(password) {
        let score = 0;
        
        if (password.length >= 8) score += 1;
        if (password.length >= 12) score += 1;
        if (/[a-z]/.test(password)) score += 1;
        if (/[A-Z]/.test(password)) score += 1;
        if (/[0-9]/.test(password)) score += 1;
        if (/[^A-Za-z0-9]/.test(password)) score += 1;
        
        return Math.min(score, 4);
    }

    function updatePasswordStrength(strength) {
        const strengthFill = document.getElementById('strengthFill');
        const strengthText = document.getElementById('strengthText');
        
        if (!strengthFill || !strengthText) return;
        
        const classes = ['strength-weak', 'strength-fair', 'strength-good', 'strength-strong'];
        const texts = ['Yếu', 'Trung bình', 'Tốt', 'Mạnh'];
        const colors = ['#dc3545', '#fd7e14', '#ffc107', '#28a745'];
        
        strengthFill.className = 'strength-fill';
        if (strength > 0) {
            strengthFill.classList.add(classes[strength - 1]);
            strengthText.textContent = `Mật khẩu ${texts[strength - 1]}`;
            strengthText.style.color = colors[strength - 1];
        } else {
            strengthText.textContent = 'Nhập mật khẩu để kiểm tra độ mạnh';
            strengthText.style.color = '#6c757d';
        }
    }

    // Export functions
    window.exportUsers = function() {
        ECSHOP.showNotification('Đang chuẩn bị file Excel...', 'info');
        
        // Simulate export process
        setTimeout(() => {
            ECSHOP.showNotification('File Excel đã được tạo thành công!', 'success');
            // In real app, this would trigger download
        }, 2000);
    };

    window.printUsers = function() {
        window.print();
    };

    // Add to global ECSHOP object
    if (window.ECSHOP) {
        window.ECSHOP.userManagement = {
            selectedUsers,
            performBulkAction,
            showLoadingOverlay,
            hideLoadingOverlay,
            checkPasswordStrength,
            updatePasswordStrength
        };
    }

    // Initialize password strength checker if on add/edit page
    const passwordInput = document.getElementById('password') || document.getElementById('newPassword');
    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            const strength = checkPasswordStrength(this.value);
            updatePasswordStrength(strength);
        });
    }

})();

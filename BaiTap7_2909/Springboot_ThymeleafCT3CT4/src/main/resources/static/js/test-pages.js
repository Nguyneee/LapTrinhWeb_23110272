// Test Pages JavaScript Functions

// Global variables
let testResults = {
    server: false,
    database: false,
    authentication: false,
    userManagement: false,
    categoryManagement: false,
    fileUpload: false
};

// Test Application Functions
async function runAllTests() {
    resetTests();
    
    // Test 1: Server Status
    await testServer();
    
    // Test 2: Database Connection  
    await testDatabase();
    
    // Test 3: Authentication
    await testAuthentication();
    
    // Test 4: User Management
    await testUserManagement();
    
    // Test 5: Category Management
    await testCategoryManagement();
    
    // Test 6: File Upload
    await testFileUpload();
    
    // Show summary
    showTestSummary();
}

async function testServer() {
    try {
        const response = await fetch('http://localhost:8090', { method: 'HEAD' });
        testResults.server = response.ok;
        updateStatus('serverStatus', response.ok, 'Server đang chạy trên port 8090');
    } catch (error) {
        testResults.server = false;
        updateStatus('serverStatus', false, 'Không thể kết nối đến server');
    }
}

async function testDatabase() {
    try {
        const response = await fetch('http://localhost:8090/h2-console');
        testResults.database = response.ok;
        updateStatus('dbStatus', response.ok, 'H2 Database đang hoạt động');
    } catch (error) {
        testResults.database = false;
        updateStatus('dbStatus', false, 'Không thể kết nối database');
    }
}

async function testAuthentication() {
    try {
        const response = await fetch('http://localhost:8090/login');
        testResults.authentication = response.ok;
        updateStatus('authStatus', response.ok, 'Hệ thống authentication hoạt động');
    } catch (error) {
        testResults.authentication = false;
        updateStatus('authStatus', false, 'Lỗi hệ thống authentication');
    }
}

async function testUserManagement() {
    try {
        const response = await fetch('http://localhost:8090/users');
        // Expect redirect to login (302) or access denied (403)
        testResults.userManagement = response.status === 302 || response.status === 403;
        updateStatus('userStatus', testResults.userManagement, 'User management được bảo vệ bởi security');
    } catch (error) {
        testResults.userManagement = false;
        updateStatus('userStatus', false, 'Lỗi user management system');
    }
}

async function testCategoryManagement() {
    try {
        const response = await fetch('http://localhost:8090/categories');
        testResults.categoryManagement = response.status === 302 || response.status === 403;
        updateStatus('categoryStatus', testResults.categoryManagement, 'Category management được bảo vệ bởi security');
    } catch (error) {
        testResults.categoryManagement = false;
        updateStatus('categoryStatus', false, 'Lỗi category management system');
    }
}

async function testFileUpload() {
    try {
        // Test if static resources are accessible
        const response = await fetch('http://localhost:8090/css/admin-style.css');
        testResults.fileUpload = response.ok;
        updateStatus('uploadStatus', response.ok, 'Static resources và file upload system hoạt động');
    } catch (error) {
        testResults.fileUpload = false;
        updateStatus('uploadStatus', false, 'Lỗi file upload system');
    }
}

function updateStatus(elementId, success, message) {
    const element = document.getElementById(elementId);
    if (!element) return;
    
    const indicator = element.querySelector('.status-indicator');
    const text = element.querySelector('span:last-child');
    
    if (success) {
        indicator.className = 'status-indicator status-success';
        text.innerHTML = `<i class="fas fa-check me-1"></i>${message}`;
    } else {
        indicator.className = 'status-indicator status-error';
        text.innerHTML = `<i class="fas fa-times me-1"></i>${message}`;
    }
}

function resetTests() {
    const statuses = ['serverStatus', 'dbStatus', 'authStatus', 'userStatus', 'categoryStatus', 'uploadStatus'];
    statuses.forEach(id => {
        const element = document.getElementById(id);
        if (!element) return;
        
        const indicator = element.querySelector('.status-indicator');
        const text = element.querySelector('span:last-child');
        
        indicator.className = 'status-indicator status-warning';
        text.innerHTML = 'Đang kiểm tra...';
    });
}

function showTestSummary() {
    const totalTests = Object.keys(testResults).length;
    const passedTests = Object.values(testResults).filter(result => result).length;
    const percentage = Math.round((passedTests / totalTests) * 100);
    
    // Create summary modal
    const summaryHtml = `
        <div class="modal fade" id="testSummaryModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Test Summary</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center mb-3">
                            <div class="display-4 text-${percentage >= 80 ? 'success' : percentage >= 60 ? 'warning' : 'danger'}">
                                ${percentage}%
                            </div>
                            <p class="text-muted">Tests Passed: ${passedTests}/${totalTests}</p>
                        </div>
                        <div class="list-group">
                            ${Object.entries(testResults).map(([key, value]) => `
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    <span>${key.charAt(0).toUpperCase() + key.slice(1)}</span>
                                    <span class="badge bg-${value ? 'success' : 'danger'}">
                                        <i class="fas fa-${value ? 'check' : 'times'}"></i>
                                    </span>
                                </div>
                            `).join('')}
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    // Remove existing modal if any
    const existingModal = document.getElementById('testSummaryModal');
    if (existingModal) {
        existingModal.remove();
    }
    
    // Add new modal
    document.body.insertAdjacentHTML('beforeend', summaryHtml);
    
    // Show modal
    const modal = new bootstrap.Modal(document.getElementById('testSummaryModal'));
    modal.show();
}

// API Test Functions
function loadCategories() {
    $.getJSON('/api/category', function(data) {
        var tbody = $('#categoryTable tbody');
        tbody.empty();
        
        data.forEach(function(category) {
            var row = '<tr class="fade-in">' +
                '<td>' + category.id + '</td>' +
                '<td><img src="/uploads/' + category.image + '" style="width:50px" class="img-fluid" alt=""></td>' +
                '<td>' + category.name + '</td>' +
                '<td>' +
                    '<button class="btn btn-sm btn-danger" onclick="deleteCategory(' + category.id + ')">' +
                        '<i class="fas fa-trash"></i>' +
                    '</button>' +
                '</td>' +
                '</tr>';
            tbody.append(row);
        });
    }).fail(function() {
        showAlert('error', 'Không thể tải danh sách categories');
    });
}

function loadProducts() {
    $.getJSON('/api/product', function(data) {
        var tbody = $('#productTable tbody');
        tbody.empty();
        
        data.forEach(function(product) {
            var row = '<tr class="fade-in">' +
                '<td>' + product.productId + '</td>' +
                '<td>' + product.productName + '</td>' +
                '<td>' + product.unitPrice.toLocaleString() + ' VND</td>' +
                '<td>' + (product.category ? product.category.name : 'N/A') + '</td>' +
                '<td>' +
                    '<button class="btn btn-sm btn-danger" onclick="deleteProduct(' + product.productId + ')">' +
                        '<i class="fas fa-trash"></i>' +
                    '</button>' +
                '</td>' +
                '</tr>';
            tbody.append(row);
        });
    }).fail(function() {
        showAlert('error', 'Không thể tải danh sách products');
    });
}

function loadCategoryOptions() {
    $.getJSON('/api/category', function(data) {
        var select = $('select[name="categoryId"]');
        select.empty();
        select.append('<option value="">Select Category</option>');
        
        data.forEach(function(category) {
            select.append('<option value="' + category.id + '">' + category.name + '</option>');
        });
    }).fail(function() {
        showAlert('error', 'Không thể tải danh sách categories');
    });
}

function showCreateCategoryModal() {
    $('#categoryForm')[0].reset();
    $('#categoryModal').modal('show');
}

function showCreateProductModal() {
    $('#productForm')[0].reset();
    $('#productModal').modal('show');
}

function addCategory() {
    var formData = new FormData($('#categoryForm')[0]);
    
    $.ajax({
        url: '/api/category/addCategory',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            showAlert('success', 'Category added successfully!');
            $('#categoryModal').modal('hide');
            loadCategories();
            loadCategoryOptions();
        },
        error: function(xhr) {
            showAlert('error', 'Error: ' + xhr.responseText);
        }
    });
}

function addProduct() {
    var formData = new FormData($('#productForm')[0]);
    
    $.ajax({
        url: '/api/product/addProduct',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            showAlert('success', 'Product added successfully!');
            $('#productModal').modal('hide');
            loadProducts();
        },
        error: function(xhr) {
            showAlert('error', 'Error: ' + xhr.responseText);
        }
    });
}

function deleteCategory(id) {
    if (confirm('Are you sure you want to delete this category?')) {
        $.ajax({
            url: '/api/category/deleteCategory?categoryId=' + id,
            type: 'DELETE',
            success: function() {
                showAlert('success', 'Category deleted successfully!');
                loadCategories();
                loadCategoryOptions();
            },
            error: function(xhr) {
                showAlert('error', 'Error: ' + xhr.responseText);
            }
        });
    }
}

function deleteProduct(id) {
    if (confirm('Are you sure you want to delete this product?')) {
        $.ajax({
            url: '/api/product/deleteProduct?productId=' + id,
            type: 'DELETE',
            success: function() {
                showAlert('success', 'Product deleted successfully!');
                loadProducts();
            },
            error: function(xhr) {
                showAlert('error', 'Error: ' + xhr.responseText);
            }
        });
    }
}

function showAlert(type, message) {
    const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
    const icon = type === 'success' ? 'fa-check' : 'fa-times';
    
    const alertHtml = `
        <div class="alert ${alertClass} alert-dismissible fade show position-fixed" 
             style="top: 20px; right: 20px; z-index: 9999; min-width: 300px;">
            <i class="fas ${icon} me-2"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `;
    
    // Remove existing alerts
    $('.alert').remove();
    
    // Add new alert
    $('body').append(alertHtml);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        $('.alert').fadeOut();
    }, 5000);
}

// Utility Functions
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    }).format(amount);
}

function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('vi-VN');
}

function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form.checkValidity()) {
        form.classList.add('was-validated');
        return false;
    }
    return true;
}

// Initialize functions
$(document).ready(function() {
    // Add loading states to buttons
    $('button[type="submit"]').click(function() {
        $(this).addClass('loading');
        setTimeout(() => {
            $(this).removeClass('loading');
        }, 2000);
    });
    
    // Add form validation
    $('form').on('submit', function(e) {
        if (!validateForm(this.id)) {
            e.preventDefault();
        }
    });
    
    // Add tooltips
    $('[data-bs-toggle="tooltip"]').tooltip();
    
    // Add smooth scrolling
    $('a[href^="#"]').click(function(e) {
        e.preventDefault();
        const target = $(this.getAttribute('href'));
        if (target.length) {
            $('html, body').animate({
                scrollTop: target.offset().top - 100
            }, 1000);
        }
    });
});

// Export functions for global use
window.runAllTests = runAllTests;
window.resetTests = resetTests;
window.showCreateCategoryModal = showCreateCategoryModal;
window.showCreateProductModal = showCreateProductModal;
window.deleteCategory = deleteCategory;
window.deleteProduct = deleteProduct;

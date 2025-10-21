<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    </div> <!-- End main-content -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Show notification popup if message exists
        <c:if test="${not empty sessionScope.message}">
            Swal.fire({
                icon: '${sessionScope.messageType == "success" ? "success" : sessionScope.messageType == "danger" ? "error" : sessionScope.messageType == "warning" ? "warning" : "info"}',
                title: '${sessionScope.messageType == "success" ? "Thành công!" : sessionScope.messageType == "danger" ? "Lỗi!" : sessionScope.messageType == "warning" ? "Cảnh báo!" : "Thông báo"}',
                html: '${sessionScope.message}',
                confirmButtonText: 'OK',
                confirmButtonColor: '#ff6b35',
                timer: 5000,
                timerProgressBar: true
            });
            <c:remove var="message" scope="session"/>
            <c:remove var="messageType" scope="session"/>
        </c:if>
    </script>
</body>
</html>




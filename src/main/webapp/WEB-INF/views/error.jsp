<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="common/header.jsp" %>

<div class="card">
    <div class="card-header">
        <h2 style="color: #e74c3c;">오류가 발생했습니다</h2>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    <strong>오류 메시지:</strong> ${errorMessage}
                </div>
            </c:when>
            <c:when test="${not empty exception}">
                <div class="alert alert-danger">
                    <strong>오류 유형:</strong> ${exception.class.simpleName}<br>
                    <strong>오류 메시지:</strong> ${exception.message}
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning">
                    <strong>알 수 없는 오류가 발생했습니다.</strong>
                </div>
            </c:otherwise>
        </c:choose>
        
        <c:if test="${not empty url}">
            <p><strong>요청 URL:</strong> ${url}</p>
        </c:if>
        
        <h3>해결 방법</h3>
        <ul>
            <li>데이터베이스 연결을 확인해주세요.</li>
            <li>입력한 정보가 올바른지 확인해주세요.</li>
            <li>문제가 지속되면 관리자에게 문의하세요.</li>
        </ul>
    </div>
    <div class="card-footer">
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">홈으로 돌아가기</a>
        <button onclick="history.back()" class="btn btn-secondary">이전 페이지</button>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
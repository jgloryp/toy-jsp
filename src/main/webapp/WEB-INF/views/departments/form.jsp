<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="form-container">
    <h2>
        <c:choose>
            <c:when test="${empty department.id}">새 학과 등록</c:when>
            <c:otherwise>학과 정보 수정</c:otherwise>
        </c:choose>
    </h2>
    
    <form method="post" action="${pageContext.request.contextPath}/departments<c:if test='${not empty department.id}'>/${department.id}</c:if>">
        <div class="form-group">
            <label for="name">학과명 *</label>
            <input type="text" id="name" name="name" value="${department.name}" required 
                   placeholder="예: 컴퓨터공학과" maxlength="100">
        </div>
        
        <div class="form-group">
            <label for="description">설명</label>
            <textarea id="description" name="description" rows="4" 
                      placeholder="학과에 대한 설명을 입력하세요">${department.description}</textarea>
        </div>
        
        <div class="form-group">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${empty department.id}">등록</c:when>
                    <c:otherwise>수정</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/departments" class="btn btn-secondary">취소</a>
            <c:if test="${not empty department.id}">
                <a href="${pageContext.request.contextPath}/departments/${department.id}" class="btn btn-secondary">상세보기</a>
            </c:if>
        </div>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
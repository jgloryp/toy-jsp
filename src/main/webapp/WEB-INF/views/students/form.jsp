<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="form-container">
    <h2>
        <c:choose>
            <c:when test="${empty student.id}">새 학생 등록</c:when>
            <c:otherwise>학생 정보 수정</c:otherwise>
        </c:choose>
    </h2>
    
    <form method="post" action="${pageContext.request.contextPath}/students<c:if test='${not empty student.id}'>/${student.id}</c:if>">
        <div class="form-group">
            <label for="name">이름 *</label>
            <input type="text" id="name" name="name" value="${student.name}" required 
                   placeholder="학생 이름을 입력하세요" maxlength="100">
        </div>
        
        <div class="form-group">
            <label for="email">이메일 *</label>
            <input type="email" id="email" name="email" value="${student.email}" required 
                   placeholder="example@domain.com" maxlength="100">
        </div>
        
        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="tel" id="phone" name="phone" value="${student.phone}" 
                   placeholder="010-1234-5678" maxlength="20">
        </div>
        
        <div class="form-group">
            <label for="departmentId">소속 학과 *</label>
            <select id="departmentId" name="departmentId" required>
                <option value="">학과를 선택하세요</option>
                <c:forEach var="department" items="${departments}">
                    <option value="${department.id}" 
                            <c:if test="${department.id == student.departmentId}">selected</c:if>>
                        ${department.name}
                    </option>
                </c:forEach>
            </select>
        </div>
        
        <div class="form-group">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${empty student.id}">등록</c:when>
                    <c:otherwise>수정</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">취소</a>
            <c:if test="${not empty student.id}">
                <a href="${pageContext.request.contextPath}/students/${student.id}" class="btn btn-secondary">상세보기</a>
            </c:if>
        </div>
    </form>
</div>

<script>
    // 전화번호 입력 포맷팅
    document.getElementById('phone').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length >= 3 && value.length <= 7) {
            value = value.replace(/(\d{3})(\d{0,4})/, '$1-$2');
        } else if (value.length > 7) {
            value = value.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3');
        }
        e.target.value = value;
    });
</script>

<%@ include file="../common/footer.jsp" %>
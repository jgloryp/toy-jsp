<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="form-container">
    <h2>
        <c:choose>
            <c:when test="${empty course.id}">새 과목 등록</c:when>
            <c:otherwise>과목 정보 수정</c:otherwise>
        </c:choose>
    </h2>
    
    <form method="post" action="${pageContext.request.contextPath}/courses<c:if test='${not empty course.id}'>/${course.id}</c:if>">
        <div class="form-group">
            <label for="name">과목명 *</label>
            <input type="text" id="name" name="name" value="${course.name}" required 
                   placeholder="예: 데이터구조" maxlength="100">
        </div>
        
        <div class="form-group">
            <label for="code">과목코드 *</label>
            <input type="text" id="code" name="code" value="${course.code}" required 
                   placeholder="예: CS101" maxlength="10" style="text-transform: uppercase;">
        </div>
        
        <div class="form-group">
            <label for="credits">학점 *</label>
            <select id="credits" name="credits" required>
                <option value="">학점을 선택하세요</option>
                <option value="1" <c:if test="${course.credits == 1}">selected</c:if>>1학점</option>
                <option value="2" <c:if test="${course.credits == 2}">selected</c:if>>2학점</option>
                <option value="3" <c:if test="${course.credits == 3}">selected</c:if>>3학점</option>
                <option value="4" <c:if test="${course.credits == 4}">selected</c:if>>4학점</option>
                <option value="5" <c:if test="${course.credits == 5}">selected</c:if>>5학점</option>
                <option value="6" <c:if test="${course.credits == 6}">selected</c:if>>6학점</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="description">과목 설명</label>
            <textarea id="description" name="description" rows="4" 
                      placeholder="과목에 대한 설명을 입력하세요">${course.description}</textarea>
        </div>
        
        <div class="form-group">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${empty course.id}">등록</c:when>
                    <c:otherwise>수정</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary">취소</a>
            <c:if test="${not empty course.id}">
                <a href="${pageContext.request.contextPath}/courses/${course.id}" class="btn btn-secondary">상세보기</a>
            </c:if>
        </div>
    </form>
</div>

<script>
    // 과목코드 자동 대문자 변환
    document.getElementById('code').addEventListener('input', function(e) {
        e.target.value = e.target.value.toUpperCase();
    });
</script>

<%@ include file="../common/footer.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="form-container">
    <h2>
        <c:choose>
            <c:when test="${empty enrollment.id}">새 수강신청</c:when>
            <c:otherwise>수강신청 정보 수정</c:otherwise>
        </c:choose>
    </h2>
    
    <form method="post" action="${pageContext.request.contextPath}/enrollments<c:if test='${not empty enrollment.id}'>/${enrollment.id}</c:if>">
        <div class="form-group">
            <label for="studentId">학생 *</label>
            <select id="studentId" name="studentId" required <c:if test="${not empty enrollment.id}">disabled</c:if>>
                <option value="">학생을 선택하세요</option>
                <c:forEach var="student" items="${students}">
                    <option value="${student.id}" 
                            <c:if test="${student.id == enrollment.studentId}">selected</c:if>>
                        ${student.name} (${student.email})
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty enrollment.id}">
                <input type="hidden" name="studentId" value="${enrollment.studentId}">
                <small style="color: #7f8c8d;">수정 시에는 학생을 변경할 수 없습니다.</small>
            </c:if>
        </div>
        
        <div class="form-group">
            <label for="courseId">과목 *</label>
            <select id="courseId" name="courseId" required <c:if test="${not empty enrollment.id}">disabled</c:if>>
                <option value="">과목을 선택하세요</option>
                <c:forEach var="course" items="${courses}">
                    <option value="${course.id}" 
                            <c:if test="${course.id == enrollment.courseId}">selected</c:if>>
                        ${course.name} (${course.code}) - ${course.credits}학점
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty enrollment.id}">
                <input type="hidden" name="courseId" value="${enrollment.courseId}">
                <small style="color: #7f8c8d;">수정 시에는 과목을 변경할 수 없습니다.</small>
            </c:if>
        </div>
        
        <div class="form-group">
            <label for="enrollmentDate">수강신청일 *</label>
            <input type="date" id="enrollmentDate" name="enrollmentDate" required
                   value="${enrollment.enrollmentDate}">
        </div>
        
        <div class="form-group">
            <label for="grade">성적</label>
            <select id="grade" name="grade">
                <option value="">성적 선택 (선택사항)</option>
                <option value="A+" <c:if test="${enrollment.grade == 'A+'}">selected</c:if>>A+</option>
                <option value="A" <c:if test="${enrollment.grade == 'A'}">selected</c:if>>A</option>
                <option value="A-" <c:if test="${enrollment.grade == 'A-'}">selected</c:if>>A-</option>
                <option value="B+" <c:if test="${enrollment.grade == 'B+'}">selected</c:if>>B+</option>
                <option value="B" <c:if test="${enrollment.grade == 'B'}">selected</c:if>>B</option>
                <option value="B-" <c:if test="${enrollment.grade == 'B-'}">selected</c:if>>B-</option>
                <option value="C+" <c:if test="${enrollment.grade == 'C+'}">selected</c:if>>C+</option>
                <option value="C" <c:if test="${enrollment.grade == 'C'}">selected</c:if>>C</option>
                <option value="C-" <c:if test="${enrollment.grade == 'C-'}">selected</c:if>>C-</option>
                <option value="D+" <c:if test="${enrollment.grade == 'D+'}">selected</c:if>>D+</option>
                <option value="D" <c:if test="${enrollment.grade == 'D'}">selected</c:if>>D</option>
                <option value="F" <c:if test="${enrollment.grade == 'F'}">selected</c:if>>F</option>
            </select>
        </div>
        
        <div class="form-group">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${empty enrollment.id}">등록</c:when>
                    <c:otherwise>수정</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/enrollments" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>

<script>
    // 오늘 날짜를 기본값으로 설정 (신규 등록 시에만)
    <c:if test="${empty enrollment.id}">
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            const enrollmentDateInput = document.getElementById('enrollmentDate');
            if (!enrollmentDateInput.value) {
                enrollmentDateInput.value = today;
            }
        });
    </c:if>
</script>

<%@ include file="../common/footer.jsp" %>
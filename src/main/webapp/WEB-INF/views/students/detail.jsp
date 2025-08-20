<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header">
        <h2>${student.name} 학생 상세정보</h2>
    </div>
    <div class="card-body">
        <div class="detail-item">
            <div class="detail-label">학생 ID</div>
            <div class="detail-value">${student.id}</div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">이름</div>
            <div class="detail-value">${student.name}</div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">이메일</div>
            <div class="detail-value">${student.email}</div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">전화번호</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${empty student.phone}">
                        <span style="color: #7f8c8d; font-style: italic;">등록되지 않음</span>
                    </c:when>
                    <c:otherwise>
                        ${student.phone}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">소속 학과</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${not empty student.department}">
                        <a href="${pageContext.request.contextPath}/departments/${student.department.id}" 
                           style="text-decoration: none; color: #27ae60; font-weight: bold;">
                            ${student.department.name}
                        </a>
                        <c:if test="${not empty student.department.description}">
                            <br><small style="color: #7f8c8d;">${student.department.description}</small>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <span style="color: #e74c3c;">학과 정보 없음 (ID: ${student.departmentId})</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">등록일</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${not empty student.createdAt}">
                        ${student.createdAt}
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">수정일</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${not empty student.updatedAt}">
                        ${student.updatedAt}
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <div class="card-footer">
        <a href="${pageContext.request.contextPath}/students/${student.id}/edit" class="btn btn-warning">수정</a>
        <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">목록</a>
        <a href="${pageContext.request.contextPath}/enrollments/student/${student.id}" class="btn btn-primary">수강신청 관리</a>
        <form method="post" action="${pageContext.request.contextPath}/students/${student.id}/delete" 
              style="display: inline;" onsubmit="return confirm('정말로 이 학생을 삭제하시겠습니까?');">
            <button type="submit" class="btn btn-danger">삭제</button>
        </form>
    </div>
</div>

<!-- 수강 과목 목록 (간단 보기) -->
<div class="card">
    <div class="card-header">
        <h3>수강 과목 미리보기</h3>
    </div>
    <div class="card-body">
        <p>이 학생의 수강신청 상세 정보를 보려면 <strong>"수강신청 관리"</strong> 버튼을 클릭하세요.</p>
        <div style="margin-top: 15px;">
            <a href="${pageContext.request.contextPath}/enrollments/student/${student.id}" class="btn btn-primary">
                수강신청 상세보기
            </a>
            <a href="${pageContext.request.contextPath}/enrollments/new" class="btn btn-success">
                새 수강신청
            </a>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
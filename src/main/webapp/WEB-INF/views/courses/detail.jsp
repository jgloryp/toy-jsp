<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header">
        <h2>${course.name} 과목 상세정보</h2>
    </div>
    <div class="card-body">
        <div class="detail-item">
            <div class="detail-label">과목 ID</div>
            <div class="detail-value">${course.id}</div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">과목명</div>
            <div class="detail-value">${course.name}</div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">과목코드</div>
            <div class="detail-value">
                <span style="background-color: #ecf0f1; padding: 8px 12px; border-radius: 4px; font-family: monospace; font-size: 16px;">
                    ${course.code}
                </span>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">학점</div>
            <div class="detail-value">
                <span style="background-color: #3498db; color: white; padding: 6px 12px; border-radius: 15px; font-weight: bold;">
                    ${course.credits}학점
                </span>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">과목 설명</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${empty course.description}">
                        <span style="color: #7f8c8d; font-style: italic;">설명이 없습니다.</span>
                    </c:when>
                    <c:otherwise>
                        ${course.description}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">생성일</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${not empty course.createdAt}">
                        ${course.createdAt}
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">수정일</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${not empty course.updatedAt}">
                        ${course.updatedAt}
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <div class="card-footer">
        <a href="${pageContext.request.contextPath}/courses/${course.id}/edit" class="btn btn-warning">수정</a>
        <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary">목록</a>
        <a href="${pageContext.request.contextPath}/enrollments/course/${course.id}" class="btn btn-primary">수강학생 관리</a>
        <form method="post" action="${pageContext.request.contextPath}/courses/${course.id}/delete" 
              style="display: inline;" onsubmit="return confirm('정말로 이 과목을 삭제하시겠습니까?');">
            <button type="submit" class="btn btn-danger">삭제</button>
        </form>
    </div>
</div>

<!-- 수강 학생 목록 -->
<div class="card">
    <div class="card-header">
        <h3>수강 학생 목록 (${empty course.students ? 0 : course.students.size()}명)</h3>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty course.students}">
                <div class="empty-state">
                    <p>이 과목을 수강하는 학생이 없습니다.</p>
                    <a href="${pageContext.request.contextPath}/enrollments/new" class="btn btn-primary">수강신청 등록하기</a>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>학생 ID</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>소속학과</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${course.students}">
                            <tr>
                                <td>${student.id}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/students/${student.id}" 
                                       style="text-decoration: none; color: #3498db; font-weight: bold;">
                                        ${student.name}
                                    </a>
                                </td>
                                <td>${student.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty student.phone}">
                                            <span style="color: #7f8c8d; font-style: italic;">-</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${student.phone}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/departments/${student.departmentId}" 
                                       style="text-decoration: none; color: #27ae60;">
                                        학과 ID: ${student.departmentId}
                                    </a>
                                </td>
                                <td class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/students/${student.id}" 
                                       class="btn btn-primary">상세</a>
                                    <a href="${pageContext.request.contextPath}/enrollments/student/${student.id}" 
                                       class="btn btn-warning">수강관리</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div style="margin-top: 20px;">
                    <a href="${pageContext.request.contextPath}/enrollments/course/${course.id}" class="btn btn-primary">
                        수강신청 상세관리
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
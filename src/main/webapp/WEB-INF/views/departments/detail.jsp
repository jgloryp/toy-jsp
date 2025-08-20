<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header">
        <h2>${department.name} 학과 상세정보</h2>
    </div>
    <div class="card-body">
        <div class="detail-item">
            <div class="detail-label">학과 ID</div>
            <div class="detail-value">${department.id}</div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">학과명</div>
            <div class="detail-value">${department.name}</div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">설명</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${empty department.description}">
                        <span style="color: #7f8c8d; font-style: italic;">설명이 없습니다.</span>
                    </c:when>
                    <c:otherwise>
                        ${department.description}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">생성일</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${not empty department.createdAt}">
                        ${department.createdAt}
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">수정일</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${not empty department.updatedAt}">
                        ${department.updatedAt}
                    </c:when>
                    <c:otherwise>-</c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <div class="card-footer">
        <a href="${pageContext.request.contextPath}/departments/${department.id}/edit" class="btn btn-warning">수정</a>
        <a href="${pageContext.request.contextPath}/departments" class="btn btn-secondary">목록</a>
        <form method="post" action="${pageContext.request.contextPath}/departments/${department.id}/delete" 
              style="display: inline;" onsubmit="return confirm('정말로 이 학과를 삭제하시겠습니까?');">
            <button type="submit" class="btn btn-danger">삭제</button>
        </form>
    </div>
</div>

<!-- 소속 학생 목록 -->
<div class="card">
    <div class="card-header">
        <h3>소속 학생 목록 (${empty department.students ? 0 : department.students.size()}명)</h3>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty department.students}">
                <div class="empty-state">
                    <p>이 학과에 소속된 학생이 없습니다.</p>
                    <a href="${pageContext.request.contextPath}/students/new" class="btn btn-primary">학생 등록하기</a>
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
                            <th>등록일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${department.students}">
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
                                    <c:choose>
                                        <c:when test="${not empty student.createdAt}">
                                            ${student.createdAt.toLocalDate()}
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/students/${student.id}" 
                                       class="btn btn-primary">상세</a>
                                    <a href="${pageContext.request.contextPath}/students/${student.id}/edit" 
                                       class="btn btn-warning">수정</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
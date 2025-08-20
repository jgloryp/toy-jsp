<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="item-list">
    <div class="list-header">
        <h2>학생 목록</h2>
        <a href="${pageContext.request.contextPath}/students/new" class="btn btn-success">새 학생 등록</a>
    </div>
    
    <!-- 검색 기능 -->
    <div class="search-container">
        <form method="get" action="${pageContext.request.contextPath}/students" class="search-form">
            <input type="text" name="search" value="${search}" placeholder="이메일로 검색...">
            <button type="submit" class="btn btn-primary">검색</button>
            <c:if test="${not empty search}">
                <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">전체보기</a>
            </c:if>
        </form>
    </div>
    
    <div class="list-body">
        <c:choose>
            <c:when test="${empty students}">
                <div class="empty-state">
                    <c:choose>
                        <c:when test="${not empty search}">
                            <p>"${search}"에 대한 검색 결과가 없습니다.</p>
                            <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">전체 목록 보기</a>
                        </c:when>
                        <c:otherwise>
                            <p>등록된 학생이 없습니다.</p>
                            <a href="${pageContext.request.contextPath}/students/new" class="btn btn-primary">첫 번째 학생 등록하기</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <c:if test="${not empty search}">
                    <div class="alert alert-info">
                        "${search}"에 대한 검색 결과: ${students.size()}명
                    </div>
                </c:if>
                
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>소속학과</th>
                            <th>등록일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${students}">
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
                                    <form method="post" 
                                          action="${pageContext.request.contextPath}/students/${student.id}/delete" 
                                          style="display: inline;"
                                          onsubmit="return confirm('정말로 이 학생을 삭제하시겠습니까?');">
                                        <button type="submit" class="btn btn-danger">삭제</button>
                                    </form>
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
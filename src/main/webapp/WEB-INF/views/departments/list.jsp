<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="item-list">
    <div class="list-header">
        <h2>학과 목록</h2>
        <a href="${pageContext.request.contextPath}/departments/new" class="btn btn-success">새 학과 등록</a>
    </div>
    
    <div class="list-body">
        <c:choose>
            <c:when test="${empty departments}">
                <div class="empty-state">
                    <p>등록된 학과가 없습니다.</p>
                    <a href="${pageContext.request.contextPath}/departments/new" class="btn btn-primary">첫 번째 학과 등록하기</a>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>학과명</th>
                            <th>설명</th>
                            <th>생성일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="department" items="${departments}">
                            <tr>
                                <td>${department.id}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/departments/${department.id}" 
                                       style="text-decoration: none; color: #3498db; font-weight: bold;">
                                        ${department.name}
                                    </a>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty department.description}">
                                            <span style="color: #7f8c8d; font-style: italic;">설명 없음</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${department.description}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty department.createdAt}">
                                            ${department.createdAt.toLocalDate()}
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/departments/${department.id}" 
                                       class="btn btn-primary">상세</a>
                                    <a href="${pageContext.request.contextPath}/departments/${department.id}/edit" 
                                       class="btn btn-warning">수정</a>
                                    <form method="post" 
                                          action="${pageContext.request.contextPath}/departments/${department.id}/delete" 
                                          style="display: inline;"
                                          onsubmit="return confirm('정말로 이 학과를 삭제하시겠습니까?');">
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
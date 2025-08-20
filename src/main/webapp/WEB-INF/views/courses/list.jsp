<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="item-list">
    <div class="list-header">
        <h2>과목 목록</h2>
        <a href="${pageContext.request.contextPath}/courses/new" class="btn btn-success">새 과목 등록</a>
    </div>
    
    <div class="list-body">
        <c:choose>
            <c:when test="${empty courses}">
                <div class="empty-state">
                    <p>등록된 과목이 없습니다.</p>
                    <a href="${pageContext.request.contextPath}/courses/new" class="btn btn-primary">첫 번째 과목 등록하기</a>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>과목명</th>
                            <th>과목코드</th>
                            <th>학점</th>
                            <th>설명</th>
                            <th>생성일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="course" items="${courses}">
                            <tr>
                                <td>${course.id}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/courses/${course.id}" 
                                       style="text-decoration: none; color: #3498db; font-weight: bold;">
                                        ${course.name}
                                    </a>
                                </td>
                                <td>
                                    <span style="background-color: #ecf0f1; padding: 4px 8px; border-radius: 4px; font-family: monospace;">
                                        ${course.code}
                                    </span>
                                </td>
                                <td>
                                    <span style="background-color: #3498db; color: white; padding: 2px 8px; border-radius: 12px; font-size: 12px;">
                                        ${course.credits}학점
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty course.description}">
                                            <span style="color: #7f8c8d; font-style: italic;">설명 없음</span>
                                        </c:when>
                                        <c:when test="${fn:length(course.description) > 50}">
                                            ${fn:substring(course.description, 0, 50)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${course.description}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty course.createdAt}">
                                            ${course.createdAt.toLocalDate()}
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/courses/${course.id}" 
                                       class="btn btn-primary">상세</a>
                                    <a href="${pageContext.request.contextPath}/courses/${course.id}/edit" 
                                       class="btn btn-warning">수정</a>
                                    <form method="post" 
                                          action="${pageContext.request.contextPath}/courses/${course.id}/delete" 
                                          style="display: inline;"
                                          onsubmit="return confirm('정말로 이 과목을 삭제하시겠습니까?');">
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
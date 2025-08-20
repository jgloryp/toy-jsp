<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="item-list">
    <div class="list-header">
        <h2>수강신청 목록</h2>
        <a href="${pageContext.request.contextPath}/enrollments/new" class="btn btn-success">새 수강신청</a>
    </div>
    
    <div class="list-body">
        <c:choose>
            <c:when test="${empty enrollments}">
                <div class="empty-state">
                    <p>등록된 수강신청이 없습니다.</p>
                    <a href="${pageContext.request.contextPath}/enrollments/new" class="btn btn-primary">첫 번째 수강신청 등록하기</a>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>학생 ID</th>
                            <th>과목 ID</th>
                            <th>수강신청일</th>
                            <th>성적</th>
                            <th>등록일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="enrollment" items="${enrollments}">
                            <tr>
                                <td>${enrollment.id}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/students/${enrollment.studentId}" 
                                       style="text-decoration: none; color: #3498db;">
                                        ${enrollment.studentId}
                                    </a>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/courses/${enrollment.courseId}" 
                                       style="text-decoration: none; color: #27ae60;">
                                        ${enrollment.courseId}
                                    </a>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty enrollment.enrollmentDate}">
                                            ${enrollment.enrollmentDate}
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty enrollment.grade}">
                                            <span style="color: #7f8c8d; font-style: italic;">미입력</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="background-color: #2ecc71; color: white; padding: 2px 8px; border-radius: 12px; font-size: 12px; font-weight: bold;">
                                                ${enrollment.grade}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty enrollment.createdAt}">
                                            ${enrollment.createdAt.toLocalDate()}
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/enrollments/${enrollment.id}/edit" 
                                       class="btn btn-warning">수정</a>
                                    <form method="post" 
                                          action="${pageContext.request.contextPath}/enrollments/${enrollment.id}/delete" 
                                          style="display: inline;"
                                          onsubmit="return confirm('정말로 이 수강신청을 삭제하시겠습니까?');">
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

<!-- 빠른 액세스 링크 -->
<div class="card">
    <div class="card-header">
        <h3>빠른 액세스</h3>
    </div>
    <div class="card-body">
        <div style="display: flex; gap: 15px; flex-wrap: wrap;">
            <a href="${pageContext.request.contextPath}/students" class="btn btn-primary">학생별 수강신청 보기</a>
            <a href="${pageContext.request.contextPath}/courses" class="btn btn-success">과목별 수강학생 보기</a>
            <a href="${pageContext.request.contextPath}/enrollments/new" class="btn btn-warning">신규 수강신청</a>
        </div>
        
        <div style="margin-top: 15px;">
            <p><strong>팁:</strong></p>
            <ul>
                <li>학생 ID나 과목 ID를 클릭하면 해당 상세페이지로 이동합니다.</li>
                <li>학생별 수강현황을 보려면 학생 목록에서 "수강신청 관리" 버튼을 클릭하세요.</li>
                <li>과목별 수강학생을 보려면 과목 목록에서 "수강학생 관리" 버튼을 클릭하세요.</li>
            </ul>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
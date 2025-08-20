<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header">
        <h2>${student.name} 학생의 수강신청 현황</h2>
    </div>
    <div class="card-body">
        <div class="detail-item">
            <div class="detail-label">학생 정보</div>
            <div class="detail-value">
                <strong>${student.name}</strong> (${student.email})
                <c:if test="${not empty student.phone}">
                    <br>전화번호: ${student.phone}
                </c:if>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">총 수강과목</div>
            <div class="detail-value">
                <span style="background-color: #3498db; color: white; padding: 6px 12px; border-radius: 15px; font-weight: bold;">
                    ${empty enrollments ? 0 : enrollments.size()}과목
                </span>
            </div>
        </div>
    </div>
    <div class="card-footer">
        <a href="${pageContext.request.contextPath}/students/${student.id}" class="btn btn-secondary">학생 상세정보</a>
        <a href="${pageContext.request.contextPath}/enrollments/new" class="btn btn-success">새 수강신청</a>
    </div>
</div>

<!-- 수강과목 목록 -->
<div class="card">
    <div class="card-header">
        <h3>수강과목 목록</h3>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty enrollments}">
                <div class="empty-state">
                    <p>이 학생은 아직 수강신청한 과목이 없습니다.</p>
                    <a href="${pageContext.request.contextPath}/enrollments/new" class="btn btn-primary">첫 번째 수강신청하기</a>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>과목명</th>
                            <th>과목코드</th>
                            <th>학점</th>
                            <th>수강신청일</th>
                            <th>성적</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="enrollment" items="${enrollments}">
                            <tr>
                                <td>
                                    <a href="${pageContext.request.contextPath}/courses/${enrollment.course.id}" 
                                       style="text-decoration: none; color: #3498db; font-weight: bold;">
                                        ${enrollment.course.name}
                                    </a>
                                </td>
                                <td>
                                    <span style="background-color: #ecf0f1; padding: 4px 8px; border-radius: 4px; font-family: monospace;">
                                        ${enrollment.course.code}
                                    </span>
                                </td>
                                <td>
                                    <span style="background-color: #3498db; color: white; padding: 2px 8px; border-radius: 12px; font-size: 12px;">
                                        ${enrollment.course.credits}학점
                                    </span>
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
                                            <form method="post" action="${pageContext.request.contextPath}/enrollments/grade" 
                                                  style="display: inline;">
                                                <input type="hidden" name="studentId" value="${student.id}">
                                                <input type="hidden" name="courseId" value="${enrollment.course.id}">
                                                <select name="grade" onchange="this.form.submit()" style="padding: 2px; font-size: 12px;">
                                                    <option value="">성적입력</option>
                                                    <option value="A+">A+</option>
                                                    <option value="A">A</option>
                                                    <option value="A-">A-</option>
                                                    <option value="B+">B+</option>
                                                    <option value="B">B</option>
                                                    <option value="B-">B-</option>
                                                    <option value="C+">C+</option>
                                                    <option value="C">C</option>
                                                    <option value="C-">C-</option>
                                                    <option value="D+">D+</option>
                                                    <option value="D">D</option>
                                                    <option value="F">F</option>
                                                </select>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="background-color: #2ecc71; color: white; padding: 4px 8px; border-radius: 12px; font-weight: bold;">
                                                ${enrollment.grade}
                                            </span>
                                            <form method="post" action="${pageContext.request.contextPath}/enrollments/grade" 
                                                  style="display: inline; margin-left: 5px;">
                                                <input type="hidden" name="studentId" value="${student.id}">
                                                <input type="hidden" name="courseId" value="${enrollment.course.id}">
                                                <select name="grade" onchange="this.form.submit()" style="padding: 2px; font-size: 10px;">
                                                    <option value="">수정</option>
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
                                            </form>
                                        </c:otherwise>
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
                
                <!-- 총계 정보 -->
                <div style="margin-top: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 4px;">
                    <h4>수강 요약</h4>
                    <p>
                        <strong>총 수강과목:</strong> ${enrollments.size()}과목 |
                        <strong>총 학점:</strong> 
                        <c:set var="totalCredits" value="0"/>
                        <c:forEach var="enrollment" items="${enrollments}">
                            <c:set var="totalCredits" value="${totalCredits + enrollment.course.credits}"/>
                        </c:forEach>
                        ${totalCredits}학점
                    </p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
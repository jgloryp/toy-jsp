<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header">
        <h2>${course.name} 과목의 수강학생 현황</h2>
    </div>
    <div class="card-body">
        <div class="detail-item">
            <div class="detail-label">과목 정보</div>
            <div class="detail-value">
                <strong>${course.name}</strong> (${course.code}) - ${course.credits}학점
                <c:if test="${not empty course.description}">
                    <br>${course.description}
                </c:if>
            </div>
        </div>
        
        <div class="detail-item">
            <div class="detail-label">총 수강학생</div>
            <div class="detail-value">
                <span style="background-color: #e74c3c; color: white; padding: 6px 12px; border-radius: 15px; font-weight: bold;">
                    ${empty enrollments ? 0 : enrollments.size()}명
                </span>
            </div>
        </div>
    </div>
    <div class="card-footer">
        <a href="${pageContext.request.contextPath}/courses/${course.id}" class="btn btn-secondary">과목 상세정보</a>
        <a href="${pageContext.request.contextPath}/enrollments/new" class="btn btn-success">새 수강신청</a>
    </div>
</div>

<!-- 수강학생 목록 -->
<div class="card">
    <div class="card-header">
        <h3>수강학생 목록</h3>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty enrollments}">
                <div class="empty-state">
                    <p>이 과목을 수강하는 학생이 없습니다.</p>
                    <a href="${pageContext.request.contextPath}/enrollments/new" class="btn btn-primary">첫 번째 수강신청 등록하기</a>
                </div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>학생명</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>소속학과</th>
                            <th>수강신청일</th>
                            <th>성적</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="enrollment" items="${enrollments}">
                            <tr>
                                <td>
                                    <a href="${pageContext.request.contextPath}/students/${enrollment.student.id}" 
                                       style="text-decoration: none; color: #3498db; font-weight: bold;">
                                        ${enrollment.student.name}
                                    </a>
                                </td>
                                <td>${enrollment.student.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty enrollment.student.phone}">
                                            <span style="color: #7f8c8d; font-style: italic;">-</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${enrollment.student.phone}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/departments/${enrollment.student.departmentId}" 
                                       style="text-decoration: none; color: #27ae60;">
                                        학과 ID: ${enrollment.student.departmentId}
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
                                            <form method="post" action="${pageContext.request.contextPath}/enrollments/grade" 
                                                  style="display: inline;">
                                                <input type="hidden" name="studentId" value="${enrollment.student.id}">
                                                <input type="hidden" name="courseId" value="${course.id}">
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
                                                <input type="hidden" name="studentId" value="${enrollment.student.id}">
                                                <input type="hidden" name="courseId" value="${course.id}">
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
                                    <a href="${pageContext.request.contextPath}/students/${enrollment.student.id}" 
                                       class="btn btn-primary">학생정보</a>
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
                
                <!-- 성적 통계 -->
                <div style="margin-top: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 4px;">
                    <h4>성적 통계</h4>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(120px, 1fr)); gap: 10px;">
                        <c:set var="gradeStats" value=""/>
                        <c:set var="totalStudents" value="${enrollments.size()}"/>
                        <c:set var="gradedStudents" value="0"/>
                        
                        <c:forEach var="enrollment" items="${enrollments}">
                            <c:if test="${not empty enrollment.grade}">
                                <c:set var="gradedStudents" value="${gradedStudents + 1}"/>
                            </c:if>
                        </c:forEach>
                        
                        <div><strong>총 학생:</strong> ${totalStudents}명</div>
                        <div><strong>성적 입력:</strong> ${gradedStudents}명</div>
                        <div><strong>미입력:</strong> ${totalStudents - gradedStudents}명</div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
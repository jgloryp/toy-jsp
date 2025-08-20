<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="common/header.jsp" %>

<div class="card">
    <div class="card-header">
        <h2>학사 관리 시스템에 오신 것을 환영합니다</h2>
    </div>
    <div class="card-body">
        <p>이 시스템은 Spring MVC, MyBatis, PostgreSQL, JSP를 사용하여 구축된 샘플 애플리케이션입니다.</p>
        
        <h3>시스템 기능</h3>
        <ul>
            <li><strong>학과 관리</strong>: 학과 정보 등록, 수정, 삭제, 조회</li>
            <li><strong>학생 관리</strong>: 학생 정보 등록, 수정, 삭제, 조회 (n:1 관계 - 학과)</li>
            <li><strong>과목 관리</strong>: 과목 정보 등록, 수정, 삭제, 조회</li>
            <li><strong>수강신청</strong>: 학생-과목 수강신청 관리 (n:m 관계)</li>
        </ul>
        
        <h3>데이터베이스 관계</h3>
        <ul>
            <li><strong>1:n 관계</strong>: 학과 ← 학생 (한 학과에 여러 학생)</li>
            <li><strong>n:1 관계</strong>: 학생 → 학과 (여러 학생이 한 학과에 소속)</li>
            <li><strong>n:m 관계</strong>: 학생 ↔ 과목 (학생은 여러 과목을 수강, 과목은 여러 학생이 수강)</li>
        </ul>
        
        <div style="margin-top: 30px;">
            <h3>빠른 시작</h3>
            <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/departments" class="btn btn-primary">학과 관리</a>
                <a href="${pageContext.request.contextPath}/students" class="btn btn-success">학생 관리</a>
                <a href="${pageContext.request.contextPath}/courses" class="btn btn-warning">과목 관리</a>
                <a href="${pageContext.request.contextPath}/enrollments" class="btn btn-secondary">수강신청</a>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h3>기술 스택</h3>
    </div>
    <div class="card-body">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
            <div>
                <h4>Backend</h4>
                <ul>
                    <li>Java 17</li>
                    <li>Spring MVC 5.3</li>
                    <li>MyBatis 3.5</li>
                    <li>Maven</li>
                </ul>
            </div>
            <div>
                <h4>Database</h4>
                <ul>
                    <li>PostgreSQL</li>
                    <li>HikariCP (Connection Pool)</li>
                    <li>JDBC</li>
                </ul>
            </div>
            <div>
                <h4>Frontend</h4>
                <ul>
                    <li>JSP</li>
                    <li>JSTL</li>
                    <li>CSS3</li>
                    <li>Responsive Design</li>
                </ul>
            </div>
            <div>
                <h4>Features</h4>
                <ul>
                    <li>CRUD Operations</li>
                    <li>Relationship Management</li>
                    <li>Transaction Support</li>
                    <li>Validation</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
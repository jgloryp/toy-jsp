<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toy JSP Application</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header>
        <div class="container">
            <h1>학사 관리 시스템</h1>
        </div>
    </header>
    
    <nav>
        <div class="container">
            <ul>
                <li><a href="${pageContext.request.contextPath}/">홈</a></li>
                <li><a href="${pageContext.request.contextPath}/departments">학과</a></li>
                <li><a href="${pageContext.request.contextPath}/students">학생</a></li>
                <li><a href="${pageContext.request.contextPath}/courses">과목</a></li>
                <li><a href="${pageContext.request.contextPath}/enrollments">수강신청</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="container">
        <!-- Flash Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
        
        <c:if test="${not empty warningMessage}">
            <div class="alert alert-warning">${warningMessage}</div>
        </c:if>
        
        <c:if test="${not empty infoMessage}">
            <div class="alert alert-info">${infoMessage}</div>
        </c:if>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>header</title>
    <link href="../../../resources/css/common.css" rel="stylesheet">
</head>
<body>
<header>
    <div id="headerLogo">
        <div id="logo">
            <img class="imgLogo" src="../../resources/img/logo.png" height="60">
            <a class="nameLogo" href="/">SafetyOne</a>
        </div>
        <%
            String email = (String) session.getAttribute("email");
            String name = (String) session.getAttribute("name");
            if (email != null) {%>
        <span id="welcomeMessage">
            <span><%= name %> 님 환영합니다</span>
            <a href="/logout"><button id="logoutBtn">로그아웃</button></a>
        </span>
        <% } else { %>
        <div id="loginout">
            <button id="loginBtn" onclick="window.location.href='/login'">로그인</button>
            <button id="joinBtn" onclick="window.location.href='/join'">회원가입</button>
        </div>
        <%}%>
        <%--        <a href="/join">회원가입</a>--%>
    </div>
    <nav>
        <div class="navbar">
            <%--            <div class="dropdown">--%>
            <%--                <button class="dropbtn" onclick="window.location.href='/safetyCard/'">안심서비스--%>
            <%--                </button>--%>
            <%--                <div class="dropdown-content">--%>
            <%--                    <a href="/safetyCard/">서비스 등록 및 해제</a>--%>
            <%--                    <a href="/safetyCard/">서비스 이용현황</a>--%>
            <%--                    <a href="/safetyCard/safetyCardStop">서비스 일시정지</a>--%>
            <%--                </div>--%>
            <%--                <div>--%>
            <%--                </div>--%>
            <a href="/safetyCard/">안심서비스</a>
            <a href="/fds/">이상소비알림서비스</a>
            <a href="/customCenter/lostCardSelect">고객센터</a>
            <%--                <div class="dropdown">--%>
            <%--                    <button class="dropbtn">고객센터--%>
            <%--                    </button>--%>
            <%--                    <div class="dropdown-content" style="max-width: 130px;">--%>
            <%--                        <a href="/customCenter/lostCardSelect">카드 분실신고</a>--%>
            <%--                        <a href="#">카드 재발급</a>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <a href="/mypage">마이페이지</a>
        </div>
        <%--            <hr style="border:1px solid #00857F"/>--%>
    </nav>
    <hr style="border:1px solid #00857F; margin: 0px;"/>
</header>

</body>
</html>
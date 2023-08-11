<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="../../resources/css/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<%@ include file="include/header.jsp" %>
<h2>로그인</h2>
<form id="loginForm" method="post">
    <div>
        <label for="id">아이디</label>
        <input type="text" id="id" name="id">
    </div>
    <div>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password">
    </div>
    <input type="button" class="button" value="로그인" onclick="loginFormFunc(); return false;">
<%--    <input type="button" class="button" value="회원가입" onclick="joinFunc(); return false;">--%>
    <a href="/selectAll">회원목록</a>
</form>
<%@ include file="include/footer.jsp" %>
</body>
<script>
    function loginFormFunc() {
        var formData = $("#loginForm").serialize();
        var id = $("#id").val();
        var password = $("#password").val();

        console.log("FormData:", formData); // 전체 폼 데이터 확인
        console.log("ID:", id); // 아이디 확인
        console.log("Password:", password); // 비밀번호 확인

        $.ajax({
            type: "POST",
            url: "/loginMember",
            data: JSON.stringify({
                id: id,
                password: password
            }),
            contentType: 'application/json',
            error: function (xhr, status, error) {
                alert(error + "error");
            },
            success: function (response) {
                if (response === "로그인 성공") {
                    alert("로그인 성공");
                    var link = document.createElement("a");
                    link.href = "/";
                    link.click();
                } else {
                    console.error("로그인 실패");
                }
            }
        });
    }

    // function joinFunc(){
    //     var link = document.createElement("a");
    //     link.href = "/join";
    //     link.click();
    // }


</script>
</html>

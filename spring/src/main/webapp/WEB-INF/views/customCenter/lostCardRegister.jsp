<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <link href="../../../resources/css/common.css" rel="stylesheet">
    <link href="../../../resources/css/lostcard.css" rel="stylesheet">
    <link href="../../../resources/css/cardSelectCommon.css" rel="stylesheet">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>
<div class="active-container">
    <form action="${pageContext.request.contextPath}/customCenter/lostCardRegisterOk" method="post">
        <input type="hidden" name="cardId" value="<%=request.getAttribute("cardId")%>">
        <input type="hidden" name="reissued" value="<%=request.getAttribute("reissued")%>">
        <div class="cont_box_area">
            <div class="lost-header"><h2>카드분실신고 및 재발급 신청</h2></div>
            <div class="lost-header"><h3>분실신고 카드</h3></div>
            <div class="lostcard-list">
                <div class="card-list-info" id="<%=request.getAttribute("cardId")%>">
                    <img style="margin-left: 5%;" class="card-img" src="../../../resources/img/${cardInfo.cardName}.png">
                    <div class="card-list-info-cardid"><%=request.getAttribute("cardId")%>
                    </div>
                    <div class="card-list-info-name">본인&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
                    </div>
                    <div class="card-list-info-cardname">${cardInfo.cardName}</div>

                </div>
            </div>
            <h3>분실신고 접수내용</h3>
            <div class="lost-info">
                <table>
                    <colgroup>
                        <col span="1" style="width:23%;">
                        <col span="1" style="width:77%;">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="row" class="left">분실일자</th>
                        <td class="left">
                            <input type="text" id="datepicker" name="lostDate">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="left">분실장소</th>
                        <td class="left">
                            <input type="text" placeholder="예) 삼성동에서 지갑 분실" name="lostPlace">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="left">분실사유</th>
                        <td class="left">
                            <select id="lostReason" name="lostReason" onchange="changeReason(this.value);"
                                    title="경위 선택">
                                <option value="지갑채분실">지갑채분실</option>
                                <option value="카드만분실">카드만분실</option>
                                <option value="도난/소매치기">도난/소매치기</option>
                                <option value="타인양도후 분실">타인양도후 분실</option>
                                <option value="기타">기타</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="left">연락처</th>
                        <td class="left">
                            <input type="text" placeholder="‘-’ 없이 입력하세요.">
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <h3>재발급 신청 정보</h3>
            <div class="lost-info">
                <table>
                    <colgroup>
                        <col span="1" style="width:23%;">
                        <col span="1" style="width:77%;">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="row" class="left">카드수령지</th>
                        <td class="left">
                            <div class="tab_ty02" style="width: 60%;">
                                <li class="on"><a href="#" title="현재 선택 탭">자택</a></li>
                                <li><a href="#">회사</a></li>
                                <li><a href="#">은행</a></li>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row" class="left">자택주소</th>
                        <td class="left">
                            <%--                            <input type="text" placeholder="${address}" style="width: 50%; margin-right: 10px">--%>
                            <div class="address-div">${address}<button class="updateMyInfo">개인정보변경</button></div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </div>
        <input type="submit" value="접수" class="registerLostInput" onclick="registerLostCard()">
    </form>
</div>
</body>
<script>

    $("#datepicker").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        , showMonthAfterYear: true // 월- 년 순서가아닌 년도 - 월 순서
        , changeYear: true //option값 년 선택 가능
        , changeMonth: true //option값  월 선택 가능
        , yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
        , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 텍스트
        , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip
        , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 텍스트
        , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 Tooltip
        , minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        , maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
    });
</script>
</html>
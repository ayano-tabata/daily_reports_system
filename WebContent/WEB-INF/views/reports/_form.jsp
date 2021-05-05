<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${errors != null}">
    <div id="flush_error">
        入力内容にエラーがあります。<br />
        <c:forEach var="error" items="${errors}">
            ・<c:out value="${error}" /><br />
        </c:forEach>

    </div>
</c:if>
<label for="report_date">日付</label><br />
<input type="date" name="report_date" value="<fmt:formatDate value='${report.report_date}' pattern='yyyy-MM-dd' />">
<br /><br />

<label for="name">氏名</label><br />
<c:out value="${sessionScope.login_employee.name}" />
<br /><br />

<label for="title">タイトル</label><br />
<input type="text" name="title" value="${report.title}" />
<br /><br />

<label for="category">種別</label><br />
<select name="category">
    <option value="0"<c:if test="${report.category == 0}"> selected</c:if>>お客様情報</option>
    <option value="1"<c:if test="${report.category == 1}"> selected</c:if>>メンテナンス情報</option>
    <option value="2"<c:if test="${report.category == 2}"> selected</c:if>>イベント情報</option>
    <option value="3"<c:if test="${report.category == 3}"> selected</c:if>>クレーム</option>
    <option value="4"<c:if test="${report.category == 4}"> selected</c:if>>その他</option>
</select>
<br /><br />

<label for="content">内容</label><br />
<textarea name="content" rows="10" cols="50">${report.content}</textarea>
<br /><br />

<input type="hidden" name="_token" value="${_token}" />
<button type="submit">投稿</button>
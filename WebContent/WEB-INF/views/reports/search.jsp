<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <h2>検索結果</h2>
        <table id="report_list">
            <tbody>
                <tr>
                    <th class="report_name">氏名</th>
                    <th class="report_date">日付</th>
                    <th class="report_title">タイトル</th>
                    <th class="report_category">種別</th>
                    <th class="report_importance">重要度</th>
                    <th class="report_action">操作</th>
                </tr>
                <c:forEach var="report" items="${reports}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="report_name"><c:out value="${report.employee.name}" /></td>
                        <td class="report_date"><fmt:formatDate value='${report.report_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="report_title">${report.title}</td>
                        <td class="report_category">
                            <c:choose>
                                <c:when test="${report.category == 0}">お客様情報</c:when>
                                <c:when test="${report.category == 1}">メンテナンス情報</c:when>
                                <c:when test="${report.category == 2}">イベント情報</c:when>
                                <c:when test="${report.category == 3}">クレーム</c:when>
                                <c:when test="${report.category == 4}">その他</c:when>
                            </c:choose>
                        </td>
                        <td class="report_importance">
                            <c:choose>
                                <c:when test="${report.importance == 0}">未設定</c:when>
                                <c:when test="${report.importance == 1}">低</c:when>
                                <c:when test="${report.importance == 2}">高</c:when>
                            </c:choose>
                        </td>
                        <td class="report_action"><a href="<c:url value='/reports/show?id=${report.id}'/>">詳細</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

            <div id="pagination">
            (全 ${reports_count} 件)<br />
            <c:forEach var="i" begin="1" end="${((reports_count - 1) / 15) + 1}" step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/reports/index?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
        <p><a href="<c:url value='/reports/index' />">一覧に戻る</a></p>


    </c:param>
</c:import>

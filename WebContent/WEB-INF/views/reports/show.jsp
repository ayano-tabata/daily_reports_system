<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${report != null}">
            <h2>報告　詳細ページ</h2>

            <table>
                <tbody>
                    <tr>
                        <th>氏名</th>
                        <td><c:out value="${report.employee.name}" /></td>
                    </tr>
                    <tr>
                        <th>日付</th>
                        <td><fmt:formatDate value="${report.report_date}" pattern="yyyy-MM-dd" /></td>
                    </tr>
                    <tr>
                        <th>種別</th>
                        <td>
                            <c:choose>
                                <c:when test="${report.category == 0}">お客様情報</c:when>
                                <c:when test="${report.category == 1}">メンテナンス情報</c:when>
                                <c:when test="${report.category == 2}">イベント情報</c:when>
                                <c:when test="${report.category == 3}">クレーム</c:when>
                                <c:when test="${report.category == 4}">その他</c:when>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>内容</th>
                        <td>
                            <pre><c:out value="${report.content}" /></pre>
                        </td>
                    </tr>
                    <tr>
                        <th>公開範囲</th>
                        <td>
                            <c:choose>
                                <c:when test="${report.share_flag == 0}">全体公開</c:when>
                                <c:when test="${report.share_flag == 1}">課長以上</c:when>
                                <c:when test="${report.share_flag == 2}">部長以上</c:when>
                                <c:when test="${report.share_flag == 3}">女将のみ</c:when>
                                <c:when test="${report.share_flag == 4}">未設定</c:when>
                            </c:choose>
                    </tr>
                    <tr>
                        <th>重要度</th>
                        <td>
                            <c:choose>
                                <c:when test="${report.importance == 0}">未設定</c:when>
                                <c:when test="${report.importance == 1}">低</c:when>
                                <c:when test="${report.importance == 2}">高</c:when>
                            </c:choose>
                    </tr>
                    <tr>
                        <th>登録日時</th>
                        <td>
                            <fmt:formatDate value="${report.created_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                        </td>
                    </tr>
                    <tr>
                        <th>更新日時</th>
                        <td>
                            <fmt:formatDate value="${report.updated_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />

            <c:if test="${report.approve_flag == 0
                        &&((sessionScope.login_employee.admin_flag == report.employee.admin_flag + 1
                            && sessionScope.login_employee.department == report.employee.department)
                        || ((report.employee.admin_flag == 3 || report.employee.admin_flag == 2)
                            && sessionScope.login_employee.admin_flag == 3))}">
                <form method="POST" action="<c:url value='/reports/approve' />">
                    <input type="hidden" name="_token" value="${_token}" />
                    <input type="submit" value="承認">
                </form>
            </c:if>

            <br />

            <c:if test="${sessionScope.login_employee.admin_flag == 3}">
                <form method="POST" action="<c:url value='/reports/share' />">
                    <label for="share_flag">公開範囲</label>
                    <select name="share_flag">
                        <option value="0"<c:if test="${report.share_flag == 0}"> selected</c:if>>全体公開</option>
                        <option value="1"<c:if test="${report.share_flag == 1}"> selected</c:if>>課長以上</option>
                        <option value="2"<c:if test="${report.share_flag == 2}"> selected</c:if>>部長以上</option>
                        <option value="3"<c:if test="${report.share_flag == 3}"> selected</c:if>>女将のみ</option>
                    </select>

                    <label for="importance">重要度</label>
                    <select name="importance">
                        <option value="1"<c:if test="${report.importance == 1}">selected</c:if>>低</option>
                        <option value="2"<c:if test="${report.importance == 2}">selected</c:if>>高</option>
                    </select>

                    <input type="hidden" name="_token" value="${_token}" />
                    <input type="submit" value="送信">
                </form>
                <br />
            </c:if>

            <c:if test="${sessionScope.login_employee.id == report.employee.id}">
                <p><a href="<c:url value='/reports/edit?id=${report.id}' />">この日報を編集する</a></p>
            </c:if>
            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <p><a href="<c:url value="/reports/index" />">一覧に戻る</a></p>
    </c:param>
</c:import>

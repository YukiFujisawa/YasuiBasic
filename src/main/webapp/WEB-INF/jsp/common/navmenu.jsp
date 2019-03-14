<div id=nav>
	<ul>
		<c:if test="${not empty sessionScope['username']}">
			<li>顧客ID［${fn:escapeXml(sessionScope['username'])}
				（${fn:escapeXml(sessionScope['descript'])}）］</li>
		</c:if>
		<c:if test="${sessionScope['role'] == 'administrator'}">
			<li><a href="/yasui/AddItem">商品追加</a></li>
			<li><a href="/yasui/ChangeStock">在庫数量変更</a></li>
			<li><a href="/yasui/RemoveItem">商品削除</a></li>
		</c:if>
			<li><a href="/yasui/ListItem">商品一覧</a></li>
			<li><a href="/yasui/Logout">ログアウト</a></li>
	</ul>
</div>
<%-- ログイン中の画面はグローバルナビゲーションの下にhrを入れる --%>
<c:if test="${not empty sessionScope['username']}">
	<hr>
</c:if>
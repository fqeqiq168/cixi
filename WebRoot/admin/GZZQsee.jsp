<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML >
<html>
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<title>慈溪共青团管理后台</title>
<style type="text/css">
#Mybtns .btn-fl {
	margin-left: 20px;
	margin-bottom: 15px;
}
</style>

</head>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="bs/css/bootstrap.min.css">
<body ng-app="app">
	<jsp:include page="top.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2 ">
				<jsp:include page="left.jsp"></jsp:include>
			</div>
			<div class="col-sm-10">
				<ol class="breadcrumb">
					<li class="active">工作专区</li>
					<li class="active">查看</li>
				</ol>
				<div id="Mybtns">
					<a :href="'GZZQsonadd.jsp?id='+Id" class="btn btn-info btn-fl">添加</a>
					<div>
						<div class="table-responsive">
							<table class="table table-striped text-center">
								<thead>
									<tr>
										<td>ID</td>
										<td>标题</td>
	<td>时间</td>
										<td>修改</td>
										<td>删除</td>
									</tr>
								</thead>
								<tbody id="demo">
									<tr v-for="data in datas">
										<td>{{data.id}}</td>
										<td>{{unescape(data.title)}}</td>
	<td>{{formatDate(data.date.time)}}</td>
										<td><a :href="'GZZQsonsee.jsp?id='+data.id">修改</a></td>
										<td @click="del(data)"><a href="javascript:void(0)">删除</a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div id="btn btn-info center-block"
							class="btn btn-info center-block" style="width:100px;" id="more"
							onclick="demo.loadMore();">加载更多</div>
					</div>
				</div>
			</div>
</body>
<!-- -->
<script src="js/jquery-1.11.3.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="bs/js/bootstrap.min.js"></script>
<script src="js/vue.min.js" type="text/javascript"
	charset="utf-8"></script>
<script type="text/javascript">
	var str = window.location.href;
	var Id = str.split('=')[1];
	console.log(Id);

	var Start = 0;

	var Mybtns = new Vue(
		{
			el : "#Mybtns",
			data : {
				datas : {}
			},
			created : function() {
				this.enterSearch(); //定义方法

			},
			methods : {
				enterSearch : function() {
					$
						.ajax({
							url : "getZonenoteAll.do",
							data : {
								start : Start,
								size : 10,
								id : Id
							},
							dataType : "json",
							success : function(data) {
								Mybtns.datas = data[0].data;
								if (data[0].data.length >= 10) {
									document
										.getElementById("btn btn-info center-block").style.display = "block";
								} else {
									document
										.getElementById("btn btn-info center-block").style.display = "none";
								}
								Start = Start + data[0].data.length;
							}
						});
				},formatDate : function(value) {
					var date = new Date(value);
					var y = date.getFullYear();
					var MM = date.getMonth() + 1;
					MM = MM < 10 ? ('0' + MM) : MM;
					var d = date.getDate();
					d = d < 10 ? ('0' + d) : d;
					var h = date.getHours();
					h = h < 10 ? ('0' + h) : h;
					var m = date.getMinutes();
					m = m < 10 ? ('0' + m) : m;
					var s = date.getSeconds();
					s = s < 10 ? ('0' + s) : s;
					return y + '-' + MM + '-' + d + ' ' + h + ':' + m + ':' + s;
				},
				loadMore : function() {
					$
						.ajax({
							url : "getZonenoteAll.do",
							data : {
								start : Start,
								size : 10
							},
							dataType : "json",
							success : function(data) {
								Mybtns.datas = Mybtns.datas
									.concat(data[0].data);

								if (data[0].data.length >= 10) {
									document
										.getElementById("btn btn-info center-block").style.display = "block";
								} else {
									document
										.getElementById("btn btn-info center-block").style.display = "none";
								}
								Start = Start + data[0].data.length;
								console.log(Start);
							}
						});
				},
				unescape : function(text) {
				    var temp = document.createElement("div"); 
				    temp.innerHTML = text; 
				    var output = temp.innerText || temp.textContent; 
				    temp = null; 
				    return output; 
				},
				del : function(obj) {
					if (obj != null) {

						$
							.ajax({
								url : "delZonenote.do",
								data : {
									id : obj.id
								},
								dataType : "json",
								success : function(data) {
									alert(data[0].message);
									if (data[0].message == '成功') {
										var index = Mybtns.datas
											.indexOf(obj);
										if (index > -1) {
											Mybtns.datas.splice(index, 1);
										}
									}
								}
							});
					}
				}
			}
		});
</script>

<script src="layer/layer.js"></script>

</html>

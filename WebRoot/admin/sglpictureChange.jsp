<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
<link href="themes/default/css/umeditor.css" type="text/css"
	rel="stylesheet">
<script type="text/javascript" src="third-party/jquery.min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="js/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="js/umeditor.min.js"></script>
<script type="text/javascript" src="lang/zh-cn/zh-cn.js"></script>
<title>Document</title>
</head>
<style type="text/css">
#Mybtns .btn-fr {
	margin-right: 20px;
	margin-bottom: 15px;
}

h1 {
	font-family: "微软雅黑";
	font-weight: normal;
}

.btn {
	display: inline-block;
	*display: inline;
	padding: 4px 12px;
	margin-bottom: 0;
	*margin-left: .3em;
	font-size: 14px;
	line-height: 20px;
	color: #333333;
	text-align: center;
	text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75);
	vertical-align: middle;
	cursor: pointer;
	background-color: #f5f5f5;
	*background-color: #e6e6e6;
	background-image: -moz-linear-gradient(top, #ffffff, #e6e6e6);
	background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff),
		to(#e6e6e6));
	background-image: -webkit-linear-gradient(top, #ffffff, #e6e6e6);
	background-image: -o-linear-gradient(top, #ffffff, #e6e6e6);
	background-image: linear-gradient(to bottom, #ffffff, #e6e6e6);
	background-repeat: repeat-x;
	border: 1px solid #cccccc;
	*border: 0;
	border-color: #e6e6e6 #e6e6e6 #bfbfbf;
	border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
	border-bottom-color: #b3b3b3;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffffff',
		endColorstr='#ffe6e6e6', GradientType=0);
	filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);
	*zoom: 1;
	-webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px
		rgba(0, 0, 0, 0.05);
	-moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px
		rgba(0, 0, 0, 0.05);
	box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2), 0 1px 2px
		rgba(0, 0, 0, 0.05);
}

.btn:hover, .btn:focus, .btn:active, .btn.active, .btn.disabled, .btn[disabled]
	{
	color: #333333;
	background-color: #e6e6e6;
	*background-color: #d9d9d9;
}

.btn:active, .btn.active {
	background-color: #cccccc \9;
}

.btn:first-child {
	*margin-left: 0;
}

.btn:hover, .btn:focus {
	color: #333333;
	text-decoration: none;
	background-position: 0 -15px;
	-webkit-transition: background-position 0.1s linear;
	-moz-transition: background-position 0.1s linear;
	-o-transition: background-position 0.1s linear;
	transition: background-position 0.1s linear;
}

.btn:focus {
	outline: thin dotted #333;
	outline: 5px auto -webkit-focus-ring-color;
	outline-offset: -2px;
}

.btn.active, .btn:active {
	background-image: none;
	outline: 0;
	-webkit-box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.15), 0 1px 2px
		rgba(0, 0, 0, 0.05);
	-moz-box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.15), 0 1px 2px
		rgba(0, 0, 0, 0.05);
	box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.15), 0 1px 2px
		rgba(0, 0, 0, 0.05);
}

.btn.disabled, .btn[disabled] {
	cursor: default;
	background-image: none;
	opacity: 0.65;
	filter: alpha(opacity = 65);
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
}
</style>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="bs/css/bootstrap.min.css">
<body>
	<jsp:include page="top.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2">
				<jsp:include page="left.jsp"></jsp:include>
			</div>
			<div class="col-sm-10">
				<ol class="breadcrumb">
					<li class="active">新闻图片</li>
					<li class="active">修改</li>
				</ol>
				<div id="Mybtns">
					<a href="sglfastMessage.jsp"
						class="btn btn-info pull-right btn-fr clearfix">返回</a>
					<div>
						<form method="post" id="tf" enctype="multipart/form-data"
							style="padding-top:30px">
							<div class="form-group">
								<label for="exampleInputPassword1">Id:</label> <input id="Id"
									type="text" style="width:20%" class="form-control" name="Id"
									readonly="readonly">
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">标题:</label> <input id="title"
									type="text" style="width:20%" class="form-control" name="title">
							</div>
							<div class="form-group">
								<label for="exampleInputFile">新闻图片:</label> <input type="file"
									name="file">

							</div>
							<div class="form-group">
								<label for="exampleInputFile">内容:</label> <input id="content"
									type="hidden" name="content">

							</div>
							<script type="text/plain" id="myEditor"
								style="width:1000px;height:240px;">
    <p>这里我可以写一些输入提示</p>
</script>
							<button type="button" class="btn btn-default text-align"
								onclick="getContent()">添加</button>
						</form>
					</div>
				</div>
			</div>
</body>

</html>
<!-- 最
新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="bs/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var str = window.location.href;
	var id = str.split('=')[1];
	function unescape(text) {
		var temp = document.createElement("div");
		temp.innerHTML = text;
		var output = temp.innerText || temp.textContent;
		temp = null;
		return output;
	}
	$.ajax({
		url : "findNewsById.do",
		data : {
			Id : id
		},
		dataType : "json",
		success : function(data) {
			console.log(data);
			document.getElementById("title").value = unescape(data[0].data.title);
			document.getElementById("Id").value = id;
			setContent(data[0].data.content);
		}
	});
</script>

<script type="text/javascript">
	//实例化编辑器
	var um = UM.getEditor('myEditor');
	um.addListener('blur', function() {
		console.log('编辑器失去焦点了');
	});
	um.addListener('focus', function() {
		$('#focush2').html('');
	});
	//按钮的操作
	function insertHtml() {
		var value = prompt('插入html代码', '');
		um.execCommand('insertHtml', value)
	}
	function isFocus() {
		alert(um.isFocus())
	}
	function HTMLDecode(text) {
		var temp = document.createElement("div");
		temp.innerHTML = text;
		var output = temp.innerText || temp.textContent;
		temp = null;
		return output;
	}
	function doBlur() {
		um.blur()
	}
	function createEditor() {
		enableBtn();
		um = UM.getEditor('myEditor');
	}
	function getAllHtml() {
		alert(UM.getEditor('myEditor').getAllHtml())
	}
	function getContent() {
		var arr = [];
		arr.push(UM.getEditor('myEditor').getContent());
		document.getElementById("content").value=arr.join("\n");
		console.log(document.getElementById("content").value);
		var form = new FormData(document.getElementById("tf"));
		if (arr.join("\n") == null || arr.join("\n").length <= 0) {
			alert("内容不允许为空");
			return;
		}
		if (document.getElementById("title").value == null || document.getElementById("title").value == "" || document.getElementById("title").value.length <= 0) {
			alert("标题不允许为空");
			return;
		}
		$.ajax({
			url : "updateNews.do",
			data : form,
			type : "post",
			dataType : "json",
			processData : false,
			contentType : false,
			enctype : "multipart/form-data",
			success : function(data) {
				alert(data[0].message);
				self.location = document.referrer;
			}
		});
	}
	function getPlainTxt() {
		var arr = [];
		arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
		arr.push("内容为：");
		arr.push(UM.getEditor('myEditor').getPlainTxt());
		alert(arr.join('\n'))
	}
	function setContent(isAppendTo) {
		console.log(isAppendTo);
		var arr = [];
		isAppendTo = HTMLDecode(isAppendTo);
		UM.getEditor('myEditor').setContent(isAppendTo
		);
	// alert(arr.join("\n"));	
	}
	function setDisabled() {
		UM.getEditor('myEditor').setDisabled('fullscreen');
		disableBtn("enable");
	}

	function setEnabled() {
		UM.getEditor('myEditor').setEnabled();
		enableBtn();
	}

	function getText() {
		//当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
		var range = UM.getEditor('myEditor').selection.getRange();
		range.select();
		var txt = UM.getEditor('myEditor').selection.getText();
		alert(txt)
	}

	function getContentTxt() {
		var arr = [];
		arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
		arr.push("编辑器的纯文本内容为：");
		arr.push(UM.getEditor('myEditor').getContentTxt());
		alert(arr.join("\n"));
	}
	function hasContent() {
		var arr = [];
		arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
		arr.push("判断结果为：");
		arr.push(UM.getEditor('myEditor').hasContents());
		alert(arr.join("\n"));
	}
	function setFocus() {
		UM.getEditor('myEditor').focus();
	}
	function deleteEditor() {
		disableBtn();
		UM.getEditor('myEditor').destroy();
	}
	function disableBtn(str) {
		var div = document.getElementById('btns');
		var btns = domUtils.getElementsByTagName(div, "button");
		for (var i = 0, btn; btn = btns[i++];) {
			if (btn.id == str) {
				domUtils.removeAttributes(btn, [ "disabled" ]);
			} else {
				btn.setAttribute("disabled", "true");
			}
		}
	}
	function enableBtn() {
		var div = document.getElementById('btns');
		var btns = domUtils.getElementsByTagName(div, "button");
		for (var i = 0, btn; btn = btns[i++];) {
			domUtils.removeAttributes(btn, [ "disabled" ]);
		}
	}
</script>

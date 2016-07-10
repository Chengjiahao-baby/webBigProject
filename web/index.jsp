<%@ page import="com.cyan.entity.Course" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: cyan
  Date: 16/7/5
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- Bootstrap core CSS -->
    <link href="static/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <title>用户登陆</title>
</head>
<%
    String id = null;
    String msg = null;
    if (session != null) {
        id = (String) session.getAttribute("user");
        msg = (String) session.getAttribute("msg");
    }
%>
<body role="document">
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">学生社团管理系统</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/index">主页</a></li>
                <li><a href="/showAllClasses">所有课程</a></li>
                <li><a href="/showMyClasses">我的课程</a></li>
                <li><a href="/adminLogin.jsp">社团登录</a></li>
            </ul>
            <%
                if (id != null) {
            %>

            <ul class="nav navbar-nav navbar-right">
                <li><a><%=id%> 欢迎您!
                </a></li>
                <li><a id="change" href="#">修改密码</a></li>
                <li><a href="/logout">退出登录</a></li>
            </ul>
            <%
            } else {
            %>
            <form class="navbar-form navbar-right" action="/login" method="post">
                <div class="form-group">
                    <input type="text" placeholder="学号" class="form-control" name="id" required>
                </div>
                <div class="form-group">
                    <input type="password" placeholder="密码" class="form-control" name="pwd" required>
                </div>
                <button type="submit" class="btn btn-success">登录</button>
            </form>
            <%
                }
            %>
        </div><!--/.nav-collapse -->

    </div>
</nav>

<div class="container theme-showcase" role="main">
    <%
        if (msg != null) {
            if (msg == "修改成功!") {
    %>
    <div class="alert alert-success" style="margin-top: 50px" role="alert">
        <%
        } else {
        %>
        <div class="alert alert-danger" style="margin-top: 50px" role="alert">
            <%
                }
            %>
            <strong><%=msg%>
            </strong>
        </div>

        <%
                session.setAttribute("msg", null);
            }
        %>
        <div class="jumbotron">
            <h1>欢迎登陆学生社团管理系统!</h1>
            <p>This is a template for a simple marketing or informational website. It includes a large callout called a
                jumbotron and three supporting pieces of content. Use it as a starting point to create something more
                unique.</p>
        </div>


        <div class="container">
            <!-- Example row of columns -->
            <div class="row">
                <%
                    List<Course> clzs = (List<Course>) session.getAttribute("clzs");
                    if (!(clzs == null || clzs.isEmpty())) {
                        for (Course clz : clzs) {
                %>

                <div class="col-md-4">
                    <h2><%=clz.getName()%>
                    </h2>
                    <p>所属社团:<%=clz.getBelong()%>
                    </p>
                    <p><%=clz.getDetail()%>
                    </p>
                    <p><a class="btn btn-default" href="/showDetail?id=<%=clz.getId()%>" role="button">View
                        details &raquo;</a></p>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </div>
</div>
<script src="static/js/jquery-3.0.0.min.js"></script>
<script src="static/js/layer.js"></script>
<script>
    $('#change').on('click', function () {
        layer.open({
            type: 1,
            area: ['300px', '280px'],
            shadeClose: false, //点击遮罩关闭
            content: '<div class="container col-md-8">' +
            '<form class="form-signin" action="/changePwd" method="post">' +
            '<h2 class="form-signin-heading">修改密码</h2>' +
            '<input type="password" name="old" class="form-control" placeholder="旧密码" required autofocus>' +
            '<input type="password" name="newpwd" class="form-control" placeholder="新密码" required>' +
            '<input type="password" name="newagain" class="form-control" placeholder="确认新密码" required>' +
            '<button class="btn btn-lg btn-primary btn-block" type="submit">确认</button>' +
            '</form>' +
            '</div>'
        });
    });
</script>
</body>
</html>

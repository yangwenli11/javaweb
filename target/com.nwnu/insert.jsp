<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE HTML>
<html>
  <head>
    
    <title>新增用户</title>
    
  </head>
  <body>
<form action="/index/insertServlet" method="post">
   请输入id：    <input type="text" name="id"><br/>
   请输入姓名：<input type="text" name="name"><br/>
    请输入密码：<input type="text" name="password"><br/>
    <input type="submit" value="提交">
</form>
  </body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>简易的增删改查</title>
    <script type="text/javascript" src="./js/xlsx.core.min.js"></script>
</head>
<style>
    #file-value-input {
        display: none !important;
    }
    body{
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        justify-content: center;
        padding: 20px 40px;
    }
    li{
        list-style: none;
    }
    .action-wrap{
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
    }
    .action-wrap li{
        margin: 10px 20px;
    }
    .action-wrap li a{
        display: block;
        padding: 10px 20px;
    }
</style>
<body background="5.jpg">
<h1>
    请选择您的操作
</h1>
<ul class="action-wrap">
    <li class="action-a-wrap">
        <a href="dele.jsp">删除用户</a>
    </li>
    <li class="action-a-wrap">
        <a href="insert.jsp">添加用户</a>
    </li>
    <li class="action-a-wrap">
        <a href="update.jsp">修改用户数据</a>
    </li>
    <li class="action-a-wrap">
        <a href="search.jsp">查询用户数据</a>
    </li>
    <li class="action-a-wrap">
        <a href="allShow.jsp">查看全部用户数据</a>
    </li>
</ul>

<form id="file_form" action="/index/uploadServlet"
      method="post">
    <input id="file-input" type="file" name="file" id="file_input"
           accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
    <input id="file-value-input" type="text" name="file-users-value"/>
    <input id="btn-input" type="button" value="上传Excel" id='upFile-btn'>
</form>
<table id="users-table" style="display:none;margin-top: 20px;" border=1>
    <tbody>
    <tr>
        <td>id</td>
        <td>name</td>
        <td>password</td>
    </tr>
    </tbody>
</table>
<script>
    const type = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    const fileForm = document.getElementById("file_form");
    const usersTable = document.getElementById("users-table");
    let fileInput = document.getElementById("file-input");
    let valueInput = document.getElementById("file-value-input");
    let btn = document.getElementById("btn-input");
    let file = null;
    let users = [];

    btn.addEventListener("click", () => {
        if (file == null) {
        alert("请选择文件");
        return;
    }else {
        if(users.length > 0){
            let usersString = JSON.stringify(users);
            valueInput.value = usersString;
            fileForm.submit();
        }
    }

    });

    fileInput.addEventListener("change", fe => {

        let tableChildren = usersTable.children;

    for (let i = tableChildren.length - 1; i >= 1; i--) {
        console.log(i);
        console.log(tableChildren[i]);
        usersTable.removeChild(tableChildren[i]);
    }
    usersTable.style.display = "none";
    if (fe.target.files[0] != null) {
        let fileType = fe.target.files[0].type;
        if (fileType != type) {
            alert("文件格式不支持，仅支持excel表格文件");
            fileInput.value = "";
            file = null;
            users = [];
        } else {
            // 文件格式支持
            file = fe.target.files[0];
            let fileReader = new FileReader();
            fileReader.addEventListener("load", re => {
                try {
                    var data = re.target.result;
            var workbook = XLSX.read(data, {
                type: "binary"
            });
        } catch (err) {
                users = [];
                file = null;
                fileInput.value = "";
                alert("文件格式错误");
            }
            let fromTo = "";
            for (var sheet in workbook.Sheets) {
                if (workbook.Sheets.hasOwnProperty(sheet)) {
                    fromTo = workbook.Sheets[sheet]["!ref"];
                    if (fromTo != undefined) {
                        users = XLSX.utils.sheet_to_json(workbook.Sheets[sheet]);
                        console.log(users);
                    }
                }
            }
            usersTable.style.display = "table";
            for (var index in users) {
                let user = users[index];
                let id = user.id;
                let name = user.name;
                let password = user.password;

                if (id == "" || id == null || id == undefined) {
                    id = "null";
                }
                if (name == "" || name == null || name == undefined) {
                    name = "null";
                }
                if (password == "" || password == null || password == undefined) {
                    password = "null";
                }

                let tr = document.createElement("tr");
                tr.innerHTML = "<td>" + id + "</td>" + "<td>" + name + "</td>" + "<td>" + password + "</td>";
                usersTable.appendChild(tr);
            }
        });
            fileReader.readAsBinaryString(file);
        }
        console.log(file);
    } else {
        alert("用户取消操作");
    }
    });

</script>
</body>
</html>

package servlet;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import entity.User;
import model.Model;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;

/**
 * 2023/4/29 make by YangWei
 */
@MultipartConfig
@WebServlet("/uploadServlet")
public class uploadServlet extends HttpServlet {
    public uploadServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");

        String usersString = req.getParameter("file-users-value");
        if (!"".equals(usersString)){
            JSONArray jsonArray = JSON.parseArray(usersString);
            Model model = new Model();
            String msg = "通过excel文件批量添加：<br/>";
            for (Object o:
                 jsonArray) {
                User user = JSON.toJavaObject(JSON.parseObject(o.toString()), User.class);
                int i = model.insert(user.getId(), user.getName(), user.getPassword());
                if (i > 0){
                    msg += "用户 " + user.getName() + " 添加成功<br/>";
                }else {
                    msg += "用户 " + user.getName() + " 添加失败<br/>";
                }
            }
            req.setAttribute("msg", msg);
            System.out.println(msg);
            req.getRequestDispatcher("insertShow.jsp").forward(req, resp);
        }
    }
}

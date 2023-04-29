package servlet;

import model.Model;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/insertServlet")
public class insertServlet extends HttpServlet {
    public insertServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");

        String msg = "通过用户输入添加：<br/>";

        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String password = req.getParameter("password");

        if (!"".equals(id) && !"".equals(name) && !"".equals(password)){
            Model model = new Model();
            int i = model.insert(Integer.valueOf(id), name, password);
            if (i > 0){
                msg += "用户 " + name + " 添加成功";
            }else{
                msg += "用户 " + name + " 添加失败";
            }
        }

        req.setAttribute("msg", msg);
        System.out.println(msg);
        req.getRequestDispatcher("insertShow.jsp").forward(req, resp);
    }
}

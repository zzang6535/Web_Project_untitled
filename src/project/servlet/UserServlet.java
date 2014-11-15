package project.servlet;

import java.awt.List;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import project.*;

/**
 * Servlet implementation class User
 */
@WebServlet("/user")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
    }


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String page = request.getParameter("page");
		String actionUrl = "";
		boolean ret;
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request,  response);
		
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = request.getParameter("mode");
		String actionUrl ="index.jsp";
		User user = null;
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		if(mode.equals("login"))
		{
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			try {
				user = UserDAO.login(id, pw);
			} catch (NoSuchAlgorithmException | SQLException | NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(user != null)
			{
				session.setAttribute("id",user.getId());
		        session.setAttribute("name",user.getName());
		        session.setAttribute("gender",user.getGender());
		        session.setAttribute("email",user.getEmail());
		        session.setAttribute("tel",user.getTel());
			}
		}
		else if(mode.equals("logout"))
		{
			session.invalidate();
		}
		else if(mode.equals("join"))
		{
			User u = null;
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String gender = request.getParameter("gender");
			String email = request.getParameter("email");
			String tel = request.getParameter("tel");
			
			ArrayList<String> errorMsgs = new ArrayList<String>();
			boolean ret = false;
			
			//중복된 아이디 검사
			try {
				if(UserDAO.checkUser(id))
				{
					errorMsgs.add("이미 "+ id + " 사용자가 있습니다.");
				}
			} catch (SQLException | NamingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if (id == null || id.trim().length() == 0) {
				errorMsgs.add("ID를 반드시 입력해주세요.");
			}
			
			if (name == null || name.trim().length() == 0) {
				errorMsgs.add("이름을 반드시 입력해주세요.");
			}
			
			if (gender == null || !(gender.equals("M") || gender.equals("F") )) {
				errorMsgs.add("성별에 적합하지 않은 값이 입력되었습니다.");
			}

			if (errorMsgs.size() == 0) 
			{
				u = new User(0, id, pw, name, gender, email, tel);
				try {
					if (UserDAO.createUser(u)) 
					{
						ret = true;
						request.setAttribute("msg", id+" 가입완료");
						actionUrl = "action/success.jsp";
					}
					else
					{
						errorMsgs.add("변경에 실패하였습니다.");
						request.setAttribute("errorMsgs", errorMsgs);
						actionUrl = "action/error.jsp";
					}
				} catch (NoSuchAlgorithmException | SQLException
						| NamingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(actionUrl);
		dispatcher.forward(request,  response);
	}

}
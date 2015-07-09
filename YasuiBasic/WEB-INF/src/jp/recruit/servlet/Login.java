package jp.recruit.servlet;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import jp.recruit.bean.ContentsBean;
import jp.recruit.bean.UserBean;
import jp.recruit.logic.ListContentsLogic;
import jp.recruit.logic.LoginCheckLogic;
public class Login extends HttpServlet {
	private static final long serialVersionUID = -856700274893456786L;

	protected void doPost(HttpServletRequest req , HttpServletResponse res)
			throws ServletException,IOException {
		//ログインフラグを設定（ログイン成功時のみtrueになる）
		Boolean isLogin = false;

		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		//エラー用のArrayList
		ArrayList<String> error = new ArrayList<String>();
		ServletContext sc=null;
		String destination=null;
		//セッションの取得
		HttpSession session = req.getSession(true);
		//エラーを引き継ぐ場合にArrayListにマージ処理
		@SuppressWarnings("unchecked")
		ArrayList<String> temp = (ArrayList<String>)session.getAttribute("errormessage");
		if(temp != null){
			for(String message:temp){
				error.add(message);
			}
			session.removeAttribute("errormessage");
		}
		//ログイン処理が成功に終わった時の転送先
		destination = "/ListItem";
		//ユーザーの基本情報
		String username="";
		String password="";
		//使用するオブジェクトの初期化
		UserBean userBean= new UserBean();

		HashMap<String,ContentsBean> contentsMap = null;

		//ServletContextオブジェクトを取得
		sc = this.getServletContext();
		//顧客IDの取得
		username=req.getParameter("username").trim();
		//パスワードの取得
		password=req.getParameter("password").trim();

		//ユーザー名とパスワードが空でなかったらログインチェック
		if((username!=null&&!username.isEmpty())&&(password!=null&&!password.isEmpty())){
			try{
				LoginCheckLogic loginCheck = new LoginCheckLogic();
				//データベースに接続して、ユーザー情報を取得
				//ユーザーが存在した
				if(loginCheck.authCheck(username, password)){
					isLogin=true;
				}else{
					//ユーザー名かパスワードが間違っている場合の処理
					error.add("ログイン処理に失敗しました。ユーザー名とパスワードが間違っている可能性があります");
				}
			}catch(SQLException|NamingException e){
				error.add("(LoginServlet)ログイン処理に失敗しました。データベースに障害が発生している可能性があります"+e.getMessage());
			}
		}else{//ユーザー名とパスワードが空だった場合の処理
			error.add("(LoginServlet)ログイン処理に失敗しました。ユーザー名とパスワードは省略できません。");
		}
		try{
			//データベースに接続して、TDK情報を管理する情報を取得
			ListContentsLogic listContents = new ListContentsLogic();
			contentsMap = listContents.getContentsMap();
		}catch(SQLException|NamingException e){
			error.add("(LoginServlet)コンテンツの取得処理に失敗しました"+e.getMessage());
			destination="/index";
		}
		//ログインが成功した場合(isLoginがtrueかつ、errorが空だった
		if(isLogin&&error.isEmpty()){
			//セッションを再作成する
			session.invalidate();
			session = req.getSession(true);
			//ログイン属性詰め直し
			session.setAttribute("username", userBean.getName());
			session.setAttribute("descript", userBean.getDescript());
			session.setAttribute("id", userBean.getId());
			session.setAttribute("role", userBean.getRole());
			if(userBean.getRole().equalsIgnoreCase("administrator")){
				destination="/AddItem";
			}else{
				destination="/ListItem";
			}
		}else{  //最終的になんらかの障害が発生している
			error.add("(LoginServlet)ログインに失敗しました。");
			session.setAttribute("errormessage",error);
			isLogin=false;
			destination="/WEB-INF/jsp/common/LoginError.jsp";
		}
		//コンテンツ情報をセッションに設定
		session.setAttribute("contents", contentsMap);
		//ログインフラグをセッションに格納
		session.setAttribute("isLogin", isLogin);
		// ServletContextオブジェクトを取得
		sc = this.getServletContext();
		// RequestDispatcherオブジェクトを取得
		RequestDispatcher rd = sc.getRequestDispatcher(destination);
		// forwardメソッドで、処理をreceive.jspに転送
		rd.forward(req, res);
		return;
	}
}

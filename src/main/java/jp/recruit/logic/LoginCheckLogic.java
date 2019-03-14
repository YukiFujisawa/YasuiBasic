package jp.recruit.logic;

import java.sql.SQLException;

import javax.naming.NamingException;

import jp.recruit.bean.UserBean;
import jp.recruit.dao.UserDao;
import org.apache.commons.lang3.StringUtils;

public class LoginCheckLogic extends AbstractLogic {

	public LoginCheckLogic() {

	}
	/**
	 * DAOを呼び出してユーザーをユーザー名とパスワードで検索する
	 * @param username
	 * @param password
	 * @return 発見できたらそのユーザーのUserBean、できなかったらnull
	 * @throws SQLException
	 * @throws NamingException
	 */
	public UserBean authCheck(String username,String password)throws SQLException,NamingException{
		UserDao userDao = new UserDao();
		UserBean userBean = null;
		//ユーザー名とパスワードが空でなかったらログインチェック
		System.out.println("userBean::" + username + "," + password);
		if(StringUtils.isNotEmpty(username) && StringUtils.isNotEmpty(password)){
			try{
				//データベースに接続して、ユーザー情報を取得
				userDao.getConnection();
				userBean=userDao.getUserByName(username,password);
				System.out.println("userBean::" + userBean);
				//ユーザー情報が取得でき、パスワードが一致したらログイン成功
				if(userBean!=null&&userBean.getPasswd().equals(password)){
					return userBean;
				}
			}catch (Exception e){
				e.printStackTrace();
			}finally{
				//データベースと切断
				userDao.closeConnection();
			}
		}
		//ここまで来たらログインは失敗
		return null;
	}
}

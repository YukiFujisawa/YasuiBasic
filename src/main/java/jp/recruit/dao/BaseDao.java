package jp.recruit.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

abstract public class BaseDao {
	//親クラスなのでフィールドはprotectedで作成する
	protected Connection con = null;
	protected String localName = "java:comp/env/jdbc/yasui";
	protected DataSource ds = null;
	protected Context context = null;

	// DBに接続
	public Connection getConnection() throws NamingException, SQLException{
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}catch (ClassNotFoundException e){
			e.printStackTrace();
		}

		con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/mydb?" +
				"user=yasui&password=password&useUnicode=true&characterEncoding=utf-8&useSSL=false");

		if (con != null){
			return con;
		}

		//コンテキストの生成
		context = new InitialContext();
		//コンテキストを検索
		ds = (DataSource)context.lookup(localName);
		// データベースへ接続
		con = ds.getConnection();
		return con;
	}

	// DBとの切断
	public void closeConnection() throws SQLException{
		if(con != null){
			con.close();
		}
	}
}

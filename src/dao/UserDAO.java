package dao;

import java.security.NoSuchAlgorithmException;
import java.sql.*;

import javax.naming.*;
import javax.sql.*;

import bean.User;

public class UserDAO {   
	private static Connection conn;

	public static DataSource getDataSource() throws NamingException {
		Context initCtx = null;
		Context envCtx = null;

		// Obtain our environment naming context
		initCtx = new InitialContext();
		envCtx = (Context) initCtx.lookup("java:comp/env");

		// Look up our data source
		return (DataSource) envCtx.lookup("jdbc/WebDB");
	}
	
	public static boolean checkUser(String id) throws SQLException, NamingException
	{
		boolean check = false;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;		
		
		DataSource ds = getDataSource();
		
    	try 
    	{
			conn = ds.getConnection();			
			
			stmt = conn.prepareStatement(
					"SELECT id FROM users " +
					"WHERE id=?"
					);
			stmt.setString(1,  id);
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				check = true;
			}
		}
    	finally 
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
    	return check;
	}
	
	
	public static boolean createUser(User user) throws SQLException, NamingException, NoSuchAlgorithmException
	{
		int result = 0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
			
		try 
		{
			conn = ds.getConnection();		    
			stmt = conn.prepareStatement(
					"INSERT INTO users " +
					"(join_type, id, pw, name, email, tel, gender) " +
					"VALUES " +
					"(?, ?, md5(?), ?, ?, ?, ?); " 
					);
			stmt.setString(1,  user.getJoin_type());
			stmt.setString(2,  user.getId());
			stmt.setString(3,  user.getPw());
			stmt.setString(4,  user.getName());
			stmt.setString(5,  user.getEmail());
			stmt.setString(6,  user.getTel());
			stmt.setString(7,  user.getGender());
			
			result = stmt.executeUpdate();
		}
		catch (SQLException e)
		{
		} 
		finally
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		return (result == 1);
	}
	
	public static boolean updateUser(User user) throws SQLException, NamingException, NoSuchAlgorithmException
	{
		int result;

		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
	    
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement(
					"UPDATE users " +
					"SET pw=md5(?), name=?, email=?, tel=?, gender=? " +
					"WHERE id=?"
					);
			stmt.setString(1,  user.getPw());
			stmt.setString(2,  user.getName());
			stmt.setString(3,  user.getEmail());
			stmt.setString(4,  user.getTel());
			stmt.setString(5,  user.getGender());
			stmt.setString(6,  user.getId());
			
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);		
	}
	
	public static boolean removeUser(String id, String pw) throws NamingException, SQLException, NoSuchAlgorithmException {
		int result = 0;
		User u = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
		u = UserDAO.login(id, pw);
		if(u != null)
		{
			try {
				conn = ds.getConnection();
	
				// 질의 준비
				stmt = conn.prepareStatement("DELETE FROM users WHERE idx=?");
				stmt.setInt(1, u.getIdx());
				
				// 수행
				result = stmt.executeUpdate();
			} finally {
				// 무슨 일이 있어도 리소스를 제대로 종료
				if (rs != null) try{rs.close();} catch(SQLException e) {}
				if (stmt != null) try{stmt.close();} catch(SQLException e) {}
				if (conn != null) try{conn.close();} catch(SQLException e) {}
			}
		}
		
		return (result == 1);		
	}
	
	public static User login(String id, String pw) throws SQLException, NamingException, NoSuchAlgorithmException
	{
		User user = null;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		DataSource ds = getDataSource();
	    
	    try 
	    {
			conn = ds.getConnection();
			stmt = conn.prepareStatement(
					"SELECT * FROM users " +
					"WHERE id=? AND pw=md5(?) "
					);
			stmt.setString(1,  id);
			stmt.setString(2,  pw);
			
			rs = stmt.executeQuery();
		    
			while(rs.next())
		    {                  
				user = new User(rs.getInt("idx")
						,rs.getString("join_type")
						,rs.getString("id")
						,rs.getString("pw")
						,rs.getString("name")
						,rs.getString("email")
						,rs.getString("tel")
						,rs.getString("gender")
						,rs.getString("adm"));
		    }				
	    }
	    catch (SQLException e)
		{
		} 
		finally
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	    return user;
	}
}

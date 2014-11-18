package project;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDAO {
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
	
	public static void boardCntIncrement(int id) throws NamingException, SQLException
	{
		conn = null;
		PreparedStatement stmt = null;
		DataSource ds = getDataSource();
		
		try
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"UPDATE board SET cnt = cnt+1 " +
					"WHERE b_id=?"
					);
			stmt.setInt(1, id);
			stmt.executeUpdate();	
		}
		catch (SQLException e)
		{					
		} 
		finally
		{
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
	
	public static Board boardView(int id) throws NamingException, SQLException
	{
		Board board = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try 
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"SELECT * FROM board " +
					"WHERE b_id=?"
					);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();							

		    while(rs.next())
		    {
		    	board = new Board( rs.getInt("b_id")
		    			,rs.getString("name")
		    			,rs.getString("u_id")
		    			,rs.getString("title")
		    			,rs.getString("content")
		    			,rs.getString("wtime")
		    			,rs.getInt("cnt")
		    			,rs.getString("ofilename")
		    			,rs.getString("sfilename")
		    			);
		    	
		    	if(rs.getString("name").equals("notice"))
		    	{
		    		board.setKname("공지사항");
		    	}
		    	else if(rs.getString("name").equals("event"))
		    	{
		    		board.setKname("이벤트");
		    	}
		    	else
		    	{
		    		board.setKname("name");
		    	}						
		    }		
		    boardCntIncrement(id);
		    return board;
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
		return board;
	}

	public static int boardListCnt(String boardName) throws NamingException
	{
		int cnt=0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try 
		{
			conn =  ds.getConnection();
			stmt = conn.prepareStatement(
					"SELECT count(*) AS total FROM board " +
					"WHERE name=?"
					);
			stmt.setString(1, boardName);
			rs = stmt.executeQuery();
			
		    while(rs.next())
		    {                
		    	cnt = rs.getInt("total");
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
		return cnt;
	}
	public static boolean writeBoard(Board board) throws SQLException, NamingException, NoSuchAlgorithmException
	{
		int result = 0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
			
		try 
		{
			conn = ds.getConnection();
				    
			stmt = conn.prepareStatement(
					"INSERT INTO board " +
							"(name, title, content, u_id, ofilename, sfilename, wtime) " +
							"VALUES " +
							"(?, ?, ?, ?, ?, ?, NOW())" 
					);
			stmt.setString(1,  board.getName());
			stmt.setString(2,  board.getTitle());
			stmt.setString(3,  board.getContent());
			stmt.setString(4,  board.getU_id());
			stmt.setString(5,  board.getOfilename());
			stmt.setString(6,  board.getSfilename());
			
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
	
	public static boolean updateBoard(Board board) throws SQLException, NamingException, NoSuchAlgorithmException
	{
		int result;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
	    
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement(
					"UPDATE board " +
					"SET title=?, content=? " +
					"WHERE b_id=?"
					);
			stmt.setString(1,  board.getTitle());
			stmt.setString(2,  board.getContent());
			stmt.setInt(3,  board.getB_id());
			
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);		
	}
	
	public static boolean removeBoard(String b_id, String u_id) throws NamingException, SQLException {
		int result = 0;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();
		
		try {
			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("DELETE FROM board WHERE b_id=? AND u_id=?");
			stmt.setInt(1, Integer.parseInt(b_id));
			stmt.setString(2, u_id);
			
			// 수행
			result = stmt.executeUpdate();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return (result == 1);		
	}
	
	public static PageResult<Board> getPage(String boardName, int page, int numItemsInPage) 
			throws SQLException, NamingException 
	{
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DataSource ds = getDataSource();

		if (page <= 0) 
		{
			page = 1;
		}
		PageResult<Board> result = new PageResult<Board>(numItemsInPage, page);
		
		int startPos = (page - 1) * numItemsInPage;

    	try 
    	{ 
			result.setNumItems(boardListCnt(boardName));

			conn = ds.getConnection();

			// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM board WHERE name=? ORDER BY b_id DESC LIMIT " + startPos + ", " + numItemsInPage);
			stmt.setString(1, boardName);
			rs = stmt.executeQuery();	
			
			while(rs.next()) 
			{
				result.getList().add(new Board( rs.getInt("b_id")
		    			,rs.getString("name")
		    			,rs.getString("u_id")
		    			,rs.getString("title")
		    			,rs.getString("content")
		    			,rs.getString("wtime")
		    			,rs.getInt("cnt")
		    			,rs.getString("ofilename")
		    			,rs.getString("sfilename")
		    			));
			}
		}
    	finally 
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		
		return result;		
	}        
}

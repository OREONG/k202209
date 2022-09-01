package ch10;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDao {
	//singleton
	private static MemberDao instance = new MemberDao();
	private MemberDao() {}
	public static MemberDao getInstance() {
		return instance;
	}
	
	//DataBase Connection Pool
	private Connection getConnection() {
		Connection conn = null;
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
			
		}catch (Exception e) {
			System.out.println("연결 에러 : "+ e.getMessage());
		}
		return conn;
	}
	
	public int cofirm(String id) {
		int result = 0;
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from member2 where id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  id);
			rs = pstmt.executeQuery();
			if (rs.next()) result = 1; // id에 해당하는 데이터가 table에 존재
			else result = 0;			//           "            없음
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e) {}
		}
		return result;
	}
	
	public int insert(Member member) {
		int result=0;
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into member2 values(?,?,?,?,?,sysdate,'n')";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getTel());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
	
	public int loginChk(String id, String password) {
		int result=0;
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select password from member2 where id=? and del='n'";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String dbPass = rs.getString("password");
				if (dbPass.equals(password)) result = 1; // 아이디 암호가 일치
				else result = 0; // 아이디는 같지만 암호는 다름
			} else result = -1; // 없는 아이디
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {				
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
	
	public Member select(String id) {
		Member member = new Member();
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from member2 where id=? and del !='y'";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member.setId(rs.getString("id"));
				member.setPassword(rs.getString("password"));
				member.setName(rs.getString("name"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
				member.setReg_date(rs.getDate("reg_date"));
				member.setDel(rs.getString("del"));
			} 
		}catch (Exception e) {  System.out.println(e.getMessage());
		}finally {
			try{if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn !=  null) conn.close();  
			}catch (Exception e) {	}
		}
		return member;		
	}
	
	public int update(Member member) {
		int result=0;
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		String sql = "update member2 set password=?,name=?,address=?,tel=? where id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getAddress());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getId());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
			}
		}
		return result;
	}
	
	public int delete(String id) {
		int result = 0;
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
//		String sql="delete from member2 where id=?";
		String sql = "update member2 set del='y' where id=?";
		try {
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, id);
			
			result = pstmt.executeUpdate();
		}catch (Exception e) {  System.out.println(e.getMessage());
		}finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn !=  null) conn.close();  
			}catch (Exception e) {	}
		}
		return result;		
	}
	
	public List<Member> list(int startRow, int endRow) {
		List<Member> list = new ArrayList<>();
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from (select rowNum rn, a.* from (select * from member2 "+
				" order by reg_date desc)a)where rn between ? and ? ";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Member member = new Member();
				member.setId(rs.getString("id"));
				member.setPassword(rs.getString("password"));
				member.setName(rs.getString("name"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
				member.setReg_date(rs.getDate("reg_date"));
				member.setDel(rs.getString("del"));
				
				list.add(member);

			} 
		}catch (Exception e) {  System.out.println(e.getMessage());
		}finally {
			try{if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn !=  null) conn.close();  
			}catch (Exception e) {	}
		}
		return list;		
	}
	
	public int getTotal() {
		int total = 0;
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from member2";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return total;
	}
	
}

	
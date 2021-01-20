package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DbcpBean;

public class BoardDao {
	private static BoardDao dao;
	private BoardDao() {}
	public static BoardDao getInstance() {
		if(dao==null) {
			dao=new BoardDao();
		}
		return dao;
	}//getInstance END
	
	//글 하나의 정보를 추가하는 메소드
	public boolean insert(BoardDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "INSERT INTO board"
					+ " VALUES(board_seq.NEXTVAL, ?, ?, ?, 0, SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			flag = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)pstmt.close();
				if (conn != null)conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}//insert END
	
	//글 전체 목록을 리턴하는 메소드
	public List<BoardDto> getList(BoardDto dto){
		//글목록을 담을 ArrayList 객체 생성
		List<BoardDto> list=new ArrayList<BoardDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			//select 문 작성
			String sql = "SELECT *" + 
					"		FROM" + 
					"		    (SELECT result1.*, ROWNUM AS rnum" + 
					"		    FROM" + 
					"		        (SELECT num,writer,title,viewCount,regdate" + 
					"		        FROM board" + 
					"		        ORDER BY num DESC) result1)" + 
					"		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setInt(1, dto.getStartRowNum());
			pstmt.setInt(2, dto.getEndRowNum());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			while (rs.next()) {
				BoardDto dto2=new BoardDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				list.add(dto2);
			}
		} catch (Exception e) {
			e.printStackTrace();
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
		return list;
	}//getList END

	//<제목> 검색 목록을 리턴하는 메소드
	public List<BoardDto> getListT(BoardDto dto){
		//글목록을 담을 ArrayList 객체 생성
		List<BoardDto> list=new ArrayList<BoardDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			//select 문 작성
			String sql = "SELECT *" + 
					"		FROM" + 
					"		    (SELECT result1.*, ROWNUM AS rnum" + 
					"		    FROM" + 
					"		        (SELECT num,writer,title,viewCount,regdate" + 
					"		        FROM board" + 
					"				WHERE title LIKE '%'||?||'%'"+ 
					"		        ORDER BY num DESC) result1)" + 
					"		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getTitle());
			pstmt.setInt(2, dto.getStartRowNum());
			pstmt.setInt(3, dto.getEndRowNum());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			while (rs.next()) {
				BoardDto dto2=new BoardDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				list.add(dto2);
			}
		} catch (Exception e) {
			e.printStackTrace();
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
		return list;
	}//getListT END
	
	//<작성자> 검색 목록을 리턴하는 메소드
	public List<BoardDto> getListW(BoardDto dto){
		//글목록을 담을 ArrayList 객체 생성
		List<BoardDto> list=new ArrayList<BoardDto>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			//select 문 작성
			String sql = "SELECT *" + 
					"		FROM" + 
					"		    (SELECT result1.*, ROWNUM AS rnum" + 
					"		    FROM" + 
					"		        (SELECT num,writer,title,viewCount,regdate" + 
					"		        FROM board" + 
					"				WHERE writer LIKE '%'||?||'%'"+ 
					"		        ORDER BY num DESC) result1)" + 
					"		WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getWriter());
			pstmt.setInt(2, dto.getStartRowNum());
			pstmt.setInt(3, dto.getEndRowNum());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			while (rs.next()) {
				BoardDto dto2=new BoardDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setTitle(rs.getString("title"));
				dto2.setViewCount(rs.getInt("viewCount"));
				dto2.setRegdate(rs.getString("regdate"));
				list.add(dto2);
			}
		} catch (Exception e) {
			e.printStackTrace();
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
		return list;
	}//getListW END
	
	//인자로 전달되는 글 번호에 해당하는 글정보를 리턴하는 메소드
	public BoardDto getData(int num) {
		BoardDto dto=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT writer, title, content, viewCount, regdate"
					+ " FROM board"
					+ " WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setInt(1, num);
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			if (rs.next()) {
				dto=new BoardDto();
				dto=new BoardDto();
				dto.setNum(num);
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setViewCount(rs.getInt("viewCount"));
				dto.setRegdate(rs.getString("regdate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)rs.close();
				if (pstmt != null)pstmt.close();
				if (conn != null)conn.close();
			} catch (Exception e) {
			}
		}
		return dto;
	}//getData END
	
	//인자로 전달되는 글번호를 이용해서 삭제하는 메소드
	public boolean delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "DELETE FROM board"
					+ " WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setInt(1, num);
			flag = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)pstmt.close();
				if (conn != null)conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}//delete END
	
	//인자로 전달되는 글 내용을 수정 반영하는 메소드
	public boolean update(BoardDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "UPDATE board"
					+ " SET title=?, content=?"
					+ " WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//?에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
			flag = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)pstmt.close();
				if (conn != null)conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}//update END
	
	//글 조회수를 올리는 메소드
	public boolean addViewCount(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try {
			conn = new DbcpBean().getConn();
			//실행할 insert, update, delete 문 구성
			String sql = "UPDATE board"
					+ " SET viewCount=viewCount+1"
					+ " WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			//? 에 바인딩할 내용이 있으면 바인딩한다.
			pstmt.setInt(1, num);
			flag = pstmt.executeUpdate(); //sql 문 실행하고 변화된 row 갯수 리턴 받기
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}
	}//addViewCount END
	
	public int getCount() {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
					+ " FROM board";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.

			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
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
		return count;
	}//getCount END
	
	//<제목> 검색인 경우의 row 의 개수
	public int getCountT(BoardDto dto) {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
					+ " FROM board"
					+ " WHERE title LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getTitle());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
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
		return count;
	}//getCountT END

	//<작성자> 검색인 경우의 row 의 개수
	public int getCountW(BoardDto dto) {
		//글의 갯수를 담을 지역변수 
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			//select 문 작성
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num "
					+ " FROM board"
					+ " WHERE writer LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			// ? 에 바인딩 할게 있으면 여기서 바인딩한다.
			pstmt.setString(1, dto.getWriter());
			//select 문 수행하고 ResultSet 받아오기
			rs = pstmt.executeQuery();
			//while문 혹은 if문에서 ResultSet 으로 부터 data 추출
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
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
		return count;
	}//getCountW END
}//Class END
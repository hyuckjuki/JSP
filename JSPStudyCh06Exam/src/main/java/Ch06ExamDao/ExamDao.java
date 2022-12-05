package Ch06ExamDao;

import java.sql.*;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


import Ch06ExamVo.ExamVo;


public class ExamDao {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;

// 생성자 인마
	public ExamDao() {
		try {
			Context initContext = new InitialContext();
			
			Context envContext = (Context) initContext.lookup("java:/comp/env");
	   	  
			ds = (DataSource) envContext.lookup("jdbc/bbsDBPool"); 
		} catch(NamingException e) {
			System.out.println("ExamDao() - NamingException");
	        e.printStackTrace();
		} catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
// 수정폼 입력 데이터를 DB에 저장하는 놈 - update 쿼리
	public void updateBoard(ExamVo v) {
	      
	      String sqlInsert = "UPDATE "
	            + "music SET mname=?, writer=?, "
	            + "vocal=?, content=?, wdate=?, cover=? WHERE no=?";
      
	      try {
	         // 2. DB에 연결된 Connection 객체를 구함
	    	  conn = ds.getConnection();
	         // 3. 쿼리를 발행해 주는 PreaparedStatement 객체를 구함
	         pstmt = conn.prepareStatement(sqlInsert);
	         // 4. 쿼리에 있는 placeholder(?)에 대한 값을 설정
	         pstmt.setString(1, v.getMname());
	         pstmt.setString(2, v.getWriter());
	         pstmt.setString(3, v.getVocal());
	         pstmt.setString(4, v.getContent());
	         pstmt.setDate(5, v.getWdate());
	         pstmt.setString(6, v.getCover());
	         pstmt.setInt(7, v.getNo());
	         
	         // 5. DB에 쿼리를 발행
	         pstmt.executeUpdate();
	         
	      } catch(SQLException e) {
	         System.out.println("ExamDao - updateBoard() : SQLException");
	         e.printStackTrace();
	      } finally {
	         try {
	         // db에 작업에 사용한 객체를 역순으로 닫음
	         if(pstmt != null)pstmt.close();
	         if(conn != null)conn.close();
	      } catch(SQLException e) {}
	   }
	 }

// db안의 데이터를 삭제하는 놈 - delete 쿼리
   public void deleteBoard(int no) {
		      
	      String sqlInsert = "DELETE FROM music WHERE no=?";
	      
	      try {
	         // 2. DB에 연결된 Connection 객체를 구함
	    	  conn = ds.getConnection();
	         // 3. 쿼리를 발행해 주는 PreaparedStatement 객체를 구함
	         pstmt = conn.prepareStatement(sqlInsert);
	         // 4. 쿼리에 있는 placeholder(?)에 대한 값을 설정
	         pstmt.setInt(1,	 no);
	         
	         // 5. DB에 쿼리를 발행
	         pstmt.executeUpdate();
	         
	      } catch(SQLException e) {
	         System.out.println("ExamDao - updateBoard() : SQLException");
	         e.printStackTrace();
	      } finally {
	         try {
	         // db에 작업에 사용한 객체를 역순으로 닫음
	         if(pstmt != null)pstmt.close();
	         if(conn != null)conn.close();
	      } catch(SQLException e) {}
	   }
	 }

// 입력한 비밀번호가 db의 비밀번호와 같은지 체크
   public boolean isPassCheck(int no, String pass) {
	   boolean isPassCheck = false;
	   
	   String sqlBoard = "SELECT pass FROM music WHERE no=?";
	      
	      try {
	         // 2. DB에 연결된 Connection 객체를 구함
	    	  conn = ds.getConnection();
	         // 3. 쿼리를 발행해 주는 PreaparedStatement 객체를 구함
	         pstmt = conn.prepareStatement(sqlBoard);
	         // 4. 쿼리에 있는 placeholder(?)에 대한 값을 설정
	         pstmt.setInt(1, no);
	         // 5. DB에 쿼리를 발행하고 결과 집합을 받음
	         rs = pstmt.executeQuery();
	         
	         // 결과집합에서 필요한 데이터를 추출 -> Board 객체로 만듦
	         if(rs.next()) {
	        	 isPassCheck = rs.getString(1).equals(pass); 
	        	 // 1 = pass를 의미한다. pass, writer, content를 가져오면, 1 > pass , 2 > writer 를 의미하는것.
	         }
	      }catch(SQLException e) {
	         System.out.println("ExamDao - isPassCheck() : SQLException");
	         e.printStackTrace();
	      }finally {
	         try {
	            
	         if(rs != null)rs.close();
	         if(pstmt != null)pstmt.close();
	         if(conn != null)conn.close();
	      } catch(SQLException e) {}
	   }
	      
	   return isPassCheck; // 여기서는  isPassCheck 를 result로 바꾸어서 리턴해주어도 똑같음.
   }
   
// 글쓰기 폼에서 입력된 데이터를 db에 저장하는 놈
   public void insertBoard(ExamVo v) {
	      
      String sqlInsert = "INSERT INTO "
            + "music(no, mname, writer, pass, "
            + "vocal, content, wdate, cover) "
            + "VALUES(music_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
      try {
         // 2. DB에 연결된 Connection 객체를 구함
    	  conn = ds.getConnection();
         // 3. 쿼리를 발행해 주는 PreaparedStatement 객체를 구함
         pstmt = conn.prepareStatement(sqlInsert);
         // 4. 쿼리에 있는 placeholder(?)에 대한 값을 설정
         pstmt.setString(1, v.getMname());
         pstmt.setString(2, v.getWriter());
         pstmt.setString(3, v.getPass());
         pstmt.setString(4, v.getVocal());
         pstmt.setString(5, v.getContent());
         pstmt.setDate(6, v.getWdate());
         pstmt.setString(7, v.getCover());
         
         // 5. DB에 쿼리를 발행
         pstmt.executeUpdate();
         
      } catch(SQLException e) {
         System.out.println("ExamDao - InsertBoard() : SQLException");
         e.printStackTrace();
      } finally {
         try {
         // db에 작업에 사용한 객체를 역순으로 닫음
         if(pstmt != null)pstmt.close();
         if(conn != null)conn.close();
      } catch(SQLException e) {}
      }
   }
   
// db에서 게시글 하나를 읽어와서 반환
   public ExamVo getBoard(int no) {
	      
      String sqlBoard = "SELECT * FROM music WHERE no=?";
      ExamVo board = null;
      
      try {
         // 2. DB에 연결된 Connection 객체를 구함
    	  conn = ds.getConnection();
         // 3. 쿼리를 발행해 주는 PreaparedStatement 객체를 구함
         pstmt = conn.prepareStatement(sqlBoard);
         // 4. 쿼리에 있는 placeholder(?)에 대한 값을 설정
         pstmt.setInt(1, no);
         // 5. DB에 쿼리를 발행하고 결과 집합을 받음
         rs = pstmt.executeQuery();
         
         // 결과집합에서 필요한 데이터를 추출 -> Board 객체로 만듦
         if(rs.next()) {
            board = new ExamVo();
            board.setNo(rs.getInt("no"));
            board.setMname(rs.getString("mname"));
            board.setWriter(rs.getString("writer"));
            board.setPass(rs.getString("pass"));
            board.setVocal(rs.getString("vocal"));
            board.setContent(rs.getString("content"));
            board.setWdate(rs.getDate("wdate"));
            board.setPass(rs.getString("pass"));
            board.setCover(rs.getString("cover"));
         }
         
         
      }catch(SQLException e) {
         System.out.println("ExamDao - getBoard() : SQLException");
         e.printStackTrace();
      }finally {
         try {
            
         if(rs != null)rs.close();
         if(pstmt != null)pstmt.close();
         if(conn != null)conn.close();
      } catch(SQLException e) {}
   }
      
      return board;
   }
   
   // DB 테이블에서 게시글 리스트를 읽어봐서 반환하는 메소드
   public ArrayList<ExamVo> boardList() {
      
      String sqlBoardList = "SELECT * FROM music ORDER BY no DESC";
      ArrayList<ExamVo> boardList = new ArrayList<ExamVo>();
      
      try {
      // 2. DB Connection 객체 - 접속
    	  conn = ds.getConnection();
         // 3. Connection 객체로 부터 DB에 쿼리를 발행해주는 PreparedStatement 객체를 구함
         // 3.5 DB 입력 데이터 - 파라미터 설정
         pstmt = conn.prepareStatement(sqlBoardList);
         
         // 4. 실제 DB에 쿼리를 발행
         // SELECT - executeQuery() -> 테이블을 조회한 결과 집한 ResultSet 반환
         // INSERT, UPDATE, DELETE - executeUpdate()
         rs = pstmt.executeQuery();
         
         
         // 5. ResultSet.에 접근해서 데이터를 추출
         while(rs.next()){
        	 ExamVo board = new ExamVo();
        	 board.setNo(rs.getInt("no"));
             board.setMname(rs.getString("mname"));
             board.setWriter(rs.getString("writer"));
             board.setPass(rs.getString("pass"));
             board.setVocal(rs.getString("vocal"));
             board.setContent(rs.getString("content"));
             board.setWdate(rs.getDate("wdate"));
             board.setPass(rs.getString("pass"));
             board.setCover(rs.getString("cover"));
            
            boardList.add(board);
         }
         
      } catch (SQLException e) {
         e.printStackTrace();
      } finally {
         
      // 6. DB에 사용한 객체를 닫는다. 객체를 구한 역순으로 닫는다.
      // ResultSet - PreparedStatement - Connection
      try {
         if(rs != null)rs.close();
         if(pstmt != null)pstmt.close();
         if(conn != null)conn.close();
         
      } catch(SQLException e) {
      }
   }
      return boardList;
   }
}
package com.jspstudy.ch06.dao;

import java.sql.*;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.jspstudy.ch06.vo.Board;

public class DBCPBoardDao {
 
   
   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs;
   private DataSource ds; //javax.sql

   public DBCPBoardDao() {
      try {
    	  // 1. 자바 네이밍 서비스를 위한 객체 생성
    	  Context initContext = new InitialContext();  //javax.naming
    	  
    	  // 2. InitialContext 를 이용해서 기본 네임스페이스 
    	  Context envContext = (Context) initContext.lookup("java:/comp/env");
    	  
    	  ds = (DataSource) envContext.lookup("jdbc/bbsDBPool"); // nullpoint >> .dao 에서 뭘르치는지 봐라. 생성자에 문제가 있었다. 그래서 다시보니 bbsDBPool을 못찾는다라. 결국 오타인걸 발견
    	  
      } catch (NamingException e) {
         System.out.println("BoardDao() - NamingException");
         e.printStackTrace();
         
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
// 게시글 수정 폼에서 입력된 데이터를 받아서 DB 테이블에 저장하는 메소드
   public void deleteBoard(int no) {
	      
	      String sqlInsert = "DELETE FROM jspbbs WHERE no=?";
      
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
         System.out.println("BoardDao - updateBoard() : SQLException");
         e.printStackTrace();
      } finally {
         try {
         // db에 작업에 사용한 객체를 역순으로 닫음
         if(pstmt != null)pstmt.close();
         if(conn != null)conn.close();
      } catch(SQLException e) {}
   }
 }
   
	// 게시글 수정 폼에서 입력된 데이터를 받아서 DB 테이블에 저장하는 메소드
	public void updateBoard(Board b) {
      
      String sqlInsert = "UPDATE "
            + "jspbbs SET title=?, writer=?, content=?, "
            + "reg_date=SYSDATE, file1=? WHERE no=?";
      
      try {
         // 2. DB에 연결된 Connection 객체를 구함
    	  conn = ds.getConnection();
         // 3. 쿼리를 발행해 주는 PreaparedStatement 객체를 구함
         pstmt = conn.prepareStatement(sqlInsert);
         // 4. 쿼리에 있는 placeholder(?)에 대한 값을 설정
         pstmt.setString(1, b.getTitle());
         pstmt.setString(2, b.getWriter());
         pstmt.setString(3, b.getContent());
         pstmt.setString(4, b.getFile());
         pstmt.setInt(5, b.getNo());
         
         // 5. DB에 쿼리를 발행
         pstmt.executeUpdate();
         
      } catch(SQLException e) {
         System.out.println("BoardDao - updateBoard() : SQLException");
         e.printStackTrace();
      } finally {
         try {
         // db에 작업에 사용한 객체를 역순으로 닫음
         if(pstmt != null)pstmt.close();
         if(conn != null)conn.close();
      } catch(SQLException e) {}
   }
 }
   
   // 사용자가 입력한 비밀번호를 db에 있는 게시 글과 비교해서 맞는지를 체크해주는 메소드
   public boolean isPassCheck(int no, String pass) {
	   boolean isPassCheck = false;
	   
	   String sqlBoard = "SELECT pass FROM jspbbs WHERE no=?";
	      
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
	         System.out.println("BoardDao - isPassCheck() : SQLException");
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
   
   
   // 게시글쓰기 폼에서 입력된 데이터를 받아서 DB 테이블에 저장하는 메소드
   public void insertBoard(Board b) {
      
      String sqlInsert = "INSERT INTO "
            + "jspbbs(no, title, writer, content, reg_date, read_count, pass,file1) "
            + "VALUES(jspbbs_seq.NEXTVAL, ?, ?, ?,SYSDATE, 0, ?, ?)";
      try {
         // 2. DB에 연결된 Connection 객체를 구함
    	  conn = ds.getConnection();
         // 3. 쿼리를 발행해 주는 PreaparedStatement 객체를 구함
         pstmt = conn.prepareStatement(sqlInsert);
         // 4. 쿼리에 있는 placeholder(?)에 대한 값을 설정
         pstmt.setString(1, b.getTitle());
         pstmt.setString(2, b.getWriter());
         pstmt.setString(3, b.getContent());
         pstmt.setString(4, b.getPass());
         pstmt.setString(5, b.getFile());
         
         // 5. DB에 쿼리를 발행
         pstmt.executeUpdate();
         
      } catch(SQLException e) {
         System.out.println("BoardDao - InsertBoard() : SQLException");
         e.printStackTrace();
      } finally {
         try {
         // db에 작업에 사용한 객체를 역순으로 닫음
         if(pstmt != null)pstmt.close();
         if(conn != null)conn.close();
      } catch(SQLException e) {}
   }
   }
   
   
   
   
   // DB 테이블에서 게시글 하나의 정보를 읽어와서 반환하는 메소드
   public Board getBoard(int no) {
      
      String sqlBoard = "SELECT * FROM jspbbs WHERE no=?";
      Board board = null;
      
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
            board = new Board();
            board.setNo(rs.getInt("no"));
            board.setTitle(rs.getString("title"));
            board.setWriter(rs.getString("writer"));
            board.setContent(rs.getString("content"));
            board.setRegDate(rs.getTimestamp("reg_date"));
            board.setReadCount(rs.getInt("read_count"));
            board.setPass(rs.getString("pass"));
            board.setFile(rs.getString("file1"));
         }
         
         
      }catch(SQLException e) {
         System.out.println("BoardDao - getBoard() : SQLException");
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
   public ArrayList<Board> boardList() {
      
      String sqlBoardList = "SELECT * FROM jspbbs ORDER BY no DESC";
      ArrayList<Board> boardList = new ArrayList<Board>();
      
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
            Board b = new Board();
            b.setNo(rs.getInt("no"));
            b.setTitle(rs.getString("title"));
            b.setWriter(rs.getString("writer"));
            b.setRegDate(rs.getTimestamp("reg_date"));
            b.setReadCount(rs.getInt("read_count"));
            b.setFile(rs.getString("file1"));
            
            boardList.add(b);
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
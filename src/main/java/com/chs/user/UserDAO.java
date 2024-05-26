package com.chs.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	Connection conn = null; // 데이터베이스 연결을 위한 Connection 객체
	PreparedStatement pstmt = null; // SQL 문을 데이터베이스에 전송하기 위한 PreparedStatement 객체
	ResultSet rs = null; // SQL 쿼리의 결과를 저장하기 위한 ResultSet 객체
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS"; // 데이터베이스 URL
			String dbID = "root"; // 데이터베이스 사용자 ID
			String dbPW = "Dlwpsdksekdgo12!@"; // 데이터베이스 사용자 비밀번호
			Class.forName("com.mysql.jdbc.Driver"); // JDBC 드라이버 로드
			conn = DriverManager.getConnection(dbURL, dbID, dbPW); // 데이터베이스 연결
			System.out.println("연결 성공"); // 연결 성공 메시지 출력
			
		} catch (Exception e) {
			e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
		}
	}
	
	public int login(String userID, String userPW) {
		String SQL = "select userPW from user where userID = ?"; // 사용자 ID로 비밀번호 조회 SQL
		
		try {
			pstmt = conn.prepareStatement(SQL); // SQL 문을 준비
			pstmt.setString(1, userID); // 첫 번째 파라미터에 사용자 ID 설정
			rs = pstmt.executeQuery(); // 쿼리 실행, 결과는 ResultSet에 저장
			
			if (rs.next()) { // 결과가 존재하면
				if (rs.getString(1).equals(userPW))
					return 1; // 비밀번호 일치, 로그인 성공
				else 
					return 0; // 비밀번호 불일치
				}
				return -1; // 결과가 없으면, 아이디 없음
				
		} catch (Exception e) {
			e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
		}
		return -2; // 데이터베이스 오류
	}

	public int join(UserBean user) {
		String SQL = "insert into user values(?, ?, ?, ?, ?)"; // 사용자 정보 삽입 SQL
		
		try {
			pstmt = conn.prepareStatement(SQL); // SQL 문을 준비
			pstmt.setString(1, user.getUserID()); // 첫 번째 파라미터에 사용자 ID 설정
			pstmt.setString(2, user.getUserPW()); // 두 번째 파라미터에 사용자 비밀번호 설정
			pstmt.setString(3, user.getUserName()); // 세 번째 파라미터에 사용자 이름 설정
			pstmt.setString(5, user.getUserEmail()); // 다섯 번째 파라미터에 사용자 이메일 설정
			pstmt.setString(4, user.getUserGender()); // 네 번째 파라미터에 사용자 성별 설정
			return pstmt.executeUpdate(); // SQL 문 실행, 영향 받은 행의 수 반환
		} catch (Exception e) {
			e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
		}
		return -1; // 데이터베이스 오류
	}
	
}

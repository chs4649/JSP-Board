package com.chs.bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

// BbsDAO 클래스는 데이터베이스와의 연결 및 게시판 관련 데이터 처리를 담당합니다.
public class BbsDAO {
	Connection conn = null; // 데이터베이스 연결을 관리하는 Connection 객체
	ResultSet rs = null; // SQL 쿼리의 결과를 저장하는 ResultSet 객체
	
	// 생성자에서는 데이터베이스 연결을 초기화합니다.
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS"; // 데이터베이스 URL
			String dbID = "root"; // 데이터베이스 사용자 ID
			String dbPW = "Dlwpsdksekdgo12!@"; // 데이터베이스 사용자 비밀번호
			Class.forName("com.mysql.jdbc.Driver"); // JDBC 드라이버 로드
			conn = DriverManager.getConnection(dbURL, dbID, dbPW); // 데이터베이스 연결
			System.out.println("연결 성공");
			
		} catch (Exception e) {
			e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
		}
	}

	// 현재 날짜와 시간을 문자열로 반환하는 메소드
	public String getDate() {
		String SQL = "select now()"; // 현재 시간을 조회하는 SQL 쿼리
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // SQL 쿼리를 실행하기 위한 PreparedStatement 객체 생성
			rs = pstmt.executeQuery(); // 쿼리 실행
			if (rs.next()) {
				return rs.getString(1); // 결과의 첫 번째 컬럼(현재 날짜와 시간)을 반환
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB 오류 발생 시 빈 문자열 반환
	}

	// 다음 게시글 번호를 반환하는 메소드
	public int getNext() {
		String SQL = "select bbsID from bbs order by bbsID desc"; // 게시글 번호를 내림차순으로 조회하는 SQL 쿼리
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1; // 가장 최근 게시글 번호에 1을 더해 반환
			}
			return 1; // 게시글이 없는 경우 1 반환

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류 발생 시 -1 반환
	}
	
	/**
	 * 게시글 정보를 업데이트하는 메소드
	 * @param bbsID 업데이트할 게시글의 ID
	 * @param bbsTitle 업데이트할 게시글의 제목
	 * @param bbsContent 업데이트할 게시글의 내용
	 * @return 업데이트 성공 시 1, 실패 시 -1 반환
	 */
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "update bbs set bbsTitle = ?, bbsContent = ? where bbsID = ?"; // 게시글 업데이트 SQL 쿼리
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // SQL 쿼리를 실행할 PreparedStatement 객체 생성
			pstmt.setString(1, bbsTitle); // 쿼리의 첫 번째 파라미터에 게시글 제목 설정
			pstmt.setString(2, bbsContent); // 쿼리의 두 번째 파라미터에 게시글 내용 설정
			pstmt.setInt(3, bbsID); // 쿼리의 세 번째 파라미터에 게시글 ID 설정
			return pstmt.executeUpdate(); // 쿼리 실행, 영향 받은 행의 수 반환
		} catch (Exception e) {
			e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
		}
		return -1; // 업데이트 실패 시 -1 반환
	}
	
	// 게시글을 데이터베이스에 삽입하는 메소드
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "insert into bbs values (?, ?, ?, ?, ?, ?)"; // 게시글 삽입을 위한 SQL 쿼리
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); // 다음 게시글 번호 설정
			pstmt.setString(2, bbsTitle); // 게시글 제목 설정
			pstmt.setString(3, userID); // 사용자 ID 설정
			pstmt.setString(4, getDate()); // 현재 날짜 설정
			pstmt.setString(5, bbsContent); // 게시글 내용 설정
			pstmt.setInt(6, 1); // 게시글 상태 설정 (1: 활성)

			return pstmt.executeUpdate(); // 쿼리 실행 후 영향 받은 행의 수 반환

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류 발생 시 -1 반환
	}
	// 페이지 번호에 따라 게시글 목록을 가져오는 메소드
	public ArrayList<BbsBean> getList(int pageNumber) {
		// 게시글을 조회하는 SQL 쿼리, 사용 가능한 게시글만 조회하며 페이지에 따라 10개씩 조회
		String SQL = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<BbsBean> list = new ArrayList<BbsBean>(); // 게시글을 저장할 ArrayList 생성
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // SQL 쿼리를 실행할 PreparedStatement 객체 생성
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // 페이지 번호에 따라 조회할 게시글 범위 설정
			rs = pstmt.executeQuery(); // 쿼리 실행, 결과는 ResultSet에 저장
			while (rs.next()) { // 결과 ResultSet을 순회하며 각 게시글 정보를 BbsBean 객체에 저장 후 list에 추가
				BbsBean bbsBean = new BbsBean();
				bbsBean.setBbsID(rs.getInt(1)); // 게시글 ID
				bbsBean.setBbsTitle(rs.getString(2)); // 게시글 제목
				bbsBean.setUserID(rs.getString(3)); // 게시글 작성자 ID
				bbsBean.setBbsDate(rs.getString(4)); // 게시글 작성 날짜
				bbsBean.setBbsContent(rs.getString(5)); // 게시글 내용
				bbsBean.setBbsAvailable(rs.getInt(6)); // 게시글 사용 가능 여부
				list.add(bbsBean);
			}
		} catch (Exception e) {
			e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
		}
		return list; // 완성된 게시글 목록 반환
	}
	/**
	 * 주어진 페이지 번호에 대해 다음 페이지가 존재하는지 확인하는 메소드
	 * @param pageNumber 현재 페이지 번호
	 * @return 다음 페이지 존재 여부 (true: 존재함, false: 존재하지 않음)
	 */
	public boolean nextPage(int pageNumber) {
		// 다음 페이지 존재 여부를 확인하기 위한 SQL 쿼리
		String SQL = "select * from bbs where bbsID < ? and bbsAvailable = 1";
		// 게시글 정보를 저장할 ArrayList 생성
		ArrayList<BbsBean> list = new ArrayList<BbsBean>();
		try {
			// SQL 쿼리를 실행할 PreparedStatement 객체 생성
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// 페이지 번호에 따라 조회할 게시글 범위 설정
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			// 쿼리 실행, 결과는 ResultSet에 저장
			rs = pstmt.executeQuery();
			// 결과 ResultSet을 순회하며 다음 페이지 존재 여부 확인
			if (rs.next()) {
				return true; // 다음 페이지가 존재함
			}
		} catch (Exception e) {
			// 예외 발생 시 스택 트레이스 출력
			e.printStackTrace();
		}
		// 다음 페이지가 존재하지 않음
		return false;
	}

	/**
	 * 주어진 게시글 ID로 게시글 정보를 조회하여 반환하는 메소드
	 * @param bbsID 조회할 게시글의 ID
	 * @return 조회된 게시글 정보가 담긴 BbsBean 객체, 조회 실패 시 null 반환
	 */
	public BbsBean getBbs(int bbsID) {
		String SQL = "select * from bbs where bbsID = ?"; // 게시글 조회 SQL 쿼리
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // SQL 쿼리를 실행할 PreparedStatement 객체 생성
			pstmt.setInt(1, bbsID); // 쿼리의 첫 번째 파라미터에 게시글 ID 설정
			rs = pstmt.executeQuery(); // 쿼리 실행, 결과는 ResultSet에 저장
			if (rs.next()) { // 결과가 존재하면
				BbsBean bbsBean = new BbsBean(); // 게시글 정보를 저장할 BbsBean 객체 생성
				bbsBean.setBbsID(rs.getInt(1)); // 게시글 ID 설정
				bbsBean.setBbsTitle(rs.getString(2)); // 게시글 제목 설정
				bbsBean.setUserID(rs.getString(3)); // 게시글 작성자 ID 설정
				bbsBean.setBbsDate(rs.getString(4)); // 게시글 작성 날짜 설정
				bbsBean.setBbsContent(rs.getString(5)); // 게시글 내용 설정
				bbsBean.setBbsAvailable(rs.getInt(6)); // 게시글 사용 가능 여부 설정
				return bbsBean; // 완성된 BbsBean 객체 반환
			}
		} catch (Exception e) {
			e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
		}
		return null; // 조회 실패 시 null 반환
	}

	/**
	 * 게시글의 사용 가능 상태를 비활성화(0)로 설정하여 게시글을 삭제 처리하는 메소드
	 * @param bbsID 삭제 처리할 게시글의 ID
	 * @return SQL 실행 후 영향 받은 행의 수를 반환, 실패 시 -1 반환
	 */
	public int delete(int bbsID) {
		String SQL = "update bbs set bbsAvailable = 0 where bbsID = ?"; // 게시글 삭제 처리를 위한 SQL 쿼리
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // SQL 쿼리를 실행할 PreparedStatement 객체 생성
			pstmt.setInt(1, bbsID); // 쿼리의 첫 번째 파라미터에 게시글 ID 설정
			return pstmt.executeUpdate(); // 쿼리 실행, 영향 받은 행의 수 반환
		} catch (Exception e) {
			e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
		}
		return -1; // SQL 실행 실패 시 -1 반환
	}
}

package edu.polytechnique.inf553;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;

class QueryResult {
	public int id;
	public String name;
	public int count;
}

class GetArtistResult {
	public String name;
	public int gender;
	public int year;
	public String country;
}

public class PostgreService {
	private PreparedStatement queryStatement;
	private PreparedStatement getArtistStatement; 
	
	public PostgreService() throws SQLException {
		// Find the PostgreSQL class
		try {
			Class.forName("org.postgresql.Driver");
		}
		catch (ClassNotFoundException e) {
			System.out.println("Driver not found!");
		}
		
		// Connect to the local Postgre server and prepare the queries
		String serverURL = "jdbc:postgresql://localhost/postgres";
		Connection connection;
		try {
			connection = DriverManager.getConnection(serverURL, "postgres", "postgres");

			
			queryStatement = connection.prepareStatement(
								"SELECT a.id,a.name,COUNT(rc.year = ?) \n"
								+ "FROM artist as a, country as c, release_country as rc ,release_has_artist as rha \n"
								+ "WHERE c.name = ? and CAST(rc.country as INT) = c.id and rc.release=rha.release and rha.artist = a.id and rc.year >= ? \n"
								+ "GROUP BY (a.id,a.name) \n"
								+ "HAVING MAX(rc.year) > ? \n");
			
			getArtistStatement = connection.prepareStatement(
								"SELECT a.name, a.gender, a.syear, c.name as country "
								+ "FROM artist as a"
								+ "FULL OUTER JOIN country as c on a.area = c.id"
								+ "WHERE a.id = ? ;");
			
		} 
		catch (SQLException e) {
			throw e;
		}	
	}
	
	public List<QueryResult> query(String country, int year) throws SQLException {
		LinkedList<QueryResult> results = new LinkedList<QueryResult>();
		
		try {
			queryStatement.setInt(1,year);
			queryStatement.setString(2, country);
			queryStatement.setInt(3, year);
			queryStatement.setInt(4, year);
			
			ResultSet resultSet = queryStatement.executeQuery();
			while (resultSet.next()) {
				QueryResult res = new QueryResult();
				res.id = resultSet.getInt(1);
				res.name = resultSet.getString(2);
				res.count = resultSet.getInt(3);
				results.add(res);
			}
		}
		catch (SQLException e) {
			System.out.print(e.getMessage());
			throw e;
		}
		
		return results;
	}
	
	public GetArtistResult getArtist(int artistId) throws SQLException {
		GetArtistResult result = null;
		
		try {
			getArtistStatement.setInt(1, artistId);
			
			ResultSet rs = getArtistStatement.executeQuery();
			if (rs.next()) {
				result = new GetArtistResult();
				result.name = rs.getString(1);
				result.gender = rs.getInt(2);
				result.year = rs.getInt(3);
				result.country = rs.getString(4);
			}
		}
		catch (SQLException e) {
			System.out.print(this.getClass() + ": " + e.getMessage());
			throw e;
		}
		
		return result;
	}
	
	public static void main(String[] args) {
		PostgreService pgService = null;
		try {
			pgService = new PostgreService();
		
			List<QueryResult> results = pgService.query("Brazil", 2013);
			while(!results.isEmpty())
				System.out.println(results.get(0).name);
		} catch (SQLException e) {
			System.out.println(e);
			return;
		}
	}
}

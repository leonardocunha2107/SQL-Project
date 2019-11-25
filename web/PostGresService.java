package edu.polytechnique.inf553;
import java.io.*;
import java.sql.* ;
import java.util.*;

class Query2Res{
	public String name;
	public int gender;
	public int year;
	public String country;
	

}
class Query1Res{
	public int id;
	public String name;
	public int count;
}

public class PostGresService {
	private PreparedStatement query1;
	private PreparedStatement query2;
	public PostGresService() {
		try{
			Class.forName("org.postgresql.Driver");
		}
		catch ( ClassNotFoundException e ) {
			System.out.println("Driver not found!");
		}
		
		String serverURL="jdbc:postgresql://localhost/postgres";
		Connection connection;
		try {
			connection=DriverManager.getConnection(serverURL,"postgres","postgres");
			DatabaseMetaData dmd = connection.getMetaData( );
			String serverName = dmd.getDatabaseProductName( ); 
			
			query1=connection.prepareStatement(
					"Select a.id,a.name,COUNT(rc.year=?) \n"
					+ "FROM artist as a, country as c, release_country as rc ,release_has_artist as rha \n"
					+ "WHERE c.name= ? and CAST(rc.country as INT) = c.id and rc.release=rha.release and rha.artist = a.id and rc.year >= ? \n"
					+ "GROUP BY (a.id,a.name) \n"
					+ "HAVING MAX(rc.year)>? \n");
			query2=connection.prepareStatement(
					"SELECT a.name,a.gender,a.syear,c.name as country FROM artist as a FULL OUTER JOIN country as c on a.area=c.id WHERE a.id = ? ;" 
					);
			
		} 
		catch (SQLException e) {
			return;
		}
		
	}
	public Stack<Query1Res> query1(String country, int year){
		Stack<Query1Res> reslis=new Stack<Query1Res>();
		
		try {
			query1.setInt(1,year);
			query1.setString(2, country);
			query1.setInt(3, year);
			query1.setInt(4, year);
			ResultSet rs=query1.executeQuery();
			while(rs.next()) {
				Query1Res a= new Query1Res();
				a.id=rs.getInt(1);
				a.name=rs.getString(2);
				a.count=rs.getInt(3);
				reslis.add(a);
			}
		}
		catch (SQLException e) {
			System.out.print(e.getMessage());
			return new Stack<Query1Res>();
		}
		return reslis;
	}
	public Stack<Query2Res> query2(int aid){
		Stack<Query2Res> reslis=new Stack<Query2Res>();
		
		try {
			query2.setInt(1,aid);
			ResultSet rs=query2.executeQuery();
			while(rs.next()) {
				Query2Res a= new Query2Res();
				a.name=rs.getString(1);
				a.gender=rs.getInt(2);
				a.year=rs.getInt(3);
				a.country=rs.getString(4);
				reslis.add(a);
			}
		}
		catch (SQLException e) {
			System.out.print(e.getMessage());
			return new Stack<Query2Res>();
		}
		return reslis;
	}
	public static void main(String[] args) {
		PostGresService psql =new PostGresService();
		Stack<Query1Res> res=psql.query1("Brazil",2013);
		while(!res.isEmpty())
			System.out.println(res.pop().name);

	}

}

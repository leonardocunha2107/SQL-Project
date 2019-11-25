package edu.polytechnique.inf553;

import java.io.IOException;
import java.sql.SQLException;

import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.polytechnique.inf553.PostgreService;

/**
 * This is a query servlet used only answer queries on artists and display information on them.
 */
@WebServlet(urlPatterns = { "/QueryServlet", "/Artist" }, initParams = {
		@WebInitParam(name = "countryname", value = "", description = "The name of the country of the artist"),
		@WebInitParam(name = "year", value = "", description = "The year after which the artist has released albums."),
		@WebInitParam(name = "artistid", value = "", description = "The requested artist's id.")})

public final class QueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PostgreService pgService;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public QueryServlet() throws SQLException {
		super();
		
		// Try to create a PostgreService object (throws SQLException if there is an error)
		pgService = new PostgreService();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, IllegalStateException {
		// Log request to console
		System.out.println(this.getClass().getName() + " doGet method called with path " + request.getRequestURI() + " and parameters " + request.getQueryString()); 

		// Determine whether this is a query or a get
		String split[] = request.getRequestURI().split("/");
		String pattern = split[2];
		
		if (pattern.equals("QueryServlet")) {
			this.answerQuery(request, response);
		} else if (pattern.equals("Artist")) {
			this.getArtist(request, response);
		} else {
			throw new ServletException("Unexpected URI pattern: " + pattern);
		}
	}
	
	protected void answerQuery(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException, IllegalStateException {
		// Set response type to UTF-8 HTML
		response.setContentType("text/html;charset=UTF-8");
		
		// Verify that the expected parameters were received
		String countryname = request.getParameter("countryname");
		String yearString = request.getParameter("year");
		if (countryname == null) {
			throw new ServletException("Expected countryname parameter but did not get one, URL malformed"); 
		}
		if (yearString == null) {
			throw new ServletException("Expected year parameter but did not get one, URL malformed"); 
		}
		
		// Check that the received year is a valid year
		int year = 0;
		try {
			year = Integer.parseInt(yearString);
		} catch (NumberFormatException e) {
			throw new ServletException("The received year parameter can not be converted to an integer, URL malformed");
		}
		if (year >= 2050) {
			throw new IllegalStateException("The received year parameter is not smaller than 2050");
		}
		
		// Call the PostgreService to get the query results
		List<QueryResult> results = null;
		try {
			results = pgService.query(countryname, year);
		} catch (SQLException e) {
			throw new ServletException(e.getMessage());
		}
		
		// Get the URL of the request and create the redirect URL
		String fullURL = request.getRequestURL().toString();
		String redirectURL = fullURL.substring(0, fullURL.lastIndexOf('/') + 1) + "Artist?artistid=";
		
		
		// Build the response HTML
		response.getWriter().append("<!DOCTYPE html>\n<html>\n<table>\n");
		response.getWriter().append("\t<tr>\n");
		response.getWriter().append("\t\t<th>Artist Id</th>\n");
		response.getWriter().append("\t\t<th>Artist Name</th>\n");
		response.getWriter().append("\t\t<th>Album Count</th>\n");
		response.getWriter().append("\t</tr>\n");
		
		
		Iterator<QueryResult> resIterator = results.iterator();
		while (resIterator.hasNext()) {
			QueryResult res = resIterator.next();
			String artistIdString = Integer.toString(res.id);
			String countString = Integer.toString(res.count)
					;
			response.getWriter().append("\t<tr>");
			
			// Write the artist's id
			response.getWriter().append("\t\t<th>" + artistIdString + "</th>\n");
			
			// Write the artist's name with the proper redirect
			response.getWriter().append("\t\t<th><a href=\"" + redirectURL + artistIdString + "\">"
										+ res.name + "</a></th>\n");
			
			// Write the album count
			response.getWriter().append("\t\t<th>" + countString + "</th>\n");
			
			response.getWriter().append("\t</tr>");
		}
		response.getWriter().append("</html>\n</table>\n");
	}
	
	protected void getArtist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Set response type to UTF-8 HTML
		response.setContentType("text/html;charset=UTF-8");
		
		// Verify that the expected parameters were received
		String artistIdString = request.getParameter("artistId");
		if (artistIdString == null) {
			throw new ServletException("Expected artistid parameter but did not get one, URL malformed"); 
		}
		
		// Check that the received year is a valid integer
		int artistId = 0;
		try {
			artistId = Integer.parseInt(artistIdString);
		} catch (NumberFormatException e) {
			throw new ServletException("The received year parameter can not be converted to an integer, URL malformed");
		}
		
		// Call the PostgreService to get the query results
		GetArtistResult result = null;
		try {
			result = pgService.getArtist(artistId);
		} catch (SQLException e) {
			throw new ServletException(e.getMessage());
		}
		
		// Build the response HTML
		response.getWriter().append("<!DOCTYPE html>\n<html>\n");
		
		// Display the artist's name
		response.getWriter().append("<h1>");
		if (result.gender == 1) {
			response.getWriter().append("Mr. ");
		} else if (result.gender == 2) {
			response.getWriter().append("Mrs. ");
		}
		response.getWriter().append(result.name + "</h1>\n");
		
		// Display year of birth
		if (result.year != 0) {
			response.getWriter().append("<p>Born in " + Integer.toString(result.year) + "</p>\n");
		}
		
		// Display geographical location
		if (result.country != null) {
			response.getWriter().append("<p>From " + result.country + "</p>\n");
		}
		
		response.getWriter().append("</html>\n");
	}
}

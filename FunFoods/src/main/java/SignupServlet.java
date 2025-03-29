

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class SignupServlet
 */
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get form parameters
				String name = request.getParameter("name");
		        String address = request.getParameter("address");
		        String phone = request.getParameter("phone"); // New phone parameter
		        String email = request.getParameter("email");
		        String password = request.getParameter("password");
		        String role = request.getParameter("role");

		        // Database connection details
		        String url = "jdbc:mysql://localhost:3306/restaurant_db";
		        String user = "root"; // Change to your MySQL username
		        String pass = "root123"; // Change to your MySQL password

		        try {
		            // Load the MySQL JDBC driver
		            Class.forName("com.mysql.cj.jdbc.Driver");
		            
		            // Establish connection
		            Connection con = DriverManager.getConnection(url, user, pass);
		            
		            // SQL query to insert new user including phone number
		            String sql = "INSERT INTO users (name, address, phone, email, password, role) VALUES (?, ?, ?, ?, ?, ?)";
		            PreparedStatement ps = con.prepareStatement(sql);
		            
		            // Set parameters in the query
		            ps.setString(1, name);
		            ps.setString(2, address);
		            ps.setString(3, phone); // Set phone value
		            ps.setString(4, email);
		            ps.setString(5, password);
		            ps.setString(6, role);
		            
		            // Execute the query
		            ps.executeUpdate();
		            
		            // Close the connection
		            con.close();
		            
		            // Redirect to sign-in page after successful sign-up
		            response.sendRedirect("signin.jsp");
		        } catch (Exception e) {
		            e.printStackTrace();
		            response.getWriter().println("Error: " + e.getMessage());
		        }
			}

		}

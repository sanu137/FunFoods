

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class AdminServlet
 */
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
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
		 String action = request.getParameter("action");

	        try {
	            // Establish connection to database
	            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_db", "root", "root");

	            // Handle CRUD operations based on 'action' parameter
	            switch(action) {
	                case "insertFood":
	                    insertFood(request, conn);
	                    break;
	                case "deleteFood":
	                    deleteFood(request, conn);
	                    break;

	                case "insertBilling":
	                    insertBilling(request, conn);
	                    break;
	                case "deleteBilling":
	                    deleteBilling(request, conn);
	                    break;

	                case "insertOrder":
	                    insertOrder(request, conn);
	                    break;
	                case "deleteOrder":
	                    deleteOrder(request, conn);
	                    break;

	                case "insertUser":
	                    insertUser(request, conn);
	                    break;
	                case "deleteUser":
	                    deleteUser(request, conn);
	                    break;

	                case "insertCart":
	                    insertCart(request, conn);
	                    break;
	                case "deleteCart":
	                    deleteCart(request, conn);
	                    break;

	                default:
	                    response.getWriter().println("Unknown action: " + action);
	                    break;
	            }

	            conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        // Redirect back to admin.jsp after operation
	        response.sendRedirect("admin.jsp");
	    }

	    // Helper Methods for Foods Table
	    private void insertFood(HttpServletRequest request, Connection conn) throws SQLException {
	        String name = request.getParameter("name");
	        String description = request.getParameter("description");
	        double price = Double.parseDouble(request.getParameter("price"));
	        String query = "INSERT INTO foods (name, description, price) VALUES (?, ?, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, name);
	        pstmt.setString(2, description);
	        pstmt.setDouble(3, price);
	        pstmt.executeUpdate();
	    }

	    private void deleteFood(HttpServletRequest request, Connection conn) throws SQLException {
	        int id = Integer.parseInt(request.getParameter("id"));
	        String query = "DELETE FROM foods WHERE id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, id);
	        pstmt.executeUpdate();
	    }

	    // Helper Methods for Billing Table
	    private void insertBilling(HttpServletRequest request, Connection conn) throws SQLException {
	        int customerId = Integer.parseInt(request.getParameter("customer_id"));
	        int orderId = Integer.parseInt(request.getParameter("order_id"));
	        double totalAmount = Double.parseDouble(request.getParameter("total_amount"));
	        String billingDate = request.getParameter("billing_date");
	        String query = "INSERT INTO billing (customer_id, order_id, total_amount, billing_date) VALUES (?, ?, ?, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, customerId);
	        pstmt.setInt(2, orderId);
	        pstmt.setDouble(3, totalAmount);
	        pstmt.setString(4, billingDate);
	        pstmt.executeUpdate();
	    }

	    private void deleteBilling(HttpServletRequest request, Connection conn) throws SQLException {
	        int id = Integer.parseInt(request.getParameter("id"));
	        String query = "DELETE FROM billing WHERE id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, id);
	        pstmt.executeUpdate();
	    }

	    // Helper Methods for Orders Table
	    private void insertOrder(HttpServletRequest request, Connection conn) throws SQLException {
	        int customerId = Integer.parseInt(request.getParameter("customer_id"));
	        int foodId = Integer.parseInt(request.getParameter("food_id"));
	        String status = request.getParameter("status");
	        String query = "INSERT INTO orders (customer_id, food_id, status) VALUES (?, ?, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, customerId);
	        pstmt.setInt(2, foodId);
	        pstmt.setString(3, status);
	        pstmt.executeUpdate();
	    }

	    private void deleteOrder(HttpServletRequest request, Connection conn) throws SQLException {
	        int id = Integer.parseInt(request.getParameter("id"));
	        String query = "DELETE FROM orders WHERE id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, id);
	        pstmt.executeUpdate();
	    }

	    // Helper Methods for Users Table
	    private void insertUser(HttpServletRequest request, Connection conn) throws SQLException {
	        String name = request.getParameter("name");
	        String address = request.getParameter("address");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        String role = request.getParameter("role");
	        String query = "INSERT INTO users (name, address, email, password, role) VALUES (?, ?, ?, ?, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, name);
	        pstmt.setString(2, address);
	        pstmt.setString(3, email);
	        pstmt.setString(4, password);
	        pstmt.setString(5, role);
	        pstmt.executeUpdate();
	    }

	    private void deleteUser(HttpServletRequest request, Connection conn) throws SQLException {
	        int id = Integer.parseInt(request.getParameter("id"));
	        String query = "DELETE FROM users WHERE id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, id);
	        pstmt.executeUpdate();
	    }

	    // Helper Methods for Cart Table
	    private void insertCart(HttpServletRequest request, Connection conn) throws SQLException {
	        int customerId = Integer.parseInt(request.getParameter("customer_id"));
	        int foodId = Integer.parseInt(request.getParameter("food_id"));
	        int quantity = Integer.parseInt(request.getParameter("quantity"));
	        String query = "INSERT INTO cart (customer_id, food_id, quantity) VALUES (?, ?, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, customerId);
	        pstmt.setInt(2, foodId);
	        pstmt.setInt(3, quantity);
	        pstmt.executeUpdate();
	    }

	    private void deleteCart(HttpServletRequest request, Connection conn) throws SQLException {
	        int id = Integer.parseInt(request.getParameter("id"));
	        String query = "DELETE FROM cart WHERE id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, id);
	        pstmt.executeUpdate();
	    }

}

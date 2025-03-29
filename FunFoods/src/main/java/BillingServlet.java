import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;

@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve necessary parameters from request
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        // Database connection settings
        String url = "jdbc:mysql://localhost:3306/restaurant_db";
        String user = "root"; // Change to your MySQL username
        String pass = "root123"; // Change to your MySQL password

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            con = DriverManager.getConnection(url, user, pass);

            // SQL query to insert a new billing record
            String sql = "INSERT INTO billing (customer_id, order_id, total_amount) VALUES (?, ?, ?)";
            pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, customerId);
            pstmt.setInt(2, orderId);
            pstmt.setDouble(3, totalAmount);

            // Execute the insert statement
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Get the auto-generated billing ID and billing date
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int billingId = rs.getInt(1);

                    // Retrieve the billing information, including the timestamp
                    sql = "SELECT total_amount, billing_date FROM billing WHERE id = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, billingId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        double billTotal = rs.getDouble("total_amount");
                        Timestamp billingDate = rs.getTimestamp("billing_date");

                        // Display the billing receipt
                        response.setContentType("text/html");
                        response.getWriter().println("<h2>Billing Receipt</h2>");
                        response.getWriter().println("<p>Customer ID: " + customerId + "</p>");
                        response.getWriter().println("<p>Order ID: " + orderId + "</p>");
                        response.getWriter().println("<p>Total Amount: ₹" + billTotal + "</p>");
                        response.getWriter().println("<p>Billing Date & Time: " + billingDate + "</p>");
                        response.getWriter().println("<p>Thank you for your order!</p>");
                    }
                }
            } else {
                // Handle failure to insert billing information
                response.getWriter().println("Failed to record billing information.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Clean up and close connections
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

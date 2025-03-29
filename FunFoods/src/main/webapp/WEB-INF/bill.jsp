<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Billing Receipt</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Billing Receipt</h2>
        <%
            // Retrieve parameters from the request
            String customerId = request.getParameter("customerId");
            String orderId = request.getParameter("orderId");
            String totalAmount = request.getParameter("totalAmount");

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

                // Query to retrieve billing details
                String sql = "SELECT total_amount, billing_date FROM billing WHERE order_id = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(orderId));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    double billTotal = rs.getDouble("total_amount");
                    Timestamp billingDate = rs.getTimestamp("billing_date");

                    // Format the billing date for better display
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

                    // Display the billing information
        %>
                    <div class="card p-4">
                        <p><strong>Customer ID:</strong> <%= customerId %></p>
                        <p><strong>Order ID:</strong> <%= orderId %></p>
                        <p><strong>Total Amount:</strong> ₹<%= billTotal %></p>
                        <p><strong>Billing Date & Time:</strong> <%= sdf.format(billingDate) %></p>
                        <p class="text-success">Thank you for your order!</p>
                    </div>
        <%
                } else {
                    // Handle case where billing information is not found
                    out.println("<div class='alert alert-danger'>Billing information not found.</div>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                // Close database resources
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>

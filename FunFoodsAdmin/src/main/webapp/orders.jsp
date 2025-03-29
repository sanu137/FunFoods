<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background-color: #008080;
        }
        .navbar-brand {
            font-weight: bold;
            color: black;
        }
        .nav-link {
            color: black !important;
        }
        h2 {
            color: #008080;
            text-align: center;
            margin-top: 20px;
            font-size: 28px;
        }
        h3 {
            color: #007bff;
            margin-top: 30px;
        }
        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Fun Foods - Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="customer.jsp">Customers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="menu.jsp">Menu</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="orders.jsp">Orders</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container">
        <h2>Order Details</h2>

        <%
            Connection conn = null;
            Statement stmt = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String message = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_db", "root", "root123"); // Update DB credentials

                // Handle delete action
                String deleteId = request.getParameter("deleteId");
                if (deleteId != null) {
                    String deleteQuery = "DELETE FROM orders WHERE id = ?";
                    pstmt = conn.prepareStatement(deleteQuery);
                    pstmt.setInt(1, Integer.parseInt(deleteId));

                    int result = pstmt.executeUpdate();
                    message = (result > 0) ? "Order deleted successfully!" : "Failed to delete order.";
                }

                // Fetch all orders
                stmt = conn.createStatement();
                String query = "SELECT * FROM orders";
                rs = stmt.executeQuery(query);

                if (message != null) {
                    out.println("<div class='alert alert-info'>" + message + "</div>");
                }
        %>

        <!-- Display orders in a table with a delete option -->
        <table class="table table-bordered mt-4">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Customer ID</th>
                    <th>Total Amount</th>
                    <th>Order Details</th>
                    <th>Order Date</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        int customerId = rs.getInt("customer_id");
                        double totalAmount = rs.getDouble("total_amount");
                        String orderDetails = rs.getString("order_details");
                        Timestamp orderDate = rs.getTimestamp("order_date");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= customerId %></td>
                    <td><%= totalAmount %></td>
                    <td><%= orderDetails %></td>
                    <td><%= orderDate %></td>
                    <td>
                        <form method="post" action="orders.jsp">
                            <input type="hidden" name="deleteId" value="<%= id %>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <%
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <!-- Insert Form -->
        <h3>Insert New Order</h3>
        <form method="post" action="orders.jsp">
            <input type="hidden" name="action" value="insert">
            <div class="mb-3">
                <label for="customer_id" class="form-label">Customer ID:</label>
                <input type="number" class="form-control" name="customer_id" required>
            </div>
            <div class="mb-3">
                <label for="total_amount" class="form-label">Total Amount:</label>
                <input type="number" step="0.01" class="form-control" name="total_amount" required>
            </div>
            <div class="mb-3">
                <label for="order_details" class="form-label">Order Details:</label>
                <textarea class="form-control" name="order_details" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Insert</button>
        </form>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </div>
</body>
</html>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management</title>
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
        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
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
        
        <h2>Customer Details</h2>

        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_db", "root", "root123"); // Update DB credentials

                // Fetch all customers
                stmt = conn.createStatement();
                String query = "SELECT * FROM users"; // Adjust the table name if needed
                rs = stmt.executeQuery(query);
        %>

        <!-- Display customers in a table -->
        <table class="table table-bordered mt-4">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Role</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String address = rs.getString("address");
                        String phone = rs.getString("phone");
                        String email = rs.getString("email");
                        String role = rs.getString("role");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= address %></td>
                    <td><%= phone %></td>
                    <td><%= email %></td>
                    <td><%= role %></td>
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
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </div>
</body>
</html>

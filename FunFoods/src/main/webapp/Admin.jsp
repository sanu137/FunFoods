<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h2>Admin Dashboard - CRUD Operations</h2>

    <!-- Insert New Entry for Foods -->
    <h3>Manage Foods</h3>
    <form action="AdminServlet" method="post">
        <input type="hidden" name="action" value="insertFood">
        <label for="name">Food Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="price">Price:</label>
        <input type="number" step="0.01" id="price" name="price" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description"></textarea>

        <input type="submit" value="Add Food">
    </form>

    <!-- Display Foods with Delete Option -->
    <h3>Foods</h3>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_db", "root", "password");
                    
                    String query = "SELECT * FROM foods";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        double price = rs.getDouble("price");
                        String description = rs.getString("description");

                        out.println("<tr>");
                        out.println("<td>" + id + "</td>");
                        out.println("<td>" + name + "</td>");
                        out.println("<td>" + price + "</td>");
                        out.println("<td>" + description + "</td>");
                        out.println("<td><form action='AdminServlet' method='post' style='display:inline;'>");
                        out.println("<input type='hidden' name='action' value='deleteFood'>");
                        out.println("<input type='hidden' name='id' value='" + id + "'>");
                        out.println("<input type='submit' value='Delete' class='delete-btn'>");
                        out.println("</form></td>");
                        out.println("</tr>");
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>

    <!-- Similar Sections for Cart, Orders, Billing, and Users can be added here -->
    <!-- Insert New Entry for Billing -->
<h3>Manage Billing</h3>
<form action="AdminServlet" method="post">
    <input type="hidden" name="action" value="insertBilling">
    <label for="customer_id">Customer ID:</label>
    <input type="number" id="customer_id" name="customer_id" required>

    <label for="order_id">Order ID:</label>
    <input type="number" id="order_id" name="order_id" required>

    <label for="total_amount">Total Amount:</label>
    <input type="number" step="0.01" id="total_amount" name="total_amount" required>

    <label for="billing_date">Billing Date:</label>
    <input type="datetime-local" id="billing_date" name="billing_date">

    <input type="submit" value="Add Billing">
</form>

<!-- Display Billing with Delete Option -->
<h3>Billing</h3>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Customer ID</th>
            <th>Order ID</th>
            <th>Total Amount</th>
            <th>Billing Date</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_db", "root", "password");
                String query = "SELECT * FROM billing";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    int customerId = rs.getInt("customer_id");
                    int orderId = rs.getInt("order_id");
                    double totalAmount = rs.getDouble("total_amount");
                    Timestamp billingDate = rs.getTimestamp("billing_date");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + customerId + "</td>");
                    out.println("<td>" + orderId + "</td>");
                    out.println("<td>" + totalAmount + "</td>");
                    out.println("<td>" + billingDate + "</td>");
                    out.println("<td><form action='AdminServlet' method='post' style='display:inline;'>");
                    out.println("<input type='hidden' name='action' value='deleteBilling'>");
                    out.println("<input type='hidden' name='id' value='" + id + "'>");
                    out.println("<input type='submit' value='Delete' class='delete-btn'>");
                    out.println("</form></td>");
                    out.println("</tr>");
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </tbody>
</table>
    
    <!-- Insert New Entry for Orders -->
<h3>Manage Orders</h3>
<form action="AdminServlet" method="post">
    <input type="hidden" name="action" value="insertOrder">
    <label for="customer_id">Customer ID:</label>
    <input type="number" id="customer_id" name="customer_id" required>

    <label for="food_id">Food ID:</label>
    <input type="number" id="food_id" name="food_id" required>

    <label for="status">Order Status:</label>
    <select id="status" name="status">
        <option value="accepted">Accepted</option>
        <option value="waiting">Waiting</option>
        <option value="completed">Completed</option>
    </select>

    <input type="submit" value="Add Order">
</form>

<!-- Display Orders with Delete Option -->
<h3>Orders</h3>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Customer ID</th>
            <th>Food ID</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_db", "root", "password");
                String query = "SELECT * FROM orders";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    int customerId = rs.getInt("customer_id");
                    int foodId = rs.getInt("food_id");
                    String status = rs.getString("status");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + customerId + "</td>");
                    out.println("<td>" + foodId + "</td>");
                    out.println("<td>" + status + "</td>");
                    out.println("<td><form action='AdminServlet' method='post' style='display:inline;'>");
                    out.println("<input type='hidden' name='action' value='deleteOrder'>");
                    out.println("<input type='hidden' name='id' value='" + id + "'>");
                    out.println("<input type='submit' value='Delete' class='delete-btn'>");
                    out.println("</form></td>");
                    out.println("</tr>");
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </tbody>
</table>
    
    <!-- Insert New Entry for Users -->
<h3>Manage Users</h3>
<form action="AdminServlet" method="post">
    <input type="hidden" name="action" value="insertUser">
    <label for="name">User Name:</label>
    <input type="text" id="name" name="name" required>

    <label for="address">Address:</label>
    <textarea id="address" name="address"></textarea>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required>

    <label for="role">Role:</label>
    <select id="role" name="role">
        <option value="customer">Customer</option>
        <option value="chef">Chef</option>
    </select>

    <input type="submit" value="Add User">
</form>

<!-- Display Users with Delete Option -->
<h3>Users</h3>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Email</th>
            <th>Role</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_db", "root", "password");
                String query = "SELECT * FROM users";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String address = rs.getString("address");
                    String email = rs.getString("email");
                    String role = rs.getString("role");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + name + "</td>");
                    out.println("<td>" + address + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + role + "</td>");
                    out.println("<td><form action='AdminServlet' method='post' style='display:inline;'>");
                    out.println("<input type='hidden' name='action' value='deleteUser'>");
                    out.println("<input type='hidden' name='id' value='" + id + "'>");
                    out.println("<input type='submit' value='Delete' class='delete-btn'>");
                    out.println("</form></td>");
                    out.println("</tr>");
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </tbody>
</table>
    <<!-- Insert New Entry for Cart -->
<h3>Manage Cart</h3>
<form action="AdminServlet" method="post">
    <input type="hidden" name="action" value="insertCart">
    <label for="customer_id">Customer ID:</label>
    <input type="number" id="customer_id" name="customer_id" required>

    <label for="food_id">Food ID:</label>
    <input type="number" id="food_id" name="food_id" required>

    <label for="quantity">Quantity:</label>
    <input type="number" id="quantity" name="quantity" value="1">

    <input type="submit" value="Add to Cart">
</form>

<!-- Display Cart with Delete Option -->
<h3>Cart</h3>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Customer ID</th>
            <th>Food ID</th>
            <th>Quantity</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_db", "root", "root123");
                String query = "SELECT * FROM cart";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    int customerId = rs.getInt("customer_id");
                    int foodId = rs.getInt("food_id");
                    int quantity = rs.getInt("quantity");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + customerId + "</td>");
                    out.println("<td>" + foodId + "</td>");
                    out.println("<td>" + quantity + "</td>");
                    out.println("<td><form action='AdminServlet' method='post' style='display:inline;'>");
                    out.println("<input type='hidden' name='action' value='deleteCart'>");
                    out.println("<input type='hidden' name='id' value='" + id + "'>");
                    out.println("<input type='submit' value='Delete' class='delete-btn'>");
                    out.println("</form></td>");
                    out.println("</tr>");
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </tbody>
</table>



    

</body>
</html>

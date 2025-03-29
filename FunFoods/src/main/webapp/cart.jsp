<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Light background */
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .total-amount {
            font-size: 1.25rem;
            font-weight: bold;
            margin-top: 20px;
        }
        .btn-danger {
            border-radius: 20px;
        }
        .btn-primary {
            border-radius: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Your Cart</h2>
        <%
            // Check if user is logged in
            Integer customerId = (Integer) session.getAttribute("userId");
            if (customerId == null) {
        %>
            <div class="alert alert-warning text-center">
                You need to log in to view your cart.
            </div>
        <%
            } else {
                // Proceed to display the cart items
        %>
        <div class="row">
            <%
                String url = "jdbc:mysql://localhost:3306/restaurant_db";
                String user = "root"; // Change to your MySQL username
                String pass = "root123"; // Change to your MySQL password
                Connection con = DriverManager.getConnection(url, user, pass);
                String sql = "SELECT c.id, f.name, f.price, c.quantity FROM cart c JOIN foods f ON c.food_id = f.id WHERE c.customer_id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, customerId);
                ResultSet rs = ps.executeQuery();

                double totalAmount = 0;
                while (rs.next()) {
                    int cartId = rs.getInt("id"); // Get cart item id for removal
                    String foodName = rs.getString("name");
                    double foodPrice = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    totalAmount += foodPrice * quantity;
            %>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><%= foodName %></h5>
                        <p class="card-text">Price: ₹<%= foodPrice %></p>
                        <p class="card-text">Quantity: <%= quantity %></p>
                        <form action="RemoveCartItemServlet" method="post" style="display:inline;">
                            <input type="hidden" name="cartId" value="<%= cartId %>">
                            <button type="submit" class="btn btn-danger">Remove</button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                }
                ps.close();
                con.close();
            %>
        </div>
        
        <h3 class="total-amount text-right">Total Amount: ₹<%= totalAmount %></h3>
        
        <!-- Checkout Button -->
        <form action="checkout.jsp" class="text-right">
            <button type="submit" class="btn btn-primary">Checkout</button>
        </form>

        <%
            }
        %>
    </div>
</body>
</html>

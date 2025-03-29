<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f1f1f1;
        }
        .container {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-top: 30px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }
        h2, h3 {
            margin-bottom: 20px;
            font-weight: 600;
        }
        .table {
            margin-bottom: 30px;
        }
        .btn-success {
            padding: 10px 20px;
            font-size: 1.1rem;
            border-radius: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Checkout</h2>
        <p class="text-center">Please review your order and click the "Place Order" button to complete your purchase.</p>
        
        <!-- Order Summary -->
        <h3>Order Summary</h3>
        <table class="table table-hover table-bordered">
            <thead class="thead-light">
                <tr>
                    <th>Item</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Integer customerId = (Integer) session.getAttribute("userId");
                    if (customerId == null) {
                %>
                    <div class="alert alert-warning text-center">
                        You need to log in to view the checkout page.
                    </div>
                <%
                    } else {
                        String url = "jdbc:mysql://localhost:3306/restaurant_db";
                        String user = "root"; // Update MySQL username
                        String pass = "root123"; // Update MySQL password
                        Connection con = DriverManager.getConnection(url, user, pass);
                        String sql = "SELECT f.name, f.price, c.quantity FROM cart c JOIN foods f ON c.food_id = f.id WHERE c.customer_id = ?";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setInt(1, customerId);
                        ResultSet rs = ps.executeQuery();
                        
                        double totalAmount = 0;
                        
                        while (rs.next()) {
                            String foodName = rs.getString("name");
                            double foodPrice = rs.getDouble("price");
                            int quantity = rs.getInt("quantity");
                            double itemTotal = foodPrice * quantity;
                            totalAmount += itemTotal;
                %>
                <tr>
                    <td><%= foodName %></td>
                    <td>₹<%= foodPrice %></td>
                    <td><%= quantity %></td>
                    <td>₹<%= itemTotal %></td>
                </tr>
                <%
                        }
                        ps.close();
                        con.close();
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3" class="text-right"><strong>Total Amount</strong></td>
                    <td><strong>₹<%= totalAmount %></strong></td>
                </tr>
            </tfoot>
        </table>
        
        <!-- Payment Section -->
        <h3>Payment Options</h3>
        <form action="PlaceOrderServlet" method="post">
            <div class="form-group">
                <label for="paymentMethod">Select Payment Method:</label>
                <select class="form-control" id="paymentMethod" name="paymentMethod">
                    <option value="cod">Cash on Delivery</option>
                    <option value="card">Credit/Debit Card</option>
                    <option value="upi">UPI</option>
                </select>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-success">Place Order</button>
            </div>
        </form>
        <%
            }
        %>
    </div>
</body>
</html>

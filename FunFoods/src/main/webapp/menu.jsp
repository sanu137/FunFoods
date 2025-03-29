<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Menu</h2>

        <%
            // Display success message if available
            String successMessage = (String) request.getAttribute("successMessage");
            if (successMessage != null) {
        %>
            <div class="alert alert-success">
                <%= successMessage %>
            </div>
        <%
            }
        %>

        <%
            // Check if user is logged in
            Integer customerId = (Integer) session.getAttribute("userId");
            if (customerId == null) {
        %>
            <div class="alert alert-warning">
                You need to log in to view the menu.
            </div>
        <%
            } else {
                // Proceed to display the menu
        %>
        <div class="row">
            <%
                // Hard-coded food items and image paths
                String[][] foods = {
                    {"1", "Margherita Pizza", "Classic pizza topped with fresh tomatoes, mozzarella cheese, and basil.", "299.00", "Veg_Pizza.jpeg"},
                    {"2", "Veggie Burger", "A delicious burger made with fresh vegetables and served with a side of fries.", "149.00", "burger.jpg.jpg"},
                    {"3", "Pasta Alfredo", "Creamy Alfredo sauce with fettuccine pasta and parmesan cheese.", "349.00", "Alfredo.jpg.jpg"},
                    {"4", "Noodles Stir Fry", "Stir-fried noodles with mixed vegetables in a savory sauce.", "199.00", "noodles.jpg"},
                    {"5", "Lemonade", "Refreshing lemonade made with fresh lemons and mint.", "50.00", "lemonade.jpg"},
                    {"6", "Mushroom Risotto", "Creamy risotto with mushrooms and parmesan cheese.", "399.00", "mushroom.jpg"},
                    {"7", "Garlic Bread", "Crispy garlic bread topped with melted butter and herbs.", "99.00", "garlic-bread-recipe-2.jpg"},
                    {"8", "Chocolate Brownie", "Rich and fudgy chocolate brownie served with vanilla ice cream.", "120.00", "choco.jpg"},
                    {"9", "Paneer Tikka", "Chunks of cottage cheese marinated with spices and grilled to perfection.", "249.00", "paneer.jpg"},
                    {"10", "Tandoori Chicken", "Grilled chicken marinated with Indian spices and served with naan.", "499.00", "chicken.jpg"},
                };

                for (String[] food : foods) {
                    int foodId = Integer.parseInt(food[0]);
                    String foodName = food[1];
                    String foodDescription = food[2];
                    double foodPrice = Double.parseDouble(food[3]);
                    String foodImage = food[4]; // Image path
            %>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="<%= foodImage %>" class="card-img-top" alt="<%= foodName %>" style="height: 200px; object-fit: cover;"> <!-- Add image -->
                    <div class="card-body">
                        <h5 class="card-title"><%= foodName %></h5>
                        <p class="card-text"><%= foodDescription %></p>
                        <p class="card-text">Price: ₹<%= foodPrice %></p>
                        <form action="AddToCartServlet" method="post"> <!-- Action changed to AddToCartServlet -->
                            <input type="hidden" name="foodId" value="<%= foodId %>">
                            <input type="hidden" name="customerId" value="<%= customerId %>">
                            <input type="number" name="quantity" min="1" value="1" class="form-control mb-2" style="width: 80px;">
                            <button type="submit" class="btn btn-primary">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>

        <!-- Go to Cart button -->
        <form action="cart.jsp">
            <button type="submit" class="btn btn-success">Go to Cart</button>
        </form>

        <%
            }
        %>
    </div>
</body>
</html>

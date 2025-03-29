import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Servlet implementation class PlaceOrderServlet
 */
@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlaceOrderServlet() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("userId");

        if (customerId == null) {
            response.getWriter().println("You must be logged in to place an order.");
            return;
        }

        String url = "jdbc:mysql://localhost:3306/restaurant_db";
        String user = "root"; // Your MySQL username
        String pass = "root123"; // Your MySQL password

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);

            // Step 1: Retrieve cart items for the user
            String cartQuery = "SELECT f.id, f.name, f.price, c.quantity FROM cart c JOIN foods f ON c.food_id = f.id WHERE c.customer_id = ?";
            ps = con.prepareStatement(cartQuery);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();

            // Step 2: Calculate the total amount
            double totalAmount = 0;
            StringBuilder orderDetails = new StringBuilder();
            while (rs.next()) {
                int foodId = rs.getInt("id");
                String foodName = rs.getString("name");
                double foodPrice = rs.getDouble("price");
                int quantity = rs.getInt("quantity");
                totalAmount += foodPrice * quantity;

                orderDetails.append("Food: ").append(foodName).append(", Quantity: ").append(quantity)
                        .append(", Price: ₹").append(foodPrice).append("\n");
            }

            if (totalAmount == 0) {
                response.getWriter().println("Your cart is empty.");
                return;
            }

            // Step 3: Insert the order into the orders table
            String insertOrder = "INSERT INTO orders (customer_id, total_amount, order_details) VALUES (?, ?, ?)";
            ps = con.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, customerId);
            ps.setDouble(2, totalAmount);
            ps.setString(3, orderDetails.toString());
            ps.executeUpdate();

            // Retrieve the generated order ID
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int orderId = rs.getInt(1);
                response.setContentType("text/html");
                response.getWriter().println("<html><head><style>"
                        + "body { display: flex; justify-content: center; align-items: center; height: 100vh; "
                        + "font-family: Arial, sans-serif; }"
                        + ".message { text-align: center; padding: 20px; border: 2px solid #4CAF50; "
                        + "border-radius: 5px; background-color: #f9f9f9; color: #333; }"
                        + "</style></head><body>"
                        + "<div class='message'>"
                        + "<h2>Order placed successfully!!</h2>"
                        + "<p>Your Order ID is: <strong>" + orderId + "</strong></p>"
                        + "<p>Enjoy your food! Visit us again!!</p>"
                        + "</div>"
                        + "</body></html>");
            }


        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

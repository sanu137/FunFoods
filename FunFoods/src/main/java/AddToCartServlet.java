import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session and customer ID
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("userId");
        
        // Check if user is logged in
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get the form parameters from the request
        int foodId = Integer.parseInt(request.getParameter("foodId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/restaurant_db";
        String user = "root"; // Your MySQL username
        String pass = "root123"; // Your MySQL password

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Establish a database connection
            con = DriverManager.getConnection(url, user, pass);

            // Check if the item is already in the cart for this user
            String checkCartSQL = "SELECT id, quantity FROM cart WHERE customer_id = ? AND food_id = ?";
            ps = con.prepareStatement(checkCartSQL);
            ps.setInt(1, customerId);
            ps.setInt(2, foodId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Item already exists in the cart, so update the quantity
                int cartId = rs.getInt("id");
                int currentQuantity = rs.getInt("quantity");

                String updateCartSQL = "UPDATE cart SET quantity = ? WHERE id = ?";
                ps = con.prepareStatement(updateCartSQL);
                ps.setInt(1, currentQuantity + quantity); // Add to existing quantity
                ps.setInt(2, cartId);
                ps.executeUpdate();

            } else {
                // Item does not exist in the cart, so insert a new entry
                String insertCartSQL = "INSERT INTO cart (customer_id, food_id, quantity) VALUES (?, ?, ?)";
                ps = con.prepareStatement(insertCartSQL);
                ps.setInt(1, customerId);
                ps.setInt(2, foodId);
                ps.setInt(3, quantity);
                ps.executeUpdate();
            }

            // Redirect back to the menu with a success message
            request.setAttribute("successMessage", "Item added to cart successfully!");
            request.getRequestDispatcher("menu.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}

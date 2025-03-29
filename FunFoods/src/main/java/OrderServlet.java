import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String foodIdStr = request.getParameter("foodId");
        String customerIdStr = request.getParameter("customerId");

        // Check for null or empty parameters	
        if (foodIdStr == null || customerIdStr == null) {
            // Handle the error appropriately
            response.sendRedirect("menu.jsp?status=error");
            return;
        }

        int foodId = Integer.parseInt(foodIdStr);
        int customerId = Integer.parseInt(customerIdStr);

        String url = "jdbc:mysql://localhost:3306/restaurant_db";
        String user = "root"; // Change to your MySQL username
        String pass = "root123"; // Change to your MySQL password

        try (Connection con = DriverManager.getConnection(url, user, pass)) {
            // Add food item to the cart
            String sql = "INSERT INTO cart (customer_id, food_id, quantity) VALUES (?, ?, 1)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, customerId);
            ps.setInt(2, foodId);
            ps.executeUpdate();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to menu.jsp with a status parameter
        response.sendRedirect("menu.jsp?status=added");
    }
}

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class AddFoodServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the food details from the form
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("description");

        try {
            // Convert the price to a decimal
            double price = Double.parseDouble(priceStr);

            // Database connection
            String url = "jdbc:mysql://localhost:3306/restaurant_db";
            String user = "root";
            String pass = "root123"; // Replace with your MySQL password

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);

            // Insert food details into the foods table
            String sql = "INSERT INTO foods (name, price, description) VALUES (?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setString(3, description);

            int rows = stmt.executeUpdate();

            // Check if the insert was successful
            if (rows > 0) {
                response.getWriter().println("Food item added successfully!");
            } else {
                response.getWriter().println("Error adding food item.");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

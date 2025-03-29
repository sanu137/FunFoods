import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/RemoveCartItemServlet")
public class RemoveCartItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cartId = Integer.parseInt(request.getParameter("cartId"));

        String url = "jdbc:mysql://localhost:3306/restaurant_db";
        String user = "root"; // Change to your MySQL username
        String pass = "root123"; // Change to your MySQL password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);
            String sql = "DELETE FROM cart WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, cartId);
            ps.executeUpdate();
            ps.close();
            con.close();

            // Redirect back to cart page
            response.sendRedirect("cart.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

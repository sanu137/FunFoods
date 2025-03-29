# FunFoods
Food Ordering System:is An intuitive food ordering system designed to streamline the dining experience in fast-food restaurants.
By simplifying the ordering
process, it reduces the workload for waitstaff and enables customers to directly convey
their meal preferences to the kitchen via our user-friendly website. With just a few
clicks, customers can browse the menu, add their favorite dishes to the cart, and place
their orders efficiently. The system ensures quick and accurate order transmission,
allowing customers to enjoy their meals without delays.

Objectives
1. Enhance Customer Experience: Our system eliminates long queues, reduces
errors, and improves satisfaction by allowing customers to browse the menu,
select items, and place orders at their own pace without relying on in-person or
phone orders.
2. Streamline the Ordering Process: By implementing a digital ordering system,
we simplify the process for customers and staff, ensuring accurate communication
with the kitchen and improving service speed.
3. Efficient Order Management: The system allows easy cart management, with
all order details stored in a MySQL database, ensuring seamless record-keeping
and processing.
4. Reduce Wait Times and Staff Workload: The self-service platform reduces the
workload on staff, allowing faster order fulfillment and operational efficiency.
5. Scalability for Future Integration: While payment methods are not included, the
system is designed to accommodate future enhancements, such as payment
gateways.


TECH STACK
1. Frontend:
○ HTML & CSS: Used to design and structure the web interface, allowing
customers to browse the menu, add items to their cart, and place orders.
HTML provides the framework, while CSS styles the pages for a
user-friendly experience.
2. Backend:
○ Java: Handles the core functionality and logic of the system, ensuring that
requests from users are processed efficiently.
○ JSP (Java Server Pages): Dynamically generates web content by
embedding Java code into HTML pages, displaying data like menu items or
order confirmation.
○ Java Servlets: Processes user requests, such as adding items to the cart or
placing orders, and interacts with the database to retrieve or store data.
3. Database:
○ MySQL: Stores all customer, menu, and order information, ensuring
efficient data management and retrieval for order processing.
4. Server:
○ Apache Tomcat: Hosts the web application, handling requests and
ensuring smooth communication between the front end and back end.


DESIGN AND IMPLEMENTATION

1.Customer
a. Register: using SignupServlet.java and signup.jsp.
b. Login: using SigninServlet.java and signin.jsp.
c. Menu: Welcome.jsp, menu.jsp, OrderServlet.java and AddFoodsServlet.java to display foods in cart functionality.
d. Cart: cart.jsp, cart.css, RemoveCartItemServlet.java helps Display and manipulate all the food items in the cart items.
e. Checkout: Checkout.jsp Shows the bill to the user and payment options.
f. Place Order: PlaceOredrServlet.java finally places order in the database.

2. Admin
a. Admin.html: Shows the admin homepage with rules and regulations for employees.
b. customer.jsp: Displays details of all the registered customers. To be able to manipulate details of all customers.
c. cart.jsp: Displays the current cart cart of all the orders. A form to insert or delete from the cart.
d. menu.jsp: Displays all the foods from the menu to be able to manipulate
e. orders.jsp: Displays list of all orders in a day with order number. to be able to manipulate orders.


 



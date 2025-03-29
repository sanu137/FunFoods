<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <style>
        body {
            background: url('bg_3.jpeg') no-repeat center center fixed; /* Background image */
            background-size: cover; /* Cover the entire viewport */
            color: #000; /* Light gray text */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            justify-content: center; /* Center vertically */
            align-items: center; /* Center horizontally */
            margin: 0;
            font-family: 'Poppins', sans-serif; /* Use a nice font */
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.3); /* White with transparency */
            border-radius: 10px; /* Rounded corners */
            padding: 40px; /* Space inside the box */
            backdrop-filter: blur(10px); /* Blur effect */
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5); /* Shadow effect */
            width: 100%; /* Full width */
            max-width: 400px; /* Limit width */
            text-align: center; /* Center text */
        }

        h2 {
            font-size: 2em;
            margin-bottom: 20px;
            color: #fff; /* White for the heading */
        }

        label {
            display: block; /* Stack labels */
            margin-top: 10px; /* Space above labels */
            text-align: left; /* Align left */
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%; /* Full width */
            padding: 10px; /* Space inside inputs */
            margin-top: 5px; /* Space above inputs */
            border: none; /* Remove border */
            border-radius: 5px; /* Rounded corners */
            background: rgba(255, 255, 255, 0.5); /* Light background */
            color: #000; /* Black text */
        }

        input[type="submit"] {
            background-color: #28a745; /* Green button color */
            color: white;
            border: none;
            padding: 15px 20px;
            font-size: 1.2em;
            border-radius: 5px;
            cursor: pointer; /* Pointer on hover */
            margin-top: 20px; /* Space above button */
            transition: background-color 0.3s; /* Smooth transition */
        }

        input[type="submit"]:hover {
            background-color: #218838; /* Darker shade for hover */
        }

        p {
            margin-top: 20px; /* Space above paragraph */
            color: #000; /* Light gray for text */
        }

        a {
            color: #28a745; /* Green for links */
            text-decoration: none; /* Remove underline */
        }

        a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>
    <div class="glass-effect">
        <h2>Sign Up</h2>
        <form action="SignupServlet" method="post">
            <label>Name:</label>
            <input type="text" name="name" required>
            
            <label>Address:</label>
            <input type="text" name="address" required>
            
            <label>Phone:</label>
            <input type="text" name="phone" required>
            
            <label>Email:</label>
            <input type="email" name="email" required>
            
            <label>Password:</label>
            <input type="password" name="password" required>
            
            <label>Role:</label>
            <select name="role" required>
                <option value="customer">Customer</option>
            </select>
            
            <input type="submit" value="Sign Up">
        </form>
        <p>Already have an account? <a href="signin.jsp">Sign In</a></p>
    </div>
</body>
</html>

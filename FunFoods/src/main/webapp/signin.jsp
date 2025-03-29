<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        * {
            color: #fff; /* Default text color */
            margin: 0;
            padding: 0;
            box-sizing: border-box; /* Ensure padding and border are included in total width and height */
        }

        .bg {
            background: url('bg_3.jpeg'); /* Background image */
            height: 100vh;
            width: 100%;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover; /* Cover the entire area */
            display: flex; /* Centering the form */
            justify-content: center; /* Center horizontally */
            align-items: center; /* Center vertically */
        }

        .form-container {
            border: 0px solid #fff; /* No border, can be adjusted if needed */
            padding: 50px 60px;
            margin-top: 20vh;
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background for the form */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 1px 4px 26px 11px rgba(0, 0, 0, 0.75); /* Box shadow */
        }

        .header {
            color: white;
            text-shadow:
                -1px -1px 0 #000,
                1px -1px 0 #000,
                -1px 1px 0 #000,
                1px 1px 0 #000; /* Text shadow for header */
            text-align: center;
            font-size: 3em; /* Size of the header */
            margin-bottom: 20px; /* Space below header */
        }

        h2 {
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: none;
            border-radius: 30px;
            background-color: rgba(255, 255, 255, 0.9); /* Lighter background for inputs */
            font-size: 1em;
            color: #000; /* Black text for better readability */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            box-shadow: 0 4px 12px rgba(255, 255, 255, 0.5);
        }

        input[type="submit"] {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 30px;
            background-color: #ff6347; /* Bright red button */
            color: white;
            font-size: 1.2em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #ff4500; /* Darker red on hover */
            transform: scale(1.05); /* Slight scaling on hover */
        }

        p {
            color: white;
            text-align: center;
            margin-top: 20px;
        }

        p a {
            color: #ffeb3b; /* Bright yellow for the link */
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        p a:hover {
            color: #fff; /* White on hover */
        }
    </style>
</head>
<body>
    <div class="bg">
        <div class="form-container">
            <h1 class="header">FunFoods</h1> <!-- Title -->
            <h2>Sign In</h2>
            <form action="SigninServlet" method="post">
                <input type="text" name="name" placeholder="Username" required />
                <input type="password" name="password" placeholder="Password" required />
                <input type="submit" value="Login">
            </form>
            <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p> <!-- Link below inputs -->
        </div>
    </div>
</body>
</html>

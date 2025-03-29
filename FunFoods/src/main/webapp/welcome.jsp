<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to FunFoods</title>
    <style>
        body {
            background-color: #000; /* Black background */
            color: #cccccc; /* Light gray text */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
            font-family: 'Poppins', sans-serif; /* Use a nice font */
        }
        
        .navbar {
            background-color: #333; /* Darker shade for navbar */
            display: flex;
            justify-content: space-between;
            padding: 10px 20px;
        }
        
        .navbar a {
            color: #cccccc; /* White color for navbar links */
            text-decoration: none;
            padding: 10px;
        }

        .navbar a:hover {
            color: #fff; /* White on hover */
        }

        .hero {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
            text-align: center;
            background: url('bg_3.jpeg') no-repeat center center; 
            background-size: cover;
            position: relative;
            filter: brightness(60%); /* Darken background image */
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.3); /* White with transparency */
            border-radius: 10px; /* Rounded corners */
            padding: 30px; /* Space inside the box */
            backdrop-filter: blur(10px); /* Blur effect */
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5); /* Shadow effect */
            margin: 20px;
        }

        .hero h1 {
            font-size: 4em;
            font-weight: bold;
            color: #000000 ; /* White for the heading */
            margin-bottom: 20px;
        }

        .hero p {
            font-size: 1.5em;
            margin-bottom: 40px;
            color: #000000 ; /* White for the paragraph */
        }

        .btn-custom {
            background-color: #28a745; /* Green button color */
            color: white;
            border: none;
            padding: 15px 30px;
            font-size: 1.2em;
            border-radius: 5px;
            text-decoration: none; /* No underline */
        }

        .btn-custom:hover {
            background-color: #218838; /* Darker shade for hover */
        }

        .about-section {
            padding: 50px 0;
            background-color: #222; /* Dark background for about section */
            text-align: center;
            color: #cccccc; /* Light gray text */
        }

        .footer {
            background-color: #333; /* Darker shade for footer */
            color: #cccccc; /* Light gray text */
            padding: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <a href="#">FunFoods</a>
        <div>
            <a href="signin.jsp">Sign In</a>
            <a href="#" onclick="toggleAbout()">About Us</a>
        </div>
    </div>

    <!-- Hero Section -->
    <div class="hero">
        <div class="glass-effect">
            <h1>Welcome to FunFoods!</h1>
            <p>Your favorite online food delivery app.</p>
            <a href="signup.jsp" class="btn-custom">Signup Now</a>
        </div>
    </div>

    <!-- About Us Section -->
    <div id="aboutUs" class="about-section" style="display: none;">
        <div class="container">
            <h5>About Us</h5>
            <p>FunFoods is your go-to online food delivery app for FunFoods Cafe, bringing delicious meals to your doorstep. Enjoy a variety of dishes crafted with care and passion.</p>
            <p><strong>Address:</strong> Funfoods Cafe, Arcade, 778, Andheri East, Mumbai 40059, India</p>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2024 FunFoods Cafe. Enjoy your food and visit us again!</p>
    </div>

    <script>
        function toggleAbout() {
            const aboutSection = document.getElementById('aboutUs');
            if (aboutSection.style.display === 'none') {
                aboutSection.style.display = 'block';
            } else {
                aboutSection.style.display = 'none';
            }
        }
    </script>
</body>
</html>

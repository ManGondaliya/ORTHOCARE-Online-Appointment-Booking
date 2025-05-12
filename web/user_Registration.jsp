<%-- 
    Document   : user_Registration
    Created on : Nov 23, 2024, 9:48:01 PM
    Author     : hp
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - OrthoCare</title>
    <link rel="icon" type="image/x-icon" href="images/ortho-logo.png">
    
    <link rel="stylesheet" href="css/userRegister_style.css">

    <script>
         Form Validation Function
        function validateForm() {
            const fullName = document.getElementById("fullname").value.trim();
            const email = document.getElementById("email").value.trim();
            const mobile = document.getElementById("mobile").value.trim();
            const dob = document.getElementById("dob").value.trim();
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirm-password").value;

           
            if (fullName === "") {
                alert("Full Name is required.");
                return false;
            }

            
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }

            
            const mobilePattern = /^[6-9]\d{9}$/;
            if (!mobilePattern.test(mobile)) {
                alert("Please enter a valid 10-digit mobile number.");
                return false;
            }

            
            if (dob === "") {
                alert("Date of Birth is required.");
                return false;
            }

            
            if (password.length < 6) {
                alert("Password must be at least 6 characters long.");
                return false;
            }

            
            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }

            return true; // Allow form submission
        }
    </script>
</head>
<body>

    
    <div class="header">
        <div class="logo">
            <img src="images/ortho-logo.png" alt="Logo">
            <span>OrthoCare</span>
        </div>
        <div class="title">User Registration Form</div>
        <div class="nav">
            <a href="user_IndexPage.jsp">Home</a>
        </div>
    </div>

    
    <div class="form-container">
        <h2>Register Here</h2>
        <form action="UserRegister" method="POST" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type="text" id="fullname" name="fullname" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="mobile">Mobile Number</label>
                <input type="number" id="mobile" name="mobile" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender</label>
                <select id="gender" name="gender" required>
                    <option value="">Select</option>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth</label>
                <input type="date" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <textarea id="address" name="address" rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirm-password">Confirm Password</label>
                <input type="password" id="confirm-password" name="confirm-password" required>
            </div>
            <div class="form-actions">
                <button type="submit">Register</button>
            </div>
            <div class="form-footer">
                Already registered? <a href="userLogin.jsp">Login here</a>
            </div>
        </form>
    </div>

</body>
</html>

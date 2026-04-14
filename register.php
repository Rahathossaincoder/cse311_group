<?php
session_start();
require_once 'db_config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $full_name = trim($_POST['full_name']);
    $email = trim($_POST['email']);
    $phone = trim($_POST['phone_number']);
    $address = trim($_POST['address'] ?? '');
    $city = trim($_POST['city'] ?? 'Dhaka');
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    $errors = [];

    // Validation
    if (strlen($full_name) < 3) $errors[] = "Name must be at least 3 characters";
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) $errors[] = "Invalid email format";
    if (!preg_match('/^01[3-9][0-9]{8}$/', $phone)) $errors[] = "Invalid phone number format";
    if (strlen($password) < 6) $errors[] = "Password must be at least 6 characters";
    if ($password !== $confirm_password) $errors[] = "Passwords do not match";

    // Check duplicate email
    if (empty($errors)) {
        $check = $pdo->prepare("SELECT email FROM Users WHERE email = ?");
        $check->execute([$email]);
        if ($check->fetch()) $errors[] = "Email already registered!";
    }

    if (empty($errors)) {
        $hashed = password_hash($password, PASSWORD_DEFAULT);

        try {
            $sql = "INSERT INTO Users (full_name, email, phone_number, password, address, city, registration_date, user_role, account_status) 
                    VALUES (:name, :email, :phone, :pass, :addr, :city, NOW(), 'Citizen', 'Active')";
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                ':name' => $full_name,
                ':email' => $email,
                ':phone' => $phone,
                ':pass' => $hashed,
                ':addr' => $address,
                ':city' => $city
            ]);

            $_SESSION['success'] = "Registration successful! Please login.";
            header("Location: login.php");
            exit();
        } catch (PDOException $e) {
            $errors[] = "Registration error: " . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Smart Traffic System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h1>Create Account</h1>
            <p>Join our community of concerned citizens</p>

            <?php if (!empty($errors)): ?>
                <div class="alert alert-danger">
                    <?php foreach ($errors as $err): ?>
                        <p><?php echo htmlspecialchars($err); ?></p>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

            <form action="register.php" method="POST" class="auth-form">
                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="full_name" placeholder="Your full name" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="tel" name="phone_number" placeholder="01XXXXXXXXX" required>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" placeholder="Street address">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>City</label>
                        <input type="text" name="city" value="Dhaka" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Create password" required>
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirm_password" placeholder="Confirm password" required>
                </div>

                <button type="submit" class="btn btn-full">Create Account</button>
            </form>

            <div class="footer-links">
                Already have an account? <a href="login.php">Login here</a>
            </div>
        </div>
    </div>
</body>
</html>
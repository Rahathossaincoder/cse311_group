<?php
session_start();
require_once 'db_config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = trim($_POST['email']);
    $password = $_POST['password'];

    // Try to find admin in Admins table
    $stmt = $pdo->prepare("SELECT * FROM Admins WHERE email = ?");
    $stmt->execute([$email]);
    $admin = $stmt->fetch();

    if ($admin) {
        $verified = false;
        
        // Check password
        if (password_verify($password, $admin['password'])) {
            $verified = true;
        } elseif ($admin['password'] === $password) { // Legacy plain-text support
            $verified = true;
            // Auto-hash for security
            $newHash = password_hash($password, PASSWORD_DEFAULT);
            $update = $pdo->prepare("UPDATE Admins SET password = ? WHERE admin_id = ?");
            $update->execute([$newHash, $admin['admin_id']]);
        }

        if ($verified) {
            $_SESSION['user_id'] = $admin['admin_id'];
            $_SESSION['user_name'] = $admin['admin_name'];
            $_SESSION['user_role'] = 'Admin';
            $_SESSION['is_admin'] = true; // This is the KEY flag
            header("Location: admin_dashboard.php");
            exit();
        }
    }

    $error = "Invalid admin email or password!";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Traffic Complaint System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h1>Admin Login</h1>
            <p>Traffic Department Management Portal</p>

            <?php if (isset($error)): ?>
                <div class="alert alert-danger"><?php echo htmlspecialchars($error); ?></div>
            <?php endif; ?>

            <form action="admin_login.php" method="POST" class="auth-form">
                <div class="form-group">
                    <label for="email">Admin Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter admin email" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter password" required>
                </div>

                <button type="submit" class="btn btn-full">Login as Admin</button>
            </form>

            <div class="footer-links">
                <p>Not an admin? <a href="login.php">Login as Citizen</a></p>
                <p><a href="index.php">← Back to Home</a></p>
            </div>
        </div>
    </div>
</body>
</html>
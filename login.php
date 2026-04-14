<?php
session_start();
require_once 'db_config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = trim($_POST['email']);
    $password = $_POST['password'];

    // Try Users table first
    $stmt = $pdo->prepare("SELECT * FROM Users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user) {
        $verified = false;
        if (password_verify($password, $user['password'])) {
            $verified = true;
        } elseif ($user['password'] === $password) {
            $verified = true;
            $newHash = password_hash($password, PASSWORD_DEFAULT);
            $update = $pdo->prepare("UPDATE Users SET password = ? WHERE user_id = ?");
            $update->execute([$newHash, $user['user_id']]);
        }

        if ($verified) {
            $_SESSION['user_id'] = $user['user_id'];
            $_SESSION['user_name'] = $user['full_name'];
            $_SESSION['user_role'] = $user['user_role'];
            $_SESSION['is_admin'] = false;
            header("Location: user_dashboard.php");
            exit();
        }
    }

    // Try Admins table
    $stmt = $pdo->prepare("SELECT * FROM Admins WHERE email = ?");
    $stmt->execute([$email]);
    $admin = $stmt->fetch();

    if ($admin) {
        $verified = false;
        if (password_verify($password, $admin['password'])) {
            $verified = true;
        } elseif ($admin['password'] === $password) {
            $verified = true;
            $newHash = password_hash($password, PASSWORD_DEFAULT);
            $update = $pdo->prepare("UPDATE Admins SET password = ? WHERE admin_id = ?");
            $update->execute([$newHash, $admin['admin_id']]);
        }

        if ($verified) {
            $_SESSION['user_id'] = $admin['admin_id'];
            $_SESSION['user_name'] = $admin['admin_name'];
            $_SESSION['user_role'] = 'Admin';
            $_SESSION['is_admin'] = true;
            header("Location: admin_dashboard.php");
            exit();
        }
    }

    $error = "Invalid email or password!";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Smart Traffic System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <h1>Welcome Back</h1>
            <p>Please enter your credentials to access the portal.</p>
            
            <?php if (isset($error)): ?>
                <div class="alert alert-danger"><?php echo $error; ?></div>
            <?php endif; ?>
            
            <form action="login.php" method="POST" class="auth-form">
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="email@example.com" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>

                <button type="submit" class="btn btn-full">Log In</button>
            </form>

            <div class="footer-links">
                Don't have an account? <a href="register.php">Register here</a>
            </div>
        </div>
    </div>
</body>
</html>
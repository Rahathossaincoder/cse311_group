<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['user_id']) || $_SESSION['is_admin']) {
    header("Location: login.php");
    exit();
}

$success = '';
$error = '';

// Get user data
$user = $pdo->prepare("SELECT * FROM Users WHERE user_id = ?");
$user->execute([$_SESSION['user_id']]);
$user = $user->fetch();

// Handle profile update
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $action = $_POST['action'] ?? '';

    if ($action === 'update_profile') {
        try {
            $stmt = $pdo->prepare("UPDATE Users SET full_name = ?, phone_number = ?, address = ? WHERE user_id = ?");
            $stmt->execute([$_POST['full_name'], $_POST['phone_number'], $_POST['address'], $_SESSION['user_id']]);
            $success = "Profile updated successfully!";
            $user = $pdo->prepare("SELECT * FROM Users WHERE user_id = ?")->execute([$_SESSION['user_id']]);
        } catch (Exception $e) {
            $error = "Error updating profile: " . $e->getMessage();
        }
    }

    if ($action === 'change_password') {
        if (strlen($_POST['new_password']) < 6) {
            $error = "Password must be at least 6 characters!";
        } elseif ($_POST['new_password'] !== $_POST['confirm_password']) {
            $error = "Passwords do not match!";
        } else {
            // Verify current password
            if (password_verify($_POST['current_password'], $user['password']) || $user['password'] === $_POST['current_password']) {
                $hashed = password_hash($_POST['new_password'], PASSWORD_DEFAULT);
                $stmt = $pdo->prepare("UPDATE Users SET password = ? WHERE user_id = ?");
                $stmt->execute([$hashed, $_SESSION['user_id']]);
                $success = "Password changed successfully!";
            } else {
                $error = "Current password is incorrect!";
            }
        }
    }
}

// Get complaint stats
$stats = $pdo->query("SELECT 
    (SELECT COUNT(*) FROM Complaints WHERE user_id = {$_SESSION['user_id']}) as total,
    (SELECT COUNT(*) FROM Complaints WHERE user_id = {$_SESSION['user_id']} AND status_id IN (3,22,34,37)) as resolved,
    (SELECT COUNT(*) FROM Complaints WHERE user_id = {$_SESSION['user_id']} AND status_id IN (1,11)) as pending
")->fetch();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Traffic Complaint System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo">🚦 Traffic Complaint System</div>
            <ul class="nav-links">
                <li><a href="user_dashboard.php">Dashboard</a></li>
                <li><a href="submit_complaint.php">Submit Complaint</a></li>
                <li><a href="my_complaints.php">My Complaints</a></li>
                <li><a href="profile.php" class="active">Profile</a></li>
                <li><a href="logout.php" class="logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Dashboard Container -->
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <div class="avatar">👤</div>
                <h3><?php echo htmlspecialchars($user['full_name']); ?></h3>
                <p><?php echo htmlspecialchars($user['email']); ?></p>
            </div>
            <ul class="menu">
                <li><a href="user_dashboard.php">Dashboard</a></li>
                <li><a href="submit_complaint.php">Submit Complaint</a></li>
                <li><a href="my_complaints.php">My Complaints</a></li>
                <li><a href="profile.php" class="active">Profile</a></li>
                <li><a href="logout.php">Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <h1>My Profile</h1>

            <?php if ($success): ?>
                <div class="alert alert-success">✅ <?php echo htmlspecialchars($success); ?></div>
            <?php endif; ?>

            <?php if ($error): ?>
                <div class="alert alert-danger">❌ <?php echo htmlspecialchars($error); ?></div>
            <?php endif; ?>

            <div class="profile-container">
                <!-- Personal Information Section -->
                <section class="profile-section">
                    <h2>Personal Information</h2>
                    <form class="profile-form" method="POST">
                        <input type="hidden" name="action" value="update_profile">
                        
                        <div class="form-group">
                            <label for="full_name">Full Name</label>
                            <input type="text" id="full_name" name="full_name" value="<?php echo htmlspecialchars($user['full_name']); ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" value="<?php echo htmlspecialchars($user['email']); ?>" disabled>
                            <small>Email cannot be changed</small>
                        </div>

                        <div class="form-group">
                            <label for="phone_number">Phone Number</label>
                            <input type="tel" id="phone_number" name="phone_number" value="<?php echo htmlspecialchars($user['phone_number']); ?>" required>
                        </div>

                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" id="address" name="address" value="<?php echo htmlspecialchars($user['address'] ?? ''); ?>">
                        </div>

                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" id="city" value="<?php echo htmlspecialchars($user['city']); ?>" disabled>
                        </div>

                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </form>
                </section>

                <!-- Account Security Section -->
                <section class="profile-section">
                    <h2>Account Security</h2>
                    <form class="profile-form" method="POST">
                        <input type="hidden" name="action" value="change_password">
                        
                        <div class="form-group">
                            <label for="current_password">Current Password</label>
                            <input type="password" id="current_password" name="current_password" placeholder="Enter current password" required>
                        </div>

                        <div class="form-group">
                            <label for="new_password">New Password</label>
                            <input type="password" id="new_password" name="new_password" placeholder="Enter new password" required>
                        </div>

                        <div class="form-group">
                            <label for="confirm_password">Confirm Password</label>
                            <input type="password" id="confirm_password" name="confirm_password" placeholder="Confirm new password" required>
                        </div>

                        <button type="submit" class="btn btn-primary">Change Password</button>
                    </form>
                </section>

                <!-- Account Activity Section -->
                <section class="profile-section">
                    <h2>Account Activity</h2>
                    <div class="activity-info">
                        <div class="activity-item">
                            <label>Account Created</label>
                            <p><?php echo date('F d, Y', strtotime($user['registration_date'])); ?></p>
                        </div>
                        <div class="activity-item">
                            <label>Last Login</label>
                            <p><?php echo $user['last_login'] ? date('F d, Y - H:i A', strtotime($user['last_login'])) : 'Never'; ?></p>
                        </div>
                        <div class="activity-item">
                            <label>Total Complaints</label>
                            <p><?php echo $stats['total']; ?> complaint(s)</p>
                        </div>
                        <div class="activity-item">
                            <label>Account Status</label>
                            <p><span class="badge <?php echo strtolower($user['account_status']); ?>"><?php echo htmlspecialchars($user['account_status']); ?></span></p>
                        </div>
                    </div>
                </section>

                <!-- Account Statistics -->
                <section class="profile-section">
                    <h2>Complaint Statistics</h2>
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-icon">📊</div>
                            <h3>Total</h3>
                            <p class="stat-number"><?php echo $stats['total']; ?></p>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">⏳</div>
                            <h3>Pending</h3>
                            <p class="stat-number"><?php echo $stats['pending']; ?></p>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">✅</div>
                            <h3>Resolved</h3>
                            <p class="stat-number"><?php echo $stats['resolved']; ?></p>
                        </div>
                    </div>
                </section>

                <!-- Action Buttons -->
                <div class="form-buttons">
                    <a href="user_dashboard.php" class="btn btn-secondary">Back to Dashboard</a>
                </div>
            </div>
        </main>
    </div>

    <footer class="footer">
        <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
    </footer>
</body>
</html>
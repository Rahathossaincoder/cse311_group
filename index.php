<?php
session_start();
require_once 'db_config.php';

// Show logout success message
$logout_success = isset($_GET['logout']) && $_GET['logout'] === 'success';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Traffic Complaint System - Home</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo">🚦 Traffic Complaint System</div>
            <ul class="nav-links">
                <li><a href="index.php" class="active">Home</a></li>
                
                <?php if (isset($_SESSION['user_id'])): ?>
                    <!-- Logged In User Navigation -->
                    <?php if ($_SESSION['is_admin']): ?>
                        <!-- Admin Navigation -->
                        <li><a href="admin_dashboard.php">Dashboard</a></li>
                        <li><a href="admin_complaints.php">Manage Complaints</a></li>
                        <li><a href="admin_reports.php">Reports</a></li>
                        <li><a href="admin_users.php">Users</a></li>
                        <li><a href="admin_settings.php">Settings</a></li>
                    <?php else: ?>
                        <!-- Citizen Navigation -->
                        <li><a href="user_dashboard.php">Dashboard</a></li>
                        <li><a href="submit_complaint.php">Submit Complaint</a></li>
                        <li><a href="my_complaints.php">My Complaints</a></li>
                        <li><a href="profile.php">Profile</a></li>
                    <?php endif; ?>
                    
                    <li style="margin-left: auto;">
                        <span style="color: white; margin-right: 15px;">
                            👤 <?php echo htmlspecialchars($_SESSION['user_name']); ?>
                        </span>
                    </li>
                    <li><a href="logout.php" class="logout">Logout</a></li>
                
                <?php else: ?>
                    <!-- Not Logged In Navigation -->
                    <li><a href="login.php">Citizen Login</a></li>
                    <li><a href="admin_login.php">👮 Admin Login</a></li>
                    <li><a href="register.php">Register</a></li>
                <?php endif; ?>
            </ul>
        </div>
    </nav>

    <!-- Success Alert -->
    <?php if ($logout_success): ?>
        <div class="alert alert-success" style="text-align: center; margin: 20px auto; max-width: 600px;">
            ✅ You have been successfully logged out!
        </div>
    <?php endif; ?>

    <!-- Hero Section -->
    <header class="hero">
        <div class="hero-content">
            <h1>Report Traffic Issues Instantly</h1>
            <p>Help improve traffic management in Bangladesh by reporting problems</p>
            <div class="hero-buttons">
                <?php if (isset($_SESSION['user_id'])): ?>
                    <a href="<?php echo $_SESSION['is_admin'] ? 'admin_dashboard.php' : 'user_dashboard.php'; ?>" class="btn btn-primary">Go to Dashboard</a>
                    <a href="logout.php" class="btn btn-secondary">Logout</a>
                <?php else: ?>
                    <a href="login.php" class="btn btn-primary">Login as Citizen</a>
                    <a href="admin_login.php" class="btn btn-secondary">👮 Admin Access</a>
                    <a href="register.php" class="btn btn-secondary">Create Account</a>
                <?php endif; ?>
            </div>
        </div>
    </header>

    <!-- Features Section -->
    <section class="features">
        <h2>Why Use Our System?</h2>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3>Easy to Use</h3>
                <p>Report issues in just a few clicks</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📍</div>
                <h3>Track Status</h3>
                <p>Get real-time updates on your complaints</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔒</div>
                <h3>Secure & Safe</h3>
                <p>Your data is fully protected</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">⭐</div>
                <h3>Make Impact</h3>
                <p>Help improve your community</p>
            </div>
        </div>
    </section>

    <!-- Complaint Categories Section -->
    <section class="categories">
        <h2>Types of Issues You Can Report</h2>
        <div class="categories-grid">
            <div class="category-box">
                <div class="category-icon">🚗</div>
                <h3>Illegal Parking</h3>
            </div>
            <div class="category-box">
                <div class="category-icon">🚦</div>
                <h3>Broken Signals</h3>
            </div>
            <div class="category-box">
                <div class="category-icon">🛣️</div>
                <h3>Road Damage</h3>
            </div>
            <div class="category-box">
                <div class="category-icon">🚧</div>
                <h3>Road Blockage</h3>
            </div>
            <div class="category-box">
                <div class="category-icon">⚠️</div>
                <h3>Accidents</h3>
            </div>
            <div class="category-box">
                <div class="category-icon">❓</div>
                <h3>Other Issues</h3>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section class="features" style="background: #f9f9f9;">
        <h2>System Statistics</h2>
        <div class="features-grid">
            <?php
            try {
                $stats = $pdo->query("SELECT 
                    (SELECT COUNT(*) FROM Complaints) as total_complaints,
                    (SELECT COUNT(*) FROM Users) as total_users,
                    (SELECT COUNT(*) FROM Complaints WHERE status_id IN (3,18,22,30,32,34,37)) as resolved_complaints
                ")->fetch();
            } catch (Exception $e) {
                $stats = ['total_complaints' => 0, 'total_users' => 0, 'resolved_complaints' => 0];
            }
            ?>
            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3>Total Complaints</h3>
                <p style="font-size: 24px; color: #667eea; font-weight: bold;">
                    <?php echo $stats['total_complaints']; ?>
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">✅</div>
                <h3>Resolved</h3>
                <p style="font-size: 24px; color: #28a745; font-weight: bold;">
                    <?php echo $stats['resolved_complaints']; ?>
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">👥</div>
                <h3>Active Citizens</h3>
                <p style="font-size: 24px; color: #17a2b8; font-weight: bold;">
                    <?php echo $stats['total_users']; ?>
                </p>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta">
        <h2>Ready to Make a Difference?</h2>
        <p>Join thousands of citizens helping improve traffic conditions</p>
        <?php if (!isset($_SESSION['user_id'])): ?>
            <a href="register.php" class="btn btn-primary">Get Started Today</a>
        <?php endif; ?>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
    </footer>
</body>
</html>
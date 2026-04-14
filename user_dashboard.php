<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['user_id']) || $_SESSION['is_admin']) {
    header("Location: login.php");
    exit();
}

// Get user statistics
$stats = $pdo->query("SELECT 
    (SELECT COUNT(*) FROM Complaints WHERE user_id = {$_SESSION['user_id']}) as total,
    (SELECT COUNT(*) FROM Complaints WHERE user_id = {$_SESSION['user_id']} AND status_id IN (3,22,34,37)) as resolved,
    (SELECT COUNT(*) FROM Complaints WHERE user_id = {$_SESSION['user_id']} AND status_id IN (1,11)) as pending,
    (SELECT COUNT(*) FROM Complaints WHERE user_id = {$_SESSION['user_id']} AND status_id IN (2,8,13,18)) as progress
")->fetch();

// Get recent complaints
$stmt = $pdo->prepare("
    SELECT c.complaint_id, c.description, cat.category_name, c.submission_date, s.status_name, 
           c.priority_level, l.area, l.city
    FROM Complaints c
    JOIN Complaint_Categories cat ON c.category_id = cat.category_id
    JOIN Complaint_Status s ON c.status_id = s.status_id
    LEFT JOIN Locations l ON c.location_id = l.location_id
    WHERE c.user_id = ?
    ORDER BY c.submission_date DESC
    LIMIT 5
");
$stmt->execute([$_SESSION['user_id']]);
$recent_complaints = $stmt->fetchAll();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Smart Traffic System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo">🚦 Traffic Complaint System</div>
            <ul class="nav-links">
                <li><a href="user_dashboard.php" class="active">Dashboard</a></li>
                <li><a href="submit_complaint.php">Submit Complaint</a></li>
                <li><a href="my_complaints.php">My Complaints</a></li>
                <li><a href="profile.php">Profile</a></li>
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
                <h3><?php echo htmlspecialchars($_SESSION['user_name']); ?></h3>
                <p><?php 
                    $user = $pdo->query("SELECT email FROM Users WHERE user_id = {$_SESSION['user_id']}")->fetch();
                    echo htmlspecialchars($user['email']);
                ?></p>
            </div>
            <ul class="menu">
                <li><a href="user_dashboard.php" class="active">Dashboard</a></li>
                <li><a href="submit_complaint.php">Submit Complaint</a></li>
                <li><a href="my_complaints.php">My Complaints</a></li>
                <li><a href="profile.php">Profile</a></li>
                <li><a href="logout.php">Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <h1>Welcome, <?php echo htmlspecialchars($_SESSION['user_name']); ?>!</h1>

            <!-- Statistics -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">📊</div>
                    <h3>Total Complaints</h3>
                    <p class="stat-number"><?php echo $stats['total']; ?></p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">⏳</div>
                    <h3>Pending</h3>
                    <p class="stat-number"><?php echo $stats['pending']; ?></p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">⚙️</div>
                    <h3>In Progress</h3>
                    <p class="stat-number"><?php echo $stats['progress']; ?></p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">✅</div>
                    <h3>Resolved</h3>
                    <p class="stat-number"><?php echo $stats['resolved']; ?></p>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h2>Quick Actions</h2>
                <div class="actions-grid">
                    <a href="submit_complaint.php" class="action-card">
                        <div class="action-icon">➕</div>
                        <h3>Submit Complaint</h3>
                    </a>
                    <a href="my_complaints.php" class="action-card">
                        <div class="action-icon">📋</div>
                        <h3>View Complaints</h3>
                    </a>
                    <a href="profile.php" class="action-card">
                        <div class="action-icon">⚙️</div>
                        <h3>Settings</h3>
                    </a>
                </div>
            </div>

            <!-- Recent Complaints -->
            <div class="recent-section">
                <h2>Recent Complaints</h2>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Category</th>
                            <th>Location</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($recent_complaints as $complaint): ?>
                        <tr>
                            <td>#<?php echo $complaint['complaint_id']; ?></td>
                            <td><?php echo htmlspecialchars($complaint['category_name']); ?></td>
                            <td><?php echo htmlspecialchars($complaint['area'] . ', ' . $complaint['city']); ?></td>
                            <td><?php echo date('Y-m-d', strtotime($complaint['submission_date'])); ?></td>
                            <td><span class="badge <?php echo strtolower(str_replace(' ', '-', $complaint['status_name'])); ?>"><?php echo htmlspecialchars($complaint['status_name']); ?></span></td>
                            <td><a href="complaint_detail.php?id=<?php echo $complaint['complaint_id']; ?>" class="link">View</a></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
                <a href="my_complaints.php" class="btn btn-secondary mt">View All Complaints</a>
            </div>
        </main>
    </div>

    <footer class="footer">
        <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
    </footer>
</body>
</html>
<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['is_admin']) || $_SESSION['is_admin'] !== true) {
    header("Location: login.php");
    exit();
}

// Get statistics
$stats = $pdo->query("SELECT 
    (SELECT COUNT(*) FROM Complaints) as total,
    (SELECT COUNT(*) FROM Complaints WHERE status_id IN (1,11)) as pending,
    (SELECT COUNT(*) FROM Complaints WHERE status_id IN (2,6,8,12,13,24,27)) as progress,
    (SELECT COUNT(*) FROM Complaints WHERE status_id IN (3,18,22,30,32,34,37)) as resolved,
    (SELECT COUNT(*) FROM Users) as total_users,
    (SELECT COUNT(*) FROM Admins) as total_admins
")->fetch();

// Get recent complaints
$recent = $pdo->prepare("
    SELECT c.complaint_id, c.description, cat.category_name, c.submission_date, s.status_name, 
           c.priority_level, u.full_name, l.area
    FROM Complaints c
    JOIN Users u ON c.user_id = u.user_id
    JOIN Complaint_Categories cat ON c.category_id = cat.category_id
    JOIN Complaint_Status s ON c.status_id = s.status_id
    LEFT JOIN Locations l ON c.location_id = l.location_id
    ORDER BY c.submission_date DESC
    LIMIT 8
");
$recent->execute();
$recent_complaints = $recent->fetchAll();

// Get category distribution
$categories = $pdo->query("
    SELECT cat.category_name, COUNT(c.complaint_id) as count
    FROM Complaint_Categories cat
    LEFT JOIN Complaints c ON cat.category_id = c.category_id
    GROUP BY cat.category_id
    ORDER BY count DESC
    LIMIT 5
")->fetchAll();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Traffic Complaint System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar admin-nav">
        <div class="nav-container">
            <div class="logo">👮 Admin Panel - Traffic System</div>
            <ul class="nav-links">
                <li><a href="admin_dashboard.php" class="active">Dashboard</a></li>
                <li><a href="admin_complaints.php">Manage Complaints</a></li>
                <li><a href="admin_reports.php">Reports</a></li>
                <li><a href="admin_users.php">Users</a></li>
                <li><a href="admin_settings.php">Settings</a></li>
                <li><a href="logout.php" class="logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Dashboard Container -->
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar admin-sidebar">
            <div class="profile">
                <div class="avatar">👨‍💼</div>
                <h3><?php echo htmlspecialchars($_SESSION['user_name']); ?></h3>
                <p><?php 
                    $admin = $pdo->query("SELECT email FROM Admins WHERE admin_id = {$_SESSION['user_id']}")->fetch();
                    echo htmlspecialchars($admin['email']);
                ?></p>
            </div>
            <ul class="menu">
                <li><a href="admin_dashboard.php" class="active">Dashboard</a></li>
                <li><a href="admin_complaints.php">Manage Complaints</a></li>
                <li><a href="admin_reports.php">Reports & Analytics</a></li>
                <li><a href="admin_users.php">User Management</a></li>
                <li><a href="admin_settings.php">Settings</a></li>
                <li><a href="logout.php">Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <h1>Admin Dashboard</h1>
            <p class="subtitle">Traffic Complaint Management System</p>

            <!-- Statistics -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">📊</div>
                    <h3>Total Complaints</h3>
                    <p class="stat-number"><?php echo $stats['total']; ?></p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">⏳</div>
                    <h3>Pending Review</h3>
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
                <div class="stat-card">
                    <div class="stat-icon">👥</div>
                    <h3>Total Users</h3>
                    <p class="stat-number"><?php echo $stats['total_users']; ?></p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">👮</div>
                    <h3>Total Admins</h3>
                    <p class="stat-number"><?php echo $stats['total_admins']; ?></p>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h2>Quick Actions</h2>
                <div class="actions-grid">
                    <a href="admin_complaints.php" class="action-card">
                        <div class="action-icon">📋</div>
                        <h3>Review Complaints</h3>
                    </a>
                    <a href="admin_complaints.php?status=Pending" class="action-card">
                        <div class="action-icon">⏳</div>
                        <h3>Pending (<?php echo $stats['pending']; ?>)</h3>
                    </a>
                    <a href="admin_reports.php" class="action-card">
                        <div class="action-icon">📊</div>
                        <h3>View Reports</h3>
                    </a>
                    <a href="admin_users.php" class="action-card">
                        <div class="action-icon">👥</div>
                        <h3>Manage Users</h3>
                    </a>
                </div>
            </div>

            <!-- Recent Complaints -->
            <div class="recent-section">
                <h2>Recent Complaints to Review</h2>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Category</th>
                            <th>Submitted By</th>
                            <th>Location</th>
                            <th>Date</th>
                            <th>Priority</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($recent_complaints as $c): ?>
                        <tr>
                            <td>#<?php echo $c['complaint_id']; ?></td>
                            <td><?php echo htmlspecialchars($c['category_name']); ?></td>
                            <td><?php echo htmlspecialchars($c['full_name']); ?></td>
                            <td><?php echo htmlspecialchars($c['area']); ?></td>
                            <td><?php echo date('Y-m-d', strtotime($c['submission_date'])); ?></td>
                            <td><span class="priority-badge <?php echo strtolower($c['priority_level']); ?>"><?php echo htmlspecialchars($c['priority_level']); ?></span></td>
                            <td><span class="badge <?php echo strtolower(str_replace(' ', '-', $c['status_name'])); ?>"><?php echo htmlspecialchars($c['status_name']); ?></span></td>
                            <td><a href="admin_complaint_detail.php?id=<?php echo $c['complaint_id']; ?>" class="link">Review</a></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
                <a href="admin_complaints.php" class="btn btn-secondary mt">View All Complaints</a>
            </div>

            <!-- Category Distribution -->
            <div class="report-section">
                <h2>Top Complaint Categories</h2>
                <div class="chart-bars">
                    <?php foreach ($categories as $cat): 
                        $percentage = $stats['total'] > 0 ? round(($cat['count'] / $stats['total']) * 100) : 0;
                    ?>
                    <div class="bar-item">
                        <p class="bar-label"><?php echo htmlspecialchars($cat['category_name']); ?></p>
                        <div class="bar-container">
                            <div class="bar" style="width: <?php echo $percentage; ?>%;"></div>
                        </div>
                        <p class="bar-value"><?php echo $cat['count']; ?> (<?php echo $percentage; ?>%)</p>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </main>
    </div>

    <footer class="footer">
        <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
    </footer>
</body>
</html>
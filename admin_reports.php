<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['is_admin']) || $_SESSION['is_admin'] !== true) {
    header("Location: admin_login.php");
    exit();
}

// Overall stats
$stats = $pdo->query("
    SELECT
      (SELECT COUNT(*) FROM Complaints) AS total,
      (SELECT COUNT(*) FROM Complaints c JOIN Complaint_Status s ON c.status_id=s.status_id WHERE s.status_name LIKE '%Pending%') AS pending,
      (SELECT COUNT(*) FROM Complaints c JOIN Complaint_Status s ON c.status_id=s.status_id WHERE s.status_name LIKE '%Progress%') AS progress,
      (SELECT COUNT(*) FROM Complaints c JOIN Complaint_Status s ON c.status_id=s.status_id WHERE s.status_name LIKE '%Solved%' OR s.status_name LIKE '%Resolved%') AS resolved
")->fetch();

// Complaints by category
$byCategory = $pdo->query("
    SELECT cat.category_name, COUNT(c.complaint_id) AS cnt
    FROM Complaint_Categories cat
    LEFT JOIN Complaints c ON c.category_id = cat.category_id
    GROUP BY cat.category_id, cat.category_name
    ORDER BY cnt DESC
")->fetchAll();

// Top locations (by area + road)
$topLocations = $pdo->query("
    SELECT CONCAT(l.road_name, ' - ', l.area, ', ', l.city) AS location_name,
           COUNT(c.complaint_id) AS cnt
    FROM Complaints c
    JOIN Locations l ON c.location_id = l.location_id
    GROUP BY location_name
    ORDER BY cnt DESC
    LIMIT 10
")->fetchAll();
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Reports & Analytics - Admin</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <nav class="navbar admin-nav">
    <div class="nav-container">
      <div class="logo">👮 Admin Panel - Traffic System</div>
      <ul class="nav-links">
        <li><a href="admin_dashboard.php">Dashboard</a></li>
        <li><a href="admin_complaints.php">Manage Complaints</a></li>
        <li><a href="admin_reports.php" class="active">Reports</a></li>
        <li><a href="admin_users.php">Users</a></li>
        <li><a href="logout.php" class="logout">Logout</a></li>
      </ul>
    </div>
  </nav>

  <div class="page-container">
    <h1>Reports & Analytics</h1>

    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-icon">📊</div>
        <h3>Total Complaints</h3>
        <p class="stat-number"><?php echo (int)$stats['total']; ?></p>
      </div>
      <div class="stat-card">
        <div class="stat-icon">⏳</div>
        <h3>Pending</h3>
        <p class="stat-number"><?php echo (int)$stats['pending']; ?></p>
      </div>
      <div class="stat-card">
        <div class="stat-icon">⚙️</div>
        <h3>In Progress</h3>
        <p class="stat-number"><?php echo (int)$stats['progress']; ?></p>
      </div>
      <div class="stat-card">
        <div class="stat-icon">✅</div>
        <h3>Resolved</h3>
        <p class="stat-number"><?php echo (int)$stats['resolved']; ?></p>
      </div>
    </div>

    <div class="report-section">
      <h2>Complaints by Category</h2>
      <div class="chart-bars">
        <?php foreach ($byCategory as $row):
          $pct = ((int)$stats['total'] > 0) ? round(($row['cnt'] / $stats['total']) * 100) : 0;
        ?>
          <div class="bar-item">
            <p class="bar-label"><?php echo htmlspecialchars($row['category_name']); ?></p>
            <div class="bar-container">
              <div class="bar" style="width: <?php echo $pct; ?>%;"></div>
            </div>
            <p class="bar-value"><?php echo (int)$row['cnt']; ?> (<?php echo $pct; ?>%)</p>
          </div>
        <?php endforeach; ?>
      </div>
    </div>

    <div class="report-section">
      <h2>Top Complaint Locations</h2>
      <table class="data-table">
        <thead>
          <tr>
            <th>Location</th>
            <th>Complaints</th>
          </tr>
        </thead>
        <tbody>
          <?php if (!$topLocations): ?>
            <tr><td colspan="2">No location data found.</td></tr>
          <?php else: ?>
            <?php foreach ($topLocations as $loc): ?>
              <tr>
                <td><?php echo htmlspecialchars($loc['location_name']); ?></td>
                <td><?php echo (int)$loc['cnt']; ?></td>
              </tr>
            <?php endforeach; ?>
          <?php endif; ?>
        </tbody>
      </table>
    </div>

  </div>

  <footer class="footer">
    <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
  </footer>
</body>
</html>
<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['is_admin']) || $_SESSION['is_admin'] !== true) {
    header("Location: admin_login.php");
    exit();
}

$status = $_GET['status'] ?? '';   // Active / Inactive / Suspended (if you use these)
$city   = $_GET['city'] ?? '';
$q      = trim($_GET['q'] ?? '');

$where = "WHERE 1=1";
$params = [];

if ($status !== '') {
    $where .= " AND account_status = ?";
    $params[] = $status;
}
if ($city !== '') {
    $where .= " AND city = ?";
    $params[] = $city;
}
if ($q !== '') {
    $where .= " AND (full_name LIKE ? OR email LIKE ? OR phone_number LIKE ?)";
    $params[] = "%$q%";
    $params[] = "%$q%";
    $params[] = "%$q%";
}

$sql = "
    SELECT u.user_id, u.full_name, u.email, u.phone_number, u.city, u.account_status,
           (SELECT COUNT(*) FROM Complaints c WHERE c.user_id = u.user_id) AS complaints_count
    FROM Users u
    $where
    ORDER BY u.user_id DESC
    LIMIT 200
";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$users = $stmt->fetchAll();

// for filter dropdowns
$cities = $pdo->query("SELECT DISTINCT city FROM Users WHERE city IS NOT NULL AND city <> '' ORDER BY city")->fetchAll(PDO::FETCH_COLUMN);
$statuses = $pdo->query("SELECT DISTINCT account_status FROM Users WHERE account_status IS NOT NULL AND account_status <> '' ORDER BY account_status")->fetchAll(PDO::FETCH_COLUMN);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Management - Admin</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <nav class="navbar admin-nav">
    <div class="nav-container">
      <div class="logo">👮 Admin Panel - Traffic System</div>
      <ul class="nav-links">
        <li><a href="admin_dashboard.php">Dashboard</a></li>
        <li><a href="admin_complaints.php">Manage Complaints</a></li>
        <li><a href="admin_reports.php">Reports</a></li>
        <li><a href="admin_users.php" class="active">Users</a></li>
        <li><a href="logout.php" class="logout">Logout</a></li>
      </ul>
    </div>
  </nav>

  <div class="page-container">
    <h1>User Management</h1>

    <form method="GET" class="filters" style="align-items:center;">
      <input type="text" name="q" value="<?php echo htmlspecialchars($q); ?>"
             placeholder="Search name/email/phone"
             style="padding:10px;border:1px solid #ddd;border-radius:5px;min-width:260px;">

      <select name="status" onchange="this.form.submit()">
        <option value="">All Status</option>
        <?php foreach ($statuses as $st): ?>
          <option value="<?php echo htmlspecialchars($st); ?>" <?php echo ($status===$st)?'selected':''; ?>>
            <?php echo htmlspecialchars($st); ?>
          </option>
        <?php endforeach; ?>
      </select>

      <select name="city" onchange="this.form.submit()">
        <option value="">All Cities</option>
        <?php foreach ($cities as $c): ?>
          <option value="<?php echo htmlspecialchars($c); ?>" <?php echo ($city===$c)?'selected':''; ?>>
            <?php echo htmlspecialchars($c); ?>
          </option>
        <?php endforeach; ?>
      </select>

      <button class="btn btn-primary" type="submit">Filter</button>
      <a class="btn btn-secondary" href="admin_users.php">Reset</a>
    </form>

    <table class="data-table">
      <thead>
        <tr>
          <th>User ID</th>
          <th>Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>City</th>
          <th>Complaints</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <?php if (!$users): ?>
          <tr><td colspan="7">No users found.</td></tr>
        <?php else: ?>
          <?php foreach ($users as $u): ?>
            <tr>
              <td>#<?php echo (int)$u['user_id']; ?></td>
              <td><?php echo htmlspecialchars($u['full_name']); ?></td>
              <td><?php echo htmlspecialchars($u['email']); ?></td>
              <td><?php echo htmlspecialchars($u['phone_number']); ?></td>
              <td><?php echo htmlspecialchars($u['city']); ?></td>
              <td><?php echo (int)$u['complaints_count']; ?></td>
              <td>
                <span class="badge <?php echo strtolower(htmlspecialchars($u['account_status'] ?? 'active')); ?>">
                  <?php echo htmlspecialchars($u['account_status'] ?? 'Active'); ?>
                </span>
              </td>
            </tr>
          <?php endforeach; ?>
        <?php endif; ?>
      </tbody>
    </table>
  </div>

  <footer class="footer">
    <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
  </footer>
</body>
</html>
<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['is_admin']) || $_SESSION['is_admin'] !== true) {
    header("Location: login.php");
    exit();
}

// Pagination
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$perPage = 15;
$offset = ($page - 1) * $perPage;

// Filters
$status_filter = isset($_GET['status']) ? $_GET['status'] : '';
$category_filter = isset($_GET['category']) ? $_GET['category'] : '';
$priority_filter = isset($_GET['priority']) ? $_GET['priority'] : '';
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

// Build where clause
$where = "WHERE 1=1";
$params = [];

if ($status_filter) {
    $where .= " AND s.status_name LIKE ?";
    $params[] = "%$status_filter%";
}

if ($category_filter) {
    $where .= " AND c.category_id = ?";
    $params[] = $category_filter;
}

if ($priority_filter) {
    $where .= " AND c.priority_level = ?";
    $params[] = $priority_filter;
}

if ($search) {
    $where .= " AND (c.description LIKE ? OR u.full_name LIKE ? OR l.area LIKE ?)";
    $params[] = "%$search%";
    $params[] = "%$search%";
    $params[] = "%$search%";
}

// Count total
$countStmt = $pdo->prepare("SELECT COUNT(*) as total FROM Complaints c 
                            JOIN Complaint_Status s ON c.status_id = s.status_id
                            JOIN Users u ON c.user_id = u.user_id
                            JOIN Locations l ON c.location_id = l.location_id
                            $where");
$countStmt->execute($params);
$total = $countStmt->fetch()['total'];
$totalPages = ceil($total / $perPage);

// Fetch complaints
$stmt = $pdo->prepare("
    SELECT c.complaint_id, c.description, cat.category_name, c.submission_date, s.status_name, 
           c.priority_level, u.full_name, l.area, l.city
    FROM Complaints c
    JOIN Complaint_Categories cat ON c.category_id = cat.category_id
    JOIN Complaint_Status s ON c.status_id = s.status_id
    JOIN Users u ON c.user_id = u.user_id
    JOIN Locations l ON c.location_id = l.location_id
    $where
    ORDER BY c.submission_date DESC
    LIMIT ? OFFSET ?
");
$stmt->execute(array_merge($params, [$perPage, $offset]));
$complaints = $stmt->fetchAll();

// Get filter options
$categories = $pdo->query("SELECT category_id, category_name FROM Complaint_Categories ORDER BY category_name")->fetchAll();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Complaints - Traffic Complaint System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar admin-nav">
        <div class="nav-container">
            <div class="logo">👮 Admin Panel - Traffic System</div>
            <ul class="nav-links">
                <li><a href="admin_dashboard.php">Dashboard</a></li>
                <li><a href="admin_complaints.php" class="active">Manage Complaints</a></li>
                <li><a href="admin_reports.php">Reports</a></li>
                <li><a href="admin_users.php">Users</a></li>
                <li><a href="logout.php" class="logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Page Container -->
    <div class="page-container">
        <h1>Manage Complaints</h1>

        <!-- Search and Filters -->
        <form class="search-filters" method="GET">
            <div style="display: flex; gap: 10px; margin-bottom: 20px;">
                <input type="text" name="search" placeholder="Search complaints..." value="<?php echo htmlspecialchars($search); ?>" style="flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 5px;">
                <button type="submit" class="btn btn-primary">Search</button>
            </div>

            <div class="filters">
                <select name="status" onchange="this.form.submit()">
                    <option value="">All Status</option>
                    <option value="Pending" <?php echo $status_filter === 'Pending' ? 'selected' : ''; ?>>Pending</option>
                    <option value="Progress" <?php echo $status_filter === 'Progress' ? 'selected' : ''; ?>>In Progress</option>
                    <option value="Resolved" <?php echo $status_filter === 'Resolved' ? 'selected' : ''; ?>>Resolved</option>
                </select>
                <select name="category" onchange="this.form.submit()">
                    <option value="">All Categories</option>
                    <?php foreach ($categories as $cat): ?>
                        <option value="<?php echo $cat['category_id']; ?>" <?php echo $category_filter == $cat['category_id'] ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($cat['category_name']); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
                <select name="priority" onchange="this.form.submit()">
                    <option value="">All Priorities</option>
                    <option value="Low" <?php echo $priority_filter === 'Low' ? 'selected' : ''; ?>>Low</option>
                    <option value="Medium" <?php echo $priority_filter === 'Medium' ? 'selected' : ''; ?>>Medium</option>
                    <option value="High" <?php echo $priority_filter === 'High' ? 'selected' : ''; ?>>High</option>
                    <option value="Critical" <?php echo $priority_filter === 'Critical' ? 'selected' : ''; ?>>Critical</option>
                </select>
            </div>
        </form>

        <!-- Complaints Table -->
        <?php if (empty($complaints)): ?>
            <div class="alert alert-info">No complaints found.</div>
        <?php else: ?>
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
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($complaints as $c): ?>
                    <tr>
                        <td>#<?php echo $c['complaint_id']; ?></td>
                        <td><?php echo htmlspecialchars($c['category_name']); ?></td>
                        <td><?php echo htmlspecialchars($c['full_name']); ?></td>
                        <td><?php echo htmlspecialchars($c['area'] . ', ' . $c['city']); ?></td>
                        <td><?php echo date('Y-m-d', strtotime($c['submission_date'])); ?></td>
                        <td><span class="priority-badge <?php echo strtolower($c['priority_level']); ?>"><?php echo htmlspecialchars($c['priority_level']); ?></span></td>
                        <td><span class="badge <?php echo strtolower(str_replace(' ', '-', $c['status_name'])); ?>"><?php echo htmlspecialchars($c['status_name']); ?></span></td>
                        <td>
                            <a href="admin_complaint_detail.php?id=<?php echo $c['complaint_id']; ?>" class="action-link">Review</a>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>

            <!-- Pagination -->
            <?php if ($totalPages > 1): ?>
            <div class="pagination" style="text-align: center; margin-top: 20px;">
                <?php if ($page > 1): ?>
                    <a href="admin_complaints.php?page=1" class="btn btn-secondary">First</a>
                    <a href="admin_complaints.php?page=<?php echo $page - 1; ?>" class="btn btn-secondary">Previous</a>
                <?php endif; ?>
                
                <span>Page <?php echo $page; ?> of <?php echo $totalPages; ?></span>
                
                <?php if ($page < $totalPages): ?>
                    <a href="admin_complaints.php?page=<?php echo $page + 1; ?>" class="btn btn-secondary">Next</a>
                    <a href="admin_complaints.php?page=<?php echo $totalPages; ?>" class="btn btn-secondary">Last</a>
                <?php endif; ?>
            </div>
            <?php endif; ?>
        <?php endif; ?>
    </div>

    <footer class="footer">
        <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
    </footer>
</body>
</html>
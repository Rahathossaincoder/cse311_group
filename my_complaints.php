<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['user_id']) || $_SESSION['is_admin']) {
    header("Location: login.php");
    exit();
}

// Pagination
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$perPage = 10;
$offset = ($page - 1) * $perPage;

// Filter parameters
$status_filter = isset($_GET['status']) ? $_GET['status'] : '';
$category_filter = isset($_GET['category']) ? $_GET['category'] : '';
$search = isset($_GET['search']) ? trim($_GET['search']) : '';

// Build query
$where = "WHERE c.user_id = {$_SESSION['user_id']}";
$params = [];

if ($status_filter) {
    $where .= " AND s.status_name LIKE ?";
    $params[] = "%$status_filter%";
}

if ($category_filter) {
    $where .= " AND c.category_id = ?";
    $params[] = $category_filter;
}

if ($search) {
    $where .= " AND (c.description LIKE ? OR l.area LIKE ?)";
    $params[] = "%$search%";
    $params[] = "%$search%";
}

// Count total
$countStmt = $pdo->prepare("SELECT COUNT(*) as total FROM Complaints c 
                            JOIN Complaint_Status s ON c.status_id = s.status_id
                            JOIN Locations l ON c.location_id = l.location_id
                            $where");
$countStmt->execute($params);
$total = $countStmt->fetch()['total'];
$totalPages = ceil($total / $perPage);

// Fetch complaints
$stmt = $pdo->prepare("
    SELECT c.complaint_id, c.description, cat.category_name, c.submission_date, s.status_name, 
           c.priority_level, l.area, l.city
    FROM Complaints c
    JOIN Complaint_Categories cat ON c.category_id = cat.category_id
    JOIN Complaint_Status s ON c.status_id = s.status_id
    JOIN Locations l ON c.location_id = l.location_id
    $where
    ORDER BY c.submission_date DESC
    LIMIT ? OFFSET ?
");
$stmt->execute(array_merge($params, [$perPage, $offset]));
$complaints = $stmt->fetchAll();

// Get categories for filter
$categories = $pdo->query("SELECT category_id, category_name FROM Complaint_Categories ORDER BY category_name")->fetchAll();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Complaints - Traffic Complaint System</title>
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
                <li><a href="my_complaints.php" class="active">My Complaints</a></li>
                <li><a href="profile.php">Profile</a></li>
                <li><a href="logout.php" class="logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Page Container -->
    <div class="page-container">
        <h1>My Complaints</h1>

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
            </div>
        </form>

        <!-- Complaints Table -->
        <?php if (empty($complaints)): ?>
            <div class="alert alert-info">No complaints found. <a href="submit_complaint.php">Submit a new one</a></div>
        <?php else: ?>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category</th>
                        <th>Location</th>
                        <th>Submitted</th>
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
                        <td><?php echo htmlspecialchars($c['area'] . ', ' . $c['city']); ?></td>
                        <td><?php echo date('Y-m-d', strtotime($c['submission_date'])); ?></td>
                        <td><span class="priority-badge <?php echo strtolower($c['priority_level']); ?>"><?php echo htmlspecialchars($c['priority_level']); ?></span></td>
                        <td><span class="badge <?php echo strtolower(str_replace(' ', '-', $c['status_name'])); ?>"><?php echo htmlspecialchars($c['status_name']); ?></span></td>
                        <td><a href="complaint_detail.php?id=<?php echo $c['complaint_id']; ?>" class="link">View</a></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>

            <!-- Pagination -->
            <?php if ($totalPages > 1): ?>
            <div class="pagination" style="text-align: center; margin-top: 20px;">
                <?php if ($page > 1): ?>
                    <a href="my_complaints.php?page=1<?php echo $status_filter ? '&status=' . urlencode($status_filter) : ''; ?><?php echo $category_filter ? '&category=' . urlencode($category_filter) : ''; ?>" class="btn btn-secondary">First</a>
                    <a href="my_complaints.php?page=<?php echo $page - 1; ?><?php echo $status_filter ? '&status=' . urlencode($status_filter) : ''; ?><?php echo $category_filter ? '&category=' . urlencode($category_filter) : ''; ?>" class="btn btn-secondary">Previous</a>
                <?php endif; ?>
                
                <span>Page <?php echo $page; ?> of <?php echo $totalPages; ?></span>
                
                <?php if ($page < $totalPages): ?>
                    <a href="my_complaints.php?page=<?php echo $page + 1; ?><?php echo $status_filter ? '&status=' . urlencode($status_filter) : ''; ?><?php echo $category_filter ? '&category=' . urlencode($category_filter) : ''; ?>" class="btn btn-secondary">Next</a>
                    <a href="my_complaints.php?page=<?php echo $totalPages; ?><?php echo $status_filter ? '&status=' . urlencode($status_filter) : ''; ?><?php echo $category_filter ? '&category=' . urlencode($category_filter) : ''; ?>" class="btn btn-secondary">Last</a>
                <?php endif; ?>
            </div>
            <?php endif; ?>
        <?php endif; ?>

        <a href="submit_complaint.php" class="btn btn-primary mt">Submit New Complaint</a>
    </div>

    <footer class="footer">
        <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
    </footer>
</body>
</html>
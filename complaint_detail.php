<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

$complaint_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Get complaint details
$stmt = $pdo->prepare("
    SELECT c.*, u.full_name, u.email, u.phone_number, cat.category_name, 
           s.status_name, l.road_name, l.area, l.city, l.landmark
    FROM Complaints c
    JOIN Users u ON c.user_id = u.user_id
    JOIN Complaint_Categories cat ON c.category_id = cat.category_id
    JOIN Complaint_Status s ON c.status_id = s.status_id
    JOIN Locations l ON c.location_id = l.location_id
    WHERE c.complaint_id = ?
");
$stmt->execute([$complaint_id]);
$complaint = $stmt->fetch();

if (!$complaint) {
    die("Complaint not found!");
}

// Check permission
if (!$_SESSION['is_admin'] && $complaint['user_id'] != $_SESSION['user_id']) {
    die("You don't have permission to view this complaint!");
}

// Get attachments
$attachments = $pdo->prepare("SELECT * FROM Attachments WHERE complaint_id = ? ORDER BY upload_date DESC");
$attachments->execute([$complaint_id]);
$attachments = $attachments->fetchAll();

// Get history
$history = $pdo->prepare("SELECT * FROM Complaint_History WHERE complaint_id = ? ORDER BY change_date DESC");
$history->execute([$complaint_id]);
$history = $history->fetchAll();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint #<?php echo $complaint_id; ?> - Traffic Complaint System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo">🚦 Traffic Complaint System</div>
            <ul class="nav-links">
                <li><a href="<?php echo $_SESSION['is_admin'] ? 'admin_dashboard.php' : 'user_dashboard.php'; ?>">Dashboard</a></li>
                <li><a href="<?php echo $_SESSION['is_admin'] ? 'admin_complaints.php' : 'my_complaints.php'; ?>">Complaints</a></li>
                <li><a href="logout.php" class="logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Page Container -->
    <div class="page-container">
        <a href="<?php echo $_SESSION['is_admin'] ? 'admin_complaints.php' : 'my_complaints.php'; ?>" class="back-link">← Back to Complaints</a>

        <div class="detail-card">
            <div class="detail-header">
                <h1>Complaint #<?php echo $complaint['complaint_id']; ?></h1>
                <span class="badge <?php echo strtolower(str_replace(' ', '-', $complaint['status_name'])); ?>"><?php echo htmlspecialchars($complaint['status_name']); ?></span>
            </div>

            <div class="detail-grid">
                <div class="detail-col">
                    <section class="detail-section">
                        <h2>Complaint Information</h2>
                        <div class="detail-item">
                            <label>Category</label>
                            <p><?php echo htmlspecialchars($complaint['category_name']); ?></p>
                        </div>
                        <div class="detail-item">
                            <label>Priority</label>
                            <p><span class="priority-badge <?php echo strtolower($complaint['priority_level']); ?>"><?php echo htmlspecialchars($complaint['priority_level']); ?></span></p>
                        </div>
                        <div class="detail-item">
                            <label>Date Submitted</label>
                            <p><?php echo date('F d, Y', strtotime($complaint['submission_date'])); ?></p>
                        </div>
                        <div class="detail-item">
                            <label>Current Status</label>
                            <p><span class="badge <?php echo strtolower(str_replace(' ', '-', $complaint['status_name'])); ?>"><?php echo htmlspecialchars($complaint['status_name']); ?></span></p>
                        </div>
                    </section>

                    <section class="detail-section">
                        <h2>Location</h2>
                        <div class="detail-item">
                            <label>Road</label>
                            <p><?php echo htmlspecialchars($complaint['road_name']); ?></p>
                        </div>
                        <div class="detail-item">
                            <label>Area</label>
                            <p><?php echo htmlspecialchars($complaint['area'] . ', ' . $complaint['city']); ?></p>
                        </div>
                        <?php if ($complaint['landmark']): ?>
                        <div class="detail-item">
                            <label>Landmark</label>
                            <p><?php echo htmlspecialchars($complaint['landmark']); ?></p>
                        </div>
                        <?php endif; ?>
                    </section>
                </div>

                <div class="detail-col">
                    <section class="detail-section">
                        <h2>Complainant Information</h2>
                        <div class="detail-item">
                            <label>Name</label>
                            <p><?php echo htmlspecialchars($complaint['full_name']); ?></p>
                        </div>
                        <div class="detail-item">
                            <label>Email</label>
                            <p><?php echo htmlspecialchars($complaint['email']); ?></p>
                        </div>
                        <div class="detail-item">
                            <label>Phone</label>
                            <p><?php echo htmlspecialchars($complaint['phone_number']); ?></p>
                        </div>
                    </section>

                    <?php if ($_SESSION['is_admin']): ?>
                    <section class="detail-section">
                        <h2>Admin Actions</h2>
                        <form action="update_complaint_status.php" method="POST">
                            <input type="hidden" name="complaint_id" value="<?php echo $complaint_id; ?>">
                            <div class="form-group">
                                <label for="newStatus">Change Status</label>
                                <select id="newStatus" name="new_status_id" required>
                                    <option value="">-- Select Status --</option>
                                    <?php 
                                    $statuses = $pdo->query("SELECT status_id, status_name FROM Complaint_Status")->fetchAll();
                                    foreach ($statuses as $st):
                                    ?>
                                        <option value="<?php echo $st['status_id']; ?>" <?php echo $st['status_id'] == $complaint['status_id'] ? 'selected' : ''; ?>>
                                            <?php echo htmlspecialchars($st['status_name']); ?>
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="notes">Resolution Notes</label>
                                <textarea id="notes" name="resolution_note" rows="3" placeholder="Add notes..."><?php echo htmlspecialchars($complaint['resolution_note'] ?? ''); ?></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary" style="width: 100%;">Update Status</button>
                        </form>
                    </section>
                    <?php endif; ?>
                </div>
            </div>

            <section class="detail-section full-width">
                <h2>Description</h2>
                <p><?php echo htmlspecialchars($complaint['description']); ?></p>
            </section>

            <?php if (!empty($attachments)): ?>
            <section class="detail-section full-width">
                <h2>Attachments</h2>
                <div class="attachments-list">
                    <?php foreach ($attachments as $att): ?>
                    <div class="attachment-item">
                        <p>📎 <a href="<?php echo htmlspecialchars($att['file_path']); ?>" download><?php echo htmlspecialchars($att['file_name']); ?></a></p>
                        <small>Size: <?php echo round($att['file_size'] / 1024, 2); ?> KB | Uploaded: <?php echo date('Y-m-d H:i', strtotime($att['upload_date'])); ?></small>
                    </div>
                    <?php endforeach; ?>
                </div>
            </section>
            <?php endif; ?>

            <?php if (!empty($history)): ?>
            <section class="detail-section full-width">
                <h2>Complaint History</h2>
                <div class="history">
                    <?php foreach ($history as $h): ?>
                    <div class="history-item">
                        <p class="history-title">Status Changed: <?php echo htmlspecialchars($h['old_status']); ?> → <?php echo htmlspecialchars($h['new_status']); ?></p>
                        <p class="history-info">By: <?php echo htmlspecialchars($h['changed_by']); ?> | <?php echo date('Y-m-d H:i', strtotime($h['change_date'])); ?></p>
                        <?php if ($h['remarks']): ?>
                        <p class="history-note"><?php echo htmlspecialchars($h['remarks']); ?></p>
                        <?php endif; ?>
                    </div>
                    <?php endforeach; ?>
                </div>
            </section>
            <?php endif; ?>

            <div class="form-buttons">
                <a href="<?php echo $_SESSION['is_admin'] ? 'admin_complaints.php' : 'my_complaints.php'; ?>" class="btn btn-secondary">Back to List</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
    </footer>
</body>
</html>
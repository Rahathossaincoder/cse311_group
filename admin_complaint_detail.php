<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['is_admin']) || $_SESSION['is_admin'] !== true) {
    header("Location: login.php");
    exit();
}

$complaint_id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

// Get complaint
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

// Get attachments
$attachments = $pdo->prepare("SELECT * FROM Attachments WHERE complaint_id = ? ORDER BY upload_date DESC");
$attachments->execute([$complaint_id]);
$attachments = $attachments->fetchAll();

// Get history
$history = $pdo->prepare("SELECT * FROM Complaint_History WHERE complaint_id = ? ORDER BY change_date DESC");
$history->execute([$complaint_id]);
$history = $history->fetchAll();

$success = '';
$error = '';

// Handle status update
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        $pdo->beginTransaction();

        // Update complaint
        $updateStmt = $pdo->prepare("UPDATE Complaints SET status_id = ?, resolution_note = ?, last_updated = NOW() WHERE complaint_id = ?");
        $updateStmt->execute([$_POST['new_status_id'], $_POST['resolution_note'], $complaint_id]);

        // Add history
        $historyStmt = $pdo->prepare("
            INSERT INTO Complaint_History (complaint_id, old_status, new_status, changed_by, change_date, remarks)
            VALUES (?, ?, ?, ?, NOW(), ?)
        ");
        $historyStmt->execute([
            $complaint_id,
            $complaint['status_name'],
            $pdo->query("SELECT status_name FROM Complaint_Status WHERE status_id = {$_POST['new_status_id']}")->fetchColumn(),
            $_SESSION['user_id'],
            $_POST['resolution_note']
        ]);

        // Add notification
        $notifStmt = $pdo->prepare("
            INSERT INTO Notifications (user_id, complaint_id, message, notification_type, sent_date, read_status, delivery_status, priority)
            VALUES (?, ?, ?, 'Status_Updated', NOW(), 'Unread', 'Delivered', 'Normal')
        ");
        $notifStmt->execute([
            $complaint['user_id'],
            $complaint_id,
            "Your complaint #{$complaint_id} status has been updated."
        ]);

        $pdo->commit();
        $success = "Complaint status updated successfully!";
        
        // Refresh data
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

    } catch (Exception $e) {
        $pdo->rollBack();
        $error = "Error: " . $e->getMessage();
    }
}
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
        <a href="admin_complaints.php" class="back-link">← Back to Complaints</a>

        <?php if ($success): ?>
            <div class="alert alert-success">✅ <?php echo htmlspecialchars($success); ?></div>
        <?php endif; ?>

        <?php if ($error): ?>
            <div class="alert alert-danger">❌ <?php echo htmlspecialchars($error); ?></div>
        <?php endif; ?>

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
                            <label>Date</label>
                            <p><?php echo date('F d, Y', strtotime($complaint['submission_date'])); ?></p>
                        </div>
                        <div class="detail-item">
                            <label>Status</label>
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

                    <section class="detail-section">
                        <h2>Admin Actions</h2>
                        <form action="admin_complaint_detail.php?id=<?php echo $complaint_id; ?>" method="POST">
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
                <h2>Admin History</h2>
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
                <a href="admin_complaints.php" class="btn btn-secondary">Back to List</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
    </footer>
</body>
</html>
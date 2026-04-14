<?php
session_start();
require_once 'db_config.php';

if (!isset($_SESSION['user_id']) || ($_SESSION['is_admin'] ?? false)) {
    header("Location: login.php");
    exit();
}

$success = false;
$error = '';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        $pdo->beginTransaction();

        // Insert location
        $loc_stmt = $pdo->prepare("INSERT INTO Locations (road_name, area, city, district, latitude, longitude) VALUES (?, ?, ?, 'Dhaka', ?, ?)");
        $loc_stmt->execute([$_POST['road'], $_POST['area'], $_POST['city'], $_POST['lat'] ?? 23.8103, $_POST['lng'] ?? 90.4125]);
        $location_id = $pdo->lastInsertId();

        // Insert complaint
        $comp_stmt = $pdo->prepare("INSERT INTO Complaints (user_id, category_id, location_id, description, priority_level, status_id, submission_date) 
                                    VALUES (?, ?, ?, ?, ?, 1, NOW())");
        $comp_stmt->execute([$_SESSION['user_id'], $_POST['category_id'], $location_id, $_POST['description'], $_POST['priority_level']]);
        $complaint_id = $pdo->lastInsertId();

        // Handle file upload
        if (isset($_FILES['evidence']) && $_FILES['evidence']['error'] == 0) {
            $file_name = basename($_FILES['evidence']['name']);
            $dir = "uploads/complaints/{$complaint_id}/";
            if (!is_dir($dir)) mkdir($dir, 0777, true);

            $file_path = $dir . time() . "_" . $file_name;
            move_uploaded_file($_FILES['evidence']['tmp_name'], $file_path);

            $att_stmt = $pdo->prepare("INSERT INTO Attachments (complaint_id, file_name, file_type, file_size, file_path, uploaded_by) 
                                       VALUES (?, ?, ?, ?, ?, ?)");
            $att_stmt->execute([$complaint_id, $file_name, $_FILES['evidence']['type'], $_FILES['evidence']['size'], $file_path, $_SESSION['user_id']]);
        }

        // Create notification
        $noti_stmt = $pdo->prepare("INSERT INTO Notifications (user_id, complaint_id, message, notification_type, sent_date, read_status, delivery_status, priority) 
                                    VALUES (?, ?, ?, 'Complaint_Submitted', NOW(), 'Unread', 'Delivered', 'Normal')");
        $noti_stmt->execute([$_SESSION['user_id'], $complaint_id, "Your complaint #{$complaint_id} has been received and is under review."]);

        $pdo->commit();
        $success = true;
    } catch (Exception $e) {
        $pdo->rollBack();
        $error = "Error: " . $e->getMessage();
    }
}

// Get categories
$categories = $pdo->query("SELECT category_id, category_name FROM Complaint_Categories ORDER BY category_name")->fetchAll();

// ✅ Fetch ONLY what you want to show (phone + email, plus name if you keep it)
$stmt = $pdo->prepare("SELECT full_name, phone_number, email FROM Users WHERE user_id = ?");
$stmt->execute([$_SESSION['user_id']]);
$user = $stmt->fetch() ?: ['full_name' => '', 'phone_number' => '', 'email' => ''];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Complaint - Traffic Complaint System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo">🚦 Traffic Complaint System</div>
            <ul class="nav-links">
                <li><a href="user_dashboard.php">Dashboard</a></li>
                <li><a href="submit_complaint.php" class="active">Submit Complaint</a></li>
                <li><a href="my_complaints.php">My Complaints</a></li>
                <li><a href="profile.php">Profile</a></li>
                <li><a href="logout.php" class="logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Page Container -->
    <div class="page-container">
        <h1>Submit a Complaint</h1>

        <?php if ($success): ?>
            <div class="alert alert-success">✅ Complaint submitted successfully! <a href="my_complaints.php">View your complaints</a></div>
        <?php elseif ($error): ?>
            <div class="alert alert-danger">❌ <?php echo htmlspecialchars($error); ?></div>
        <?php endif; ?>

        <form class="complaint-form" method="POST" enctype="multipart/form-data">
            <!-- Personal Information -->
            <fieldset>
                <legend>Your Information</legend>

                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" value="<?php echo htmlspecialchars($user['phone_number']); ?>" disabled>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" value="<?php echo htmlspecialchars($user['email']); ?>" disabled>
                    </div>
                </div>

                <!-- If you truly don't want anything else, remove this block -->
                <div class="form-group" style="display:none;">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" value="<?php echo htmlspecialchars($user['full_name']); ?>" disabled>
                </div>
            </fieldset>

            <!-- Complaint Details -->
            <fieldset>
                <legend>Complaint Details</legend>
                <div class="form-row">
                    <div class="form-group">
                        <label for="category">Category</label>
                        <select id="category" name="category_id" required>
                            <option value="">-- Select Category --</option>
                            <?php foreach ($categories as $cat): ?>
                                <option value="<?php echo $cat['category_id']; ?>"><?php echo htmlspecialchars($cat['category_name']); ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="priority">Priority</label>
                        <select id="priority" name="priority_level" required>
                            <option value="Low">Low</option>
                            <option value="Medium" selected>Medium</option>
                            <option value="High">High</option>
                            <option value="Critical">Critical</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="date">Date of Incident</label>
                    <input type="date" id="date" required disabled value="<?php echo date('Y-m-d'); ?>">
                </div>
            </fieldset>

            <!-- Location -->
            <fieldset>
                <legend>Location</legend>
                <div class="form-group">
                    <label for="road">Road/Street Name</label>
                    <input type="text" id="road" name="road" placeholder="e.g. Bashundhara Road" required>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="area">Area</label>
                        <input type="text" id="area" name="area" placeholder="Area/Thana" required>
                    </div>
                    <div class="form-group">
                        <label for="city">City</label>
                        <select id="city" name="city" required>
                            <option value="Dhaka">Dhaka</option>
                            <option value="Chittagong">Chittagong</option>
                            <option value="Khulna">Khulna</option>
                            <option value="Rajshahi">Rajshahi</option>
                            <option value="Sylhet">Sylhet</option>
                        </select>
                    </div>
                </div>
            </fieldset>

            <!-- Description -->
            <fieldset>
                <legend>Description</legend>
                <div class="form-group">
                    <label for="description">Describe the Issue</label>
                    <textarea id="description" name="description" rows="5" placeholder="Please describe the traffic issue in detail..." required></textarea>
                </div>
                <div class="form-group">
                    <label for="photo">Upload Photo/Video (Optional)</label>
                    <input type="file" id="photo" name="evidence" accept="image/*,video/*">
                    <small>Max size: 15MB</small>
                </div>
            </fieldset>

            <!-- Agreement -->
            <fieldset>
                <legend>Confirmation</legend>
                <div class="form-group checkbox">
                    <input type="checkbox" id="agree" required>
                    <label for="agree">I confirm this information is accurate</label>
                </div>
            </fieldset>

            <div class="form-buttons">
                <a href="user_dashboard.php" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Submit Complaint</button>
            </div>
        </form>
    </div>

    <footer class="footer">
        <p>&copy; 2026 Traffic Complaint System. All rights reserved.</p>
    </footer>
</body>
</html>
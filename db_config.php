<?php
$host     = 'localhost';
$dbname   = 'smart_traffic_complaint_and_reporting_system'; // Correct database name
$username = 'root';
$password = ''; // XAMPP default

try {
    $pdo = new PDO(
        "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
        $username,
        $password,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );
    // Connection successful
} catch (PDOException $e) {
    die("<div style='color: red; padding: 20px; font-size: 16px;'>
        <h2>❌ Database Connection Failed</h2>
        <p><strong>Error:</strong> " . htmlspecialchars($e->getMessage()) . "</p>
        <p><strong>Database:</strong> smart_traffic_complaint_and_reporting_system</p>
        <p><strong>What to check:</strong></p>
        <ul>
            <li>Is MySQL running in XAMPP?</li>
            <li>Is your database name 'smart_traffic_complaint_and_reporting_system'?</li>
            <li>Check your database credentials in db_config.php</li>
            <li>Have you imported the SQL dump?</li>
        </ul>
    </div>");
}
?>
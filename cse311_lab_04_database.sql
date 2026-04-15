-- ============================================================
-- CSE311L: Database Systems
-- EXPANDED Company Database — Lab 1, 2, & 3 Ready
-- Compatible with XAMPP (MySQL / phpMyAdmin)
-- ============================================================
-- HOW TO IMPORT:
--   1. Open XAMPP → Start Apache + MySQL
--   2. Go to http://localhost/phpmyadmin
--   3. Click the "Import" tab at the top
--   4. Choose this file and click "Go"
-- ============================================================
-- This replaces the old cse311_lab_database.sql completely.
-- It includes ALL previous data PLUS major expansions.
-- ============================================================

-- ============================================================
-- STEP 1: Create and select the database
-- ============================================================
CREATE DATABASE IF NOT EXISTS Company_Database_Class_04;
USE Company_Database_Class_04;

-- ============================================================
-- STEP 2: Drop existing tables (child tables first)
-- ============================================================
DROP TABLE IF EXISTS Training_Enrollment;
DROP TABLE IF EXISTS Training_Course;
DROP TABLE IF EXISTS Project_Assignment;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Location;

-- ============================================================
-- TABLE 1: Location (NEW!)
-- ============================================================
-- Normalized location data for departments.
-- Allows questions like: "How many departments per building?"
-- ============================================================
CREATE TABLE Location (
    Location_ID INT PRIMARY KEY,
    Building_Name VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL
);

-- ============================================================
-- TABLE 2: Department (Expanded — 10 departments)
-- ============================================================
CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL,
    Location_ID INT,
    Manager_ID INT,
    Budget DECIMAL(12, 2),
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);

-- ============================================================
-- TABLE 3: Employee (Expanded — 40 employees)
-- ============================================================
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50) NOT NULL,
    Email_Address VARCHAR(100) NOT NULL,
    Phone_Number VARCHAR(20),
    Hire_Date DATE NOT NULL,
    Job_Role VARCHAR(50) NOT NULL,
    Salary_Amount DECIMAL(10, 2),
    Commission DECIMAL(5, 2),
    Dept_ID INT,
    Supervisor_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
    FOREIGN KEY (Supervisor_ID) REFERENCES Employee(Employee_ID)
);

-- ============================================================
-- TABLE 4: Project (Expanded — 20 projects)
-- ============================================================
CREATE TABLE Project (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(100) NOT NULL,
    Budget_Amount DECIMAL(12, 2),
    Start_Date DATE,
    End_Date DATE,
    Status VARCHAR(20) DEFAULT 'Active',
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

-- ============================================================
-- TABLE 5: Project_Assignment (NEW! — Many-to-Many)
-- ============================================================
-- Links employees to projects. One employee can work on
-- multiple projects. One project can have multiple employees.
-- Great for GROUP BY, COUNT, and multi-table JOIN questions!
-- ============================================================
CREATE TABLE Project_Assignment (
    Assignment_ID INT PRIMARY KEY,
    Employee_ID INT NOT NULL,
    Project_ID INT NOT NULL,
    Role_In_Project VARCHAR(50),
    Hours_Worked DECIMAL(6, 1),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID)
);

-- ============================================================
-- TABLE 6: Training_Course (NEW!)
-- ============================================================
CREATE TABLE Training_Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL,
    Duration_Hours INT,
    Difficulty VARCHAR(20),
    Instructor VARCHAR(50)
);

-- ============================================================
-- TABLE 7: Training_Enrollment (NEW! — Many-to-Many)
-- ============================================================
-- Links employees to training courses.
-- Great for aggregate + JOIN questions!
-- ============================================================
CREATE TABLE Training_Enrollment (
    Enrollment_ID INT PRIMARY KEY,
    Employee_ID INT NOT NULL,
    Course_ID INT NOT NULL,
    Enrollment_Date DATE,
    Score DECIMAL(5, 2),
    Status VARCHAR(20) DEFAULT 'Enrolled',
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Course_ID) REFERENCES Training_Course(Course_ID)
);


-- ============================================================
--                  INSERT DATA
-- ============================================================

-- ============================================================
-- Locations (6 buildings across 3 cities)
-- ============================================================
INSERT INTO Location VALUES
(1, 'Building A', 'Dhaka', 'Bangladesh'),
(2, 'Building B', 'Dhaka', 'Bangladesh'),
(3, 'Building C', 'Dhaka', 'Bangladesh'),
(4, 'Building D', 'Chittagong', 'Bangladesh'),
(5, 'Building E', 'Chittagong', 'Bangladesh'),
(6, 'Building F', 'Sylhet', 'Bangladesh');

-- ============================================================
-- Departments (10 total — 2 departments have NO employees)
-- ============================================================
INSERT INTO Department (Dept_ID, Dept_Name, Location_ID, Budget) VALUES
(10, 'Engineering',       1, 500000.00),
(20, 'Human Resources',   2, 200000.00),
(30, 'Marketing',         3, 300000.00),
(40, 'Finance',           4, 250000.00),
(50, 'Sales',             1, 400000.00),
(60, 'IT Support',        5, 180000.00),
(70, 'Research',          6, 600000.00),
(80, 'Legal',             2, 150000.00),
(90, 'Public Relations',  3, 120000.00),
(100, 'Operations',       4, 350000.00);

-- ============================================================
-- Employees (40 total — 2 have no department)
-- ============================================================

-- ── Managers (report to no one) ────────────────────────────
INSERT INTO Employee VALUES
(101, 'Steven',    'King',       'steven.king@gmail.com',       '01711-123456', '2020-06-15', 'Manager',           50000.00, NULL,  10, NULL),
(102, 'Neena',     'Kochhar',    'neena.k@yahoo.com',           '01811-987654', '2021-03-20', 'Manager',           48000.00, NULL,  20, NULL),
(103, 'Lex',       'De Haan',    'lex.dehaan@nsumail.com',      '01911-555666', '2021-06-01', 'Manager',           45000.00, NULL,  30, NULL),
(104, 'Alexander', 'Hunold',     'alex.hunold@gmail.com',       '01712-111222', '2020-02-10', 'Manager',           47000.00, NULL,  40, NULL),
(105, 'Bruce',     'Ernst',      'bruce.ernst@outlook.com',     '01812-333444', '2020-08-05', 'Manager',           46000.00, 0.15,  50, NULL),
(106, 'Valli',     'Pataballa',  'valli.p@gmail.com',           '01912-555777', '2021-07-18', 'Manager',           44000.00, NULL,  60, NULL),
(107, 'Diana',     'Lorentz',    'diana.l@nsumail.com',         '01711-888999', '2021-09-22', 'Manager',           43000.00, NULL,  70, NULL),
(108, 'Hermann',   'Baer',       'hermann.b@nsumail.com',       '01818-181818', '2022-01-10', 'Manager',           42000.00, NULL, 100, NULL);

-- ── Update Department Managers ─────────────────────────────
UPDATE Department SET Manager_ID = 101 WHERE Dept_ID = 10;
UPDATE Department SET Manager_ID = 102 WHERE Dept_ID = 20;
UPDATE Department SET Manager_ID = 103 WHERE Dept_ID = 30;
UPDATE Department SET Manager_ID = 104 WHERE Dept_ID = 40;
UPDATE Department SET Manager_ID = 105 WHERE Dept_ID = 50;
UPDATE Department SET Manager_ID = 106 WHERE Dept_ID = 60;
UPDATE Department SET Manager_ID = 107 WHERE Dept_ID = 70;
UPDATE Department SET Manager_ID = 108 WHERE Dept_ID = 100;
-- Dept 80 (Legal) and 90 (PR) have NO manager and NO employees

-- ── Senior Staff (report to managers) ──────────────────────
INSERT INTO Employee VALUES
(109, 'Nancy',    'Greenberg',  'nancy.g@yahoo.com',           '01813-101010', '2021-05-12', 'Senior Engineer',   38000.00, NULL,  10, 101),
(110, 'Daniel',   'Faviet',     'daniel.f@gmail.com',          '01713-202020', '2022-08-25', 'Senior Analyst',    37000.00, NULL,  40, 104),
(111, 'John',     'Chen',       'john.chen@outlook.com',       '01913-303030', '2022-01-10', 'Senior Accountant', 36000.00, NULL,  40, 104),
(112, 'Ismael',   'Sciarra',    'ismael.s@nsumail.com',        '01714-404040', '2022-02-14', 'Team Lead',         39000.00, 0.12,  50, 105),
(113, 'Sarah',    'Bell',       'sarah.bell@gmail.com',        '01814-505050', '2022-04-01', 'HR Specialist',     32000.00, NULL,  20, 102),
(114, 'Shelli',   'Baida',      'shelli.b@yahoo.com',          '01914-606060', '2022-05-20', 'Content Writer',    30000.00, NULL,  30, 103),
(115, 'Amit',     'Roy',        'amit.roy@gmail.com',          '01715-707070', '2022-06-15', 'Senior Developer',  37500.00, NULL,  10, 101),
(116, 'Fatima',   'Khan',       'fatima.k@yahoo.com',          '01815-808080', '2022-09-01', 'Research Lead',     36500.00, NULL,  70, 107),
(117, 'Raj',      'Mehta',      'raj.mehta@outlook.com',       '01915-909090', '2022-11-01', 'Operations Lead',   35000.00, NULL, 100, 108);

-- ── Junior Staff (report to seniors or managers) ───────────
INSERT INTO Employee VALUES
(118, 'David',    'Lee',        'david.l@gmail.com',           '01700-000000', '2023-07-01', 'Intern',            15000.00, NULL,  10, 109),
(119, 'Sundar',   'Ande',       'sundar.a@outlook.com',        '01715-070707', '2023-06-15', 'Programmer',        28000.00, NULL,  10, 109),
(120, 'Lisa',     'Ozer',       'lisa.ozer@yahoo.com',         '01915-090909', '2023-09-10', 'Sales Executive',   27000.00, 0.10,  50, 112),
(121, 'Harrison', 'Bloom',      'harrison.b@gmail.com',        '01716-010101', '2023-01-05', 'Recruiter',         25000.00, NULL,  20, 113),
(122, 'Tayler',   'Fox',        'tayler.fox@outlook.com',      '01816-121212', '2024-02-18', 'Graphic Designer',  26000.00, NULL,  30, 114),
(123, 'William',  'Smith',      'william.s@nsumail.com',       '01916-131313', '2024-03-30', 'IT Technician',     23000.00, NULL,  60, 106),
(124, 'Jennifer', 'Whalen',     'jennifer.w@gmail.com',        '01717-141414', '2024-04-12', 'Lab Assistant',     20000.00, NULL,  70, 116),
(125, 'Michael',  'Hartstein',  'michael.h@yahoo.com',         '01817-151515', '2023-11-01', 'Sales Executive',   27500.00, 0.10,  50, 112),
(126, 'Shelley',  'Higgins',    'shelley.h@outlook.com',       '01917-161616', '2024-05-15', 'Programmer',        29000.00, NULL,  10, 115),
(127, 'Susan',    'Mavris',     'susan.m@gmail.com',           '01718-171717', '2023-12-08', 'Research Intern',   16000.00, NULL,  70, 116),
(128, 'Sigal',    'Tobias',     'sigal.t@gmail.com',           '01918-191919', '2024-08-01', 'Intern',            14000.00, NULL,  30, 114),
(129, 'Nandita',  'Saha',       'nandita.s@gmail.com',         '01719-200200', '2024-01-15', 'Junior Analyst',    22000.00, NULL,  40, 110),
(130, 'Karim',    'Hassan',     'karim.h@outlook.com',         '01819-300300', '2024-06-10', 'Sales Executive',   26500.00, 0.08,  50, 112),
(131, 'Tanvir',   'Ahmed',      'tanvir.a@gmail.com',          '01919-400400', '2024-07-20', 'IT Technician',     24000.00, NULL,  60, 106),
(132, 'Maliha',   'Akter',      'maliha.a@yahoo.com',          '01720-500500', '2023-10-05', 'Marketing Exec',    28500.00, NULL,  30, 103),
(133, 'Arif',     'Hossain',    'arif.h@nsumail.com',          '01820-600600', '2024-09-01', 'Junior Developer',  25000.00, NULL,  10, 115),
(134, 'Tasnim',   'Rahman',     'tasnim.r@gmail.com',          '01920-700700', '2025-01-10', 'HR Assistant',      21000.00, NULL,  20, 113),
(135, 'Omar',     'Farooq',     'omar.f@outlook.com',          '01721-800800', '2025-02-15', 'Research Intern',   15500.00, NULL,  70, 116),
(136, 'Sadia',    'Islam',      'sadia.i@gmail.com',           '01821-900900', '2025-03-01', 'Intern',            14500.00, NULL,  40, 110),
(137, 'Rafiq',    'Uddin',      'rafiq.u@yahoo.com',           '01921-010010', '2025-04-20', 'Operations Asst',   22500.00, NULL, 100, 117),
(138, 'Priya',    'Das',        'priya.das@outlook.com',       '01819-444555', '2025-06-01', 'Freelancer',        20000.00, NULL, NULL, NULL);

-- ── Employees with NO department (for Outer Join exercises) ─
INSERT INTO Employee VALUES
(139, 'Ravi',     'Sharma',     'ravi.sharma@gmail.com',       '01719-222333', '2025-09-01', 'Consultant',        35000.00, NULL, NULL, NULL),
(140, 'Ahmed',    'Zaman',      'ahmed.z@gmail.com',           '01822-112233', '2025-08-15', 'Consultant',        33000.00, NULL, NULL, NULL);


-- ============================================================
-- Projects (20 total — varied status and dates)
-- ============================================================
INSERT INTO Project VALUES
(501, 'Mobile App Redesign',        150000.00, '2024-01-10', '2024-12-31', 'Completed',  10),
(502, 'Employee Portal Upgrade',     50000.00, '2024-03-01', '2024-09-30', 'Completed',  20),
(503, 'Social Media Campaign',       25000.00, '2024-06-01', '2024-12-15', 'Completed',  30),
(504, 'Server Migration',            80000.00, '2024-07-01', '2025-03-31', 'Active',     10),
(505, 'Yearly Audit System',         45000.00, '2024-08-01', '2025-02-28', 'Completed',  20),
(506, 'Budget Forecasting Tool',    120000.00, '2024-09-01', '2025-06-30', 'Active',     40),
(507, 'CRM Integration',            200000.00, '2024-04-01', '2025-04-30', 'Active',     50),
(508, 'Network Security Overhaul',   95000.00, '2024-10-01', '2025-07-31', 'Active',     60),
(509, 'AI Research Prototype',      300000.00, '2024-05-01', '2025-12-31', 'Active',     70),
(510, 'Brand Refresh Campaign',      35000.00, '2025-01-01', '2025-06-30', 'Active',     30),
(511, 'Tax Filing Automation',       60000.00, '2025-01-15', '2025-08-31', 'Active',     40),
(512, 'Sales Dashboard',             72000.00, '2025-02-01', '2025-09-30', 'Active',     50),
(513, 'Cloud Infrastructure Setup', 180000.00, '2025-03-01', '2025-12-31', 'Active',     10),
(514, 'Employee Training Portal',    40000.00, '2025-04-01', '2025-10-31', 'Active',     20),
(515, 'Customer Feedback System',    55000.00, '2025-05-01', '2025-11-30', 'Active',     50),
(516, 'Warehouse Automation',       160000.00, '2025-02-01', '2025-12-31', 'Active',    100),
(517, 'Data Analytics Platform',    250000.00, '2025-06-01', NULL,         'Active',     70),
(518, 'Compliance Review System',    70000.00, '2025-03-15', NULL,         'Planned',    40),
(519, 'Marketing Analytics',         45000.00, '2025-07-01', NULL,         'Planned',    30),
(520, 'Internal Chat System',        85000.00, '2025-04-01', NULL,         'Planned',    60);


-- ============================================================
-- Project Assignments (employees assigned to projects)
-- ============================================================
-- Engineering projects
INSERT INTO Project_Assignment VALUES
(1,  101, 501, 'Project Manager',   120.0),
(2,  109, 501, 'Lead Developer',    350.0),
(3,  119, 501, 'Developer',         280.0),
(4,  118, 504, 'Junior Developer',  100.0),
(5,  115, 504, 'Lead Developer',    300.0),
(6,  126, 504, 'Developer',         250.0),
(7,  101, 513, 'Project Manager',    80.0),
(8,  109, 513, 'Architect',         200.0),
(9,  133, 513, 'Developer',         150.0),
-- HR projects
(10, 102, 502, 'Project Manager',   100.0),
(11, 113, 502, 'HR Lead',           200.0),
(12, 121, 505, 'Coordinator',       180.0),
(13, 134, 514, 'Assistant',         120.0),
-- Marketing projects
(14, 103, 503, 'Project Manager',    90.0),
(15, 114, 503, 'Content Lead',      250.0),
(16, 122, 510, 'Designer',          200.0),
(17, 132, 510, 'Marketing Lead',    180.0),
(18, 128, 519, 'Intern Support',     60.0),
-- Finance projects
(19, 104, 506, 'Project Manager',   150.0),
(20, 110, 506, 'Lead Analyst',      280.0),
(21, 111, 506, 'Accountant',        220.0),
(22, 129, 511, 'Junior Analyst',    160.0),
(23, 136, 518, 'Intern Support',     40.0),
-- Sales projects
(24, 105, 507, 'Project Manager',   200.0),
(25, 112, 507, 'Sales Lead',        350.0),
(26, 120, 507, 'Sales Associate',   280.0),
(27, 125, 512, 'Sales Associate',   200.0),
(28, 130, 515, 'Sales Associate',   150.0),
-- IT Support projects
(29, 106, 508, 'Project Manager',   100.0),
(30, 123, 508, 'Technician',        300.0),
(31, 131, 520, 'Technician',        120.0),
-- Research projects
(32, 107, 509, 'Project Manager',   250.0),
(33, 116, 509, 'Research Lead',     400.0),
(34, 124, 509, 'Lab Assistant',     180.0),
(35, 127, 517, 'Research Intern',   100.0),
(36, 135, 517, 'Research Intern',    80.0),
-- Operations projects
(37, 108, 516, 'Project Manager',   180.0),
(38, 117, 516, 'Operations Lead',   300.0),
(39, 137, 516, 'Assistant',         140.0);
-- NOTE: Employees 138 (Priya), 139 (Ravi), 140 (Ahmed) have NO project assignments


-- ============================================================
-- Training Courses (8 courses)
-- ============================================================
INSERT INTO Training_Course VALUES
(1, 'SQL Fundamentals',         20, 'Beginner',     'Prof. Rahman'),
(2, 'Advanced SQL & PL/SQL',    40, 'Advanced',     'Prof. Rahman'),
(3, 'Python for Data Science',  30, 'Intermediate', 'Prof. Khan'),
(4, 'Project Management',       25, 'Beginner',     'Prof. Akter'),
(5, 'Cybersecurity Basics',     15, 'Beginner',     'Prof. Hossain'),
(6, 'Cloud Computing',          35, 'Advanced',     'Prof. Khan'),
(7, 'Business Communication',   10, 'Beginner',     'Prof. Akter'),
(8, 'Machine Learning Intro',   45, 'Advanced',     'Prof. Islam');


-- ============================================================
-- Training Enrollments (employees in courses, with scores)
-- ============================================================
INSERT INTO Training_Enrollment VALUES
-- SQL Fundamentals (popular — many enrolled)
(1,  118, 1, '2024-01-10', 72.50,  'Completed'),
(2,  119, 1, '2024-01-10', 88.00,  'Completed'),
(3,  121, 1, '2024-01-15', 65.00,  'Completed'),
(4,  122, 1, '2024-01-15', 91.00,  'Completed'),
(5,  123, 1, '2024-02-01', 78.50,  'Completed'),
(6,  129, 1, '2024-02-01', 82.00,  'Completed'),
(7,  133, 1, '2024-03-01', 69.00,  'Completed'),
(8,  134, 1, '2024-03-10', 85.00,  'Completed'),
(9,  136, 1, '2024-06-01', 55.00,  'Completed'),
(10, 137, 1, '2024-06-15', 90.00,  'Completed'),
-- Advanced SQL
(11, 109, 2, '2024-04-01', 92.00,  'Completed'),
(12, 110, 2, '2024-04-01', 87.50,  'Completed'),
(13, 115, 2, '2024-05-01', 95.00,  'Completed'),
(14, 119, 2, '2024-06-01', 80.00,  'Completed'),
(15, 126, 2, '2024-07-01', NULL,   'In Progress'),
-- Python for Data Science
(16, 116, 3, '2024-03-01', 89.00,  'Completed'),
(17, 109, 3, '2024-03-15', 76.50,  'Completed'),
(18, 127, 3, '2024-08-01', NULL,   'In Progress'),
(19, 135, 3, '2025-01-10', NULL,   'Enrolled'),
-- Project Management
(20, 101, 4, '2023-06-01', 94.00,  'Completed'),
(21, 102, 4, '2023-06-01', 88.00,  'Completed'),
(22, 104, 4, '2023-07-01', 91.50,  'Completed'),
(23, 108, 4, '2023-09-01', 86.00,  'Completed'),
(24, 112, 4, '2024-01-01', 79.00,  'Completed'),
-- Cybersecurity Basics
(25, 123, 5, '2024-05-01', 83.00,  'Completed'),
(26, 131, 5, '2024-08-01', 77.00,  'Completed'),
(27, 106, 5, '2024-02-01', 96.00,  'Completed'),
-- Cloud Computing
(28, 115, 6, '2024-09-01', 88.50,  'Completed'),
(29, 109, 6, '2024-10-01', NULL,   'In Progress'),
(30, 133, 6, '2025-01-15', NULL,   'Enrolled'),
-- Business Communication
(31, 113, 7, '2023-11-01', 85.00,  'Completed'),
(32, 114, 7, '2023-11-01', 90.00,  'Completed'),
(33, 121, 7, '2024-02-01', 72.00,  'Completed'),
(34, 134, 7, '2024-06-01', 80.00,  'Completed'),
-- Machine Learning Intro
(35, 116, 8, '2024-06-01', 93.00,  'Completed'),
(36, 107, 8, '2024-07-01', 87.00,  'Completed'),
(37, 127, 8, '2025-02-01', NULL,   'Enrolled'),
(38, 124, 8, '2025-02-01', NULL,   'Enrolled');
-- NOTE: Some employees have completed NO training at all (good for outer joins!)


-- ============================================================
-- DATABASE SETUP COMPLETE!
-- ============================================================

-- ============================================================

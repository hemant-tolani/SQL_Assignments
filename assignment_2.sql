create database student;
use student;

-- Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

-- Courses Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY IDENTITY(1,1),
    course_name VARCHAR(100),
    credits INT,
    teacher_id INT FOREIGN KEY REFERENCES Teacher(teacher_id)
);

-- Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    course_id INT FOREIGN KEY REFERENCES Courses(course_id),
    enrollment_date DATE
);

-- Teacher Table
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    amount DECIMAL(10, 2),
    payment_date DATE
);

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES
('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890'),
('Alice', 'Smith', '1998-03-22', 'alice.smith@example.com', '9876543210'),
('Bob', 'Johnson', '1997-05-10', 'bob.johnson@example.com', '5551234567'),
('Emma', 'Miller', '1996-11-03', 'emma.miller@example.com', '1237894560'),
('James', 'Davis', '1999-09-25', 'james.davis@example.com', '7890123456'),
('Olivia', 'White', '1994-04-18', 'olivia.white@example.com', '2345678901'),
('Ethan', 'Taylor', '1993-12-08', 'ethan.taylor@example.com', '4567890123'),
('Sophia', 'Martin', '1992-06-30', 'sophia.martin@example.com', '6789012345'),
('Noah', 'Clark', '1991-02-14', 'noah.clark@example.com', '8901234567');

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES
('Mia', 'John', '1996-08-15', 'mia.john@example.com', '1237657890');

INSERT INTO Courses (course_name, credits, teacher_id)
VALUES
('Mathematics', 3, 1),
('History', 4, 2),
('Computer Science', 5, 3),
('Physics', 4, 4),
('Literature', 3, 5),
('Chemistry', 4, 1),
('Biology', 4, 2),
('Art', 2, 3),
('Music', 2, 4),
('Physical Education', 2, 5);

INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES
(2, 2, '2023-01-02'),
(3, 3, '2023-01-03'),
(4, 4, '2023-01-04'),
(5, 5, '2023-01-05'),
(6, 6, '2023-01-06'),
(7, 7, '2023-01-07'),
(8, 8, '2023-01-08'),
(9, 9, '2023-01-09'),
(10, 10, '2023-01-10'),
(1, 11, '2023-01-01');

INSERT INTO Teacher (first_name, last_name, email)
VALUES
('Mr.', 'Anderson', 'mr.anderson@example.com'),
('Mrs.', 'Johnson', 'mrs.johnson@example.com'),
('Dr.', 'Smith', 'dr.smith@example.com'),
('Ms.', 'Davis', 'ms.davis@example.com'),
('Prof.', 'Miller', 'prof.miller@example.com'),
('Miss', 'Taylor', 'miss.taylor@example.com'),
('Mr.', 'White', 'mr.white@example.com'),
('Mrs.', 'Clark', 'mrs.clark@example.com'),
('Dr.', 'Martin', 'dr.martin@example.com'),
('Ms.', 'Brown', 'ms.brown@example.com');




INSERT INTO Payments (student_id, amount, payment_date)
VALUES
(1, 500.00, '2023-02-01'),
(2, 750.00, '2023-02-02'),
(3, 600.00, '2023-02-03'),
(4, 700.00, '2023-02-04'),
(5, 550.00, '2023-02-05'),
(6, 800.00, '2023-02-06'),
(7, 900.00, '2023-02-07'),
(8, 650.00, '2023-02-08'),
(9, 720.00, '2023-02-09'),
(10, 850.00, '2023-02-10');

---------------------------------
--1
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES ('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

------------------------------------
--2
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (1, 2, GETDATE()); 
-------------------------------------
--3
UPDATE Teacher
SET email = 'new.email@example.com'
WHERE teacher_id = 1; 
--------------------------------------
--4
DELETE FROM Enrollments
WHERE student_id = 1 AND course_id = 2; 
----------------------------------------
--5
UPDATE Courses
SET teacher_id = 2 
WHERE course_id = 2; 

-----------------------------------------
--6
-------------
ALTER TABLE Enrollments
ADD CONSTRAINT FK_Enrollments_Students
FOREIGN KEY (student_id) REFERENCES Students(student_id)
ON DELETE CASCADE;
---
DELETE FROM Students
WHERE first_name = 'Mia' AND last_name = 'John';
--- 
ALTER TABLE Payments
DROP CONSTRAINT FK__Payments__studen__571DF1D5;

ALTER TABLE Payments
ADD CONSTRAINT FK__Payments__studen__571DF1D5
FOREIGN KEY (student_id)
REFERENCES Students(student_id)
ON DELETE SET NULL;
------------
DECLARE @StudentId INT;
SET @StudentId = (SELECT student_id FROM Students WHERE first_name = 'John' AND last_name = 'Doe');

-- Delete associated payments
DELETE FROM Payments
WHERE student_id = @StudentId;

-- Now delete the student
DELETE FROM Students
WHERE student_id = @StudentId;

-----------------------------------------
--7
UPDATE Payments
SET amount = 1234.0
WHERE payment_id = 1;

------------------------------------------------------------

--joins queries
----------------
--1
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_payments
FROM
    Students s
JOIN
    Payments p ON s.student_id = p.student_id
WHERE
    s.student_id = 1 
GROUP BY
    s.student_id, s.first_name, s.last_name;
------------------------------------------------
--2
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS students_enrolled
FROM
    Courses c
LEFT JOIN
    Enrollments e ON c.course_id = e.course_id
GROUP BY
    c.course_id, c.course_name;
----------------------------------------------
--3
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM
    Students s
LEFT JOIN
    Enrollments e ON s.student_id = e.student_id
WHERE
    e.enrollment_id IS NULL;
-----------------------------------------------
--4
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM
    Students s
JOIN
    Enrollments e ON s.student_id = e.student_id
JOIN
    Courses c ON e.course_id = c.course_id;
------------------------------------------------
--5
SELECT
    t.first_name AS teacher_first_name,
    t.last_name AS teacher_last_name,
    c.course_name
FROM
    Teacher t
JOIN
    Courses c ON t.teacher_id = c.teacher_id;
------------------------------------------------
--6
SELECT
    s.first_name,
    s.last_name,
    e.enrollment_date
FROM
    Students s
JOIN
    Enrollments e ON s.student_id = e.student_id
JOIN
    Courses c ON e.course_id = c.course_id
WHERE
    c.course_name = 'History'; 
------------------------------------------------
--7
SELECT
    s.first_name,
    s.last_name
FROM
    Students s
LEFT JOIN
    Payments p ON s.student_id = p.student_id
WHERE
    p.payment_id IS NULL;
------------------------------------------------
--8
SELECT
    c.course_id,
    c.course_name
FROM
    Courses c
LEFT JOIN
    Enrollments e ON c.course_id = e.course_id
WHERE
    e.enrollment_id IS NULL;
------------------------------------------------
--9
SELECT
    e1.student_id,
    s.first_name,
    s.last_name
FROM
    Enrollments e1
JOIN
    Enrollments e2 ON e1.student_id = e2.student_id AND e1.enrollment_id <> e2.enrollment_id
JOIN
    Students s ON e1.student_id = s.student_id
GROUP BY
    e1.student_id, s.first_name, s.last_name
HAVING
    COUNT(DISTINCT e1.course_id) < 1;
------------------------------------------------
--10
SELECT
    t.teacher_id,
    t.first_name,
    t.last_name
FROM
    Teacher t
LEFT JOIN
    Courses c ON t.teacher_id = c.teacher_id
WHERE
    c.course_id IS NULL;
-----------------------------------------------
-----------------------------------------------

--aggregate functions
----------------------

--1
SELECT
    AVG(EnrollmentCount) AS average_students_per_course
FROM (
    SELECT
        c.course_id,
        COUNT(e.student_id) AS EnrollmentCount
    FROM
        Courses c
    LEFT JOIN
        Enrollments e ON c.course_id = e.course_id
    GROUP BY
        c.course_id
) AS CourseEnrollments;
-------------------------------------------
--2
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    p.amount AS highest_payment
FROM
    Students s
JOIN
    Payments p ON s.student_id = p.student_id
WHERE
    p.amount = (SELECT MAX(amount) FROM Payments);
-------------------------------------------
--3
SELECT
    c.course_id,
    c.course_name,
    EnrollmentsCount AS enrollment_count
FROM
    Courses c
JOIN (
    SELECT
        course_id,
        COUNT(student_id) AS EnrollmentsCount
    FROM
        Enrollments
    GROUP BY
        course_id
) AS EnrollmentCounts ON c.course_id = EnrollmentCounts.course_id
WHERE
    EnrollmentsCount = (SELECT MAX(EnrollmentsCount) FROM (
        SELECT
            COUNT(student_id) AS EnrollmentsCount
        FROM
            Enrollments
        GROUP BY
            course_id
    ) AS MaxEnrollments);
------------------------------------------
--4
SELECT
    t.teacher_id,
    t.first_name,
    t.last_name,
    SUM(p.amount) AS total_payments_for_courses
FROM
    Teacher t
JOIN
    Courses c ON t.teacher_id = c.teacher_id
LEFT JOIN
    Enrollments e ON c.course_id = e.course_id
LEFT JOIN
    Payments p ON e.student_id = p.student_id
GROUP BY
    t.teacher_id, t.first_name, t.last_name;
-------------------------------------------
--5
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM
    Students s
WHERE
    NOT EXISTS (
        SELECT c.course_id
        FROM Courses c
        WHERE NOT EXISTS (
            SELECT e.course_id
            FROM Enrollments e
            WHERE e.student_id = s.student_id AND e.course_id = c.course_id
        )
    );
------------------------------------------
--6
SELECT
    t.teacher_id,
    t.first_name,
    t.last_name
FROM
    Teacher t
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Courses c
        WHERE c.teacher_id = t.teacher_id
    );
------------------------------------------
--7
SELECT
    AVG(StudentAge) AS average_student_age
FROM (
    SELECT
        DATEDIFF(YEAR, date_of_birth, GETDATE()) AS StudentAge
    FROM
        Students
) AS StudentAges;
------------------------------------------
--8
SELECT
    course_id,
    course_name
FROM
    Courses
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Enrollments
        WHERE Enrollments.course_id = Courses.course_id
    );
------------------------------------------
--9

SELECT DISTINCT e1.student_id
FROM Enrollments e1
JOIN Enrollments e2 ON e1.student_id = e2.student_id
WHERE e1.course_id <> e2.course_id;

-------------------------------------------
--10
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM
    Students s
JOIN
    Payments p ON s.student_id = p.student_id
GROUP BY
    s.student_id, s.first_name, s.last_name
HAVING
    COUNT(p.payment_id) > 1;
------------------------------------------
--11
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_payments
FROM
    Students s
JOIN
    Payments p ON s.student_id = p.student_id
GROUP BY
    s.student_id, s.first_name, s.last_name;
-------------------------------------------
--12
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM
    Courses c
LEFT JOIN
    Enrollments e ON c.course_id = e.course_id
GROUP BY
    c.course_id, c.course_name;
------------------------------------------
--13
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    AVG(p.amount) AS average_payment_amount
FROM
    Students s
JOIN
    Payments p ON s.student_id = p.student_id
GROUP BY
    s.student_id, s.first_name, s.last_name;




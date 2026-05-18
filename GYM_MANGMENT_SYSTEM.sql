DROP DATABASE IF EXISTS GymSystem;

CREATE DATABASE GymSystem;
USE GymSystem;

-- =========================================
--               CREATE TABLES              
-- =========================================

CREATE TABLE Members
(
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male','Female')),
    age INT CHECK (age >= 15),
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    join_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Trainers
(
    trainer_id INT PRIMARY KEY AUTO_INCREMENT,
    trainer_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    salary DECIMAL(10,2) CHECK (salary > 0)
);

CREATE TABLE MembershipPlans
(
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50) NOT NULL,
    duration_months INT NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE MemberMemberships
(
    membership_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (plan_id) REFERENCES MembershipPlans(plan_id)
);

CREATE TABLE Payments
(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

CREATE TABLE Attendance
(
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    attendance_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

CREATE TABLE Classes
(
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(100) NOT NULL,
    trainer_id INT NOT NULL,
    class_time TIME,
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id)
);

CREATE TABLE ClassRegistrations
(
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    class_id INT NOT NULL,
    registration_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- =========================================
--               ALTER TABLES               
-- =========================================

ALTER TABLE Payments
ADD COLUMN membership_id INT,
ADD FOREIGN KEY (membership_id) REFERENCES MemberMemberships(membership_id);

-- =========================================
--               INSERT DATA                
-- =========================================

INSERT INTO Members (full_name, gender, age, phone, email) VALUES
('Ahmed Ali', 'Male', 22, '01011111111', 'ahmed@gmail.com'),
('Sara Mohamed', 'Female', 20, '01022222222', 'sara@gmail.com'),
('Mona Khaled', 'Female', 24, '01033333333', 'mona@gmail.com');

INSERT INTO Trainers (trainer_name, specialty, salary) VALUES
('Captain Omar', 'Bodybuilding', 12000),
('Captain Nada', 'Fitness', 10000);

INSERT INTO MembershipPlans (plan_name, duration_months, price) VALUES
('Monthly', 1, 500),
('3 Months', 3, 1200),
('Annual', 12, 4000);

INSERT INTO MemberMemberships (member_id, plan_id, start_date, end_date) VALUES
(1, 1, '2026-05-01', '2026-06-01'),
(2, 2, '2026-05-01', '2026-08-01');

INSERT INTO Payments (member_id, membership_id, amount) VALUES
(1, 1, 500),
(2, 2, 1200),
(1, 1, 300);

INSERT INTO Attendance (member_id) VALUES
(1),
(2),
(1);

INSERT INTO Classes (class_name, trainer_id, class_time) VALUES
('Yoga', 2, '18:00:00'),
('Muscle Building', 1, '20:00:00');

INSERT INTO ClassRegistrations (member_id, class_id) VALUES
(1, 1),
(2, 2),
(3, 1);

-- =========================================
--          UPDATE & DELETE EXAMPLES        
-- =========================================

UPDATE Members SET phone = '01099999999' WHERE member_id = 1;
DELETE FROM Attendance WHERE attendance_id = 1;

-- =========================================
--             STORED PROCEDURE             
-- =========================================

DELIMITER //
CREATE PROCEDURE sp_UpdateMember(
    IN p_member_id INT,
    IN p_full_name VARCHAR(100),
    IN p_gender VARCHAR(10),
    IN p_age INT,
    IN p_phone VARCHAR(20),
    IN p_email VARCHAR(100)
)
BEGIN
    UPDATE Members
    SET full_name = p_full_name, gender = p_gender, age = p_age, phone = p_phone, email = p_email
    WHERE member_id = p_member_id;
END //
DELIMITER ;

-- =========================================
--                 TRIGGER                  
-- =========================================

DELIMITER //
CREATE TRIGGER trg_PreventDeleteMember
BEFORE DELETE ON Members
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Payments WHERE member_id = OLD.member_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete member with payments';
    END IF;
END //
DELIMITER ;

-- =========================================
--             SCALAR FUNCTION              
-- =========================================

DELIMITER //
CREATE FUNCTION fn_GetRemainingDays (p_membership_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_days INT;
    SELECT DATEDIFF(end_date, CURRENT_DATE()) INTO v_days
    FROM MemberMemberships WHERE membership_id = p_membership_id;
    RETURN IF(v_days < 0, 0, v_days);
END //
DELIMITER ;

-- =========================================
--              VIEWS & QUERIES             
-- =========================================

CREATE VIEW vw_MemberPayments AS
SELECT M.full_name, P.amount, P.payment_date
FROM Members M INNER JOIN Payments P ON M.member_id = P.member_id;

-- Execute final queries
SELECT * FROM vw_MemberPayments;
SELECT member_id, fn_GetRemainingDays(membership_id) AS DaysLeft FROM MemberMemberships;
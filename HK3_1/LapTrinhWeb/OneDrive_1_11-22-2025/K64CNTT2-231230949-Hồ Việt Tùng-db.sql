-- =============================
-- DATABASE: EnglishCenterManagement
-- =============================

CREATE DATABASE EnglishCenterManagement;
GO
USE EnglishCenterManagement;
GO

-- =============================
-- TABLE: account
-- =============================
CREATE TABLE account (
    id NVARCHAR(50) PRIMARY KEY,
    username NVARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) NULL,
    role NVARCHAR(20) CHECK (role IN ('admin', 'student', 'teacher')),
    status BIT NOT NULL DEFAULT 1,
    email VARCHAR(255) NULL,
    created_at DATETIME DEFAULT GETDATE(),
    update_at DATETIME DEFAULT GETDATE()
);
GO

-- =============================
-- TABLE: student
-- =============================
CREATE TABLE student (
    id NVARCHAR(50) PRIMARY KEY,
    account_id NVARCHAR(50) FOREIGN KEY REFERENCES account(id),
    full_name NVARCHAR(255) NOT NULL,
    birth_date DATE,
    phone_number VARCHAR(20),
    address NVARCHAR(255),
    gender NVARCHAR(10)
);
GO

-- =============================
-- TABLE: teacher
-- =============================
CREATE TABLE teacher (
    id NVARCHAR(50) PRIMARY KEY,
    account_id NVARCHAR(50) FOREIGN KEY REFERENCES account(id),
    full_name NVARCHAR(255) NOT NULL,
    specialization NVARCHAR(255),
    qualification NVARCHAR(255),
    phone_number VARCHAR(20),
    address NVARCHAR(255),
    gender NVARCHAR(10)
);
GO

-- =============================
-- TABLE: course
-- =============================
CREATE TABLE course (
    id NVARCHAR(50) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    status BIT NOT NULL DEFAULT 1,
    number_of_lessons INT,
    fee DECIMAL(12,2)
);
GO

-- =============================
-- TABLE: class
-- =============================
CREATE TABLE class (
    id NVARCHAR(50) PRIMARY KEY, --C*6(0~9)
    course_id NVARCHAR(50) FOREIGN KEY REFERENCES course(id),
    status BIT NOT NULL DEFAULT 1,
    name NVARCHAR(255),
    require DECIMAL(5,2),
    target DECIMAL(5,2),
    max_students INT,
    start_date DATE,
    end_date DATE,
    teacher_id NVARCHAR(50) FOREIGN KEY REFERENCES teacher(id)
);
GO

-- =============================
-- TABLE: enrollment
-- =============================
CREATE TABLE enrollment (
    id NVARCHAR(50) PRIMARY KEY, --DKddMMyyyy*4(0~9) vd:DK221120250001
    student_id NVARCHAR(50) FOREIGN KEY REFERENCES student(id),
    course_id NVARCHAR(50) FOREIGN KEY REFERENCES course(id),
    enrollment_date DATE DEFAULT GETDATE(),
    status NVARCHAR(20) CHECK (status IN ('active', 'completed', 'cancelled')),
    created_by NVARCHAR(50)
);
GO

-- =============================
-- TABLE: payment
-- =============================
CREATE TABLE payment (
    id NVARCHAR(50) PRIMARY KEY, --HDddMMyyyy*4(0~9)
    enrollment_id NVARCHAR(50) FOREIGN KEY REFERENCES enrollment(id),
    amount DECIMAL(12,2),
    payment_date DATE DEFAULT GETDATE(),
    fee_collector_id NVARCHAR(50) FOREIGN KEY REFERENCES account(id),
    payer_id NVARCHAR(50) FOREIGN KEY REFERENCES account(id),
    method NVARCHAR(30) CHECK (method IN ('cash', 'bank_transfer', 'credit_card', 'momo')),
    status NVARCHAR(20) CHECK (status IN ('paid', 'pending', 'failed'))
);
GO

-- =============================
-- TABLE: classAssignment
-- =============================
CREATE TABLE classAssignment (
    student_id NVARCHAR(50) FOREIGN KEY REFERENCES student(id), 
    class_id NVARCHAR(50) FOREIGN KEY REFERENCES class(id),
    assigned_date DATE DEFAULT GETDATE(),
    status NVARCHAR(20) CHECK (status IN ('learning', 'pass', 'not pass')),
    PRIMARY KEY (student_id, class_id)
);
GO

-- =============================
-- TABLE: schedule
-- =============================
CREATE TABLE schedule (
    id NVARCHAR(50) PRIMARY KEY, --BH*9(0~9)
    class_id NVARCHAR(50) FOREIGN KEY REFERENCES class(id),
    session_date DATE,
    start_time TIME,
    end_time TIME,
    room NVARCHAR(50),
    teacher_id NVARCHAR(50) FOREIGN KEY REFERENCES teacher(id)
);
GO

-- =============================
-- TABLE: attendance
-- =============================
CREATE TABLE attendance (
    student_id NVARCHAR(50) FOREIGN KEY REFERENCES student(id),
    schedule_id NVARCHAR(50) FOREIGN KEY REFERENCES schedule(id),
    status NVARCHAR(20) CHECK (status IN ('present', 'absent', 'late', 'excused')),
    note NVARCHAR(255),
    teacher_id NVARCHAR(50) FOREIGN KEY REFERENCES teacher(id),
    PRIMARY KEY (student_id, schedule_id)
);
GO

-- =============================
-- TABLE: score
-- =============================
CREATE TABLE score (
    title NVARCHAR(255),
    student_id NVARCHAR(50) FOREIGN KEY REFERENCES student(id),
    class_id NVARCHAR(50) FOREIGN KEY REFERENCES class(id),
    teacher_id NVARCHAR(50) FOREIGN KEY REFERENCES teacher(id),
    lisening DECIMAL(5,2) NULL,
    speaking DECIMAL(5,2) NULL,
    reading DECIMAL(5,2) NULL,
    writing DECIMAL(5,2) NULL,
    type NVARCHAR(20) CHECK (type IN ('assignment', 'test', 'final-test')),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (student_id, class_id, type)
);
GO


-- =============================
-- INSERT INTO account
-- =============================
INSERT INTO account (id, username, password, avatar, role, status, email, created_at, update_at)
VALUES
('U00000000', 'admin01', '123456', NULL, 'admin', 1, 'admin01@ecenter.com', GETDATE(), GETDATE()),
('U00000001', 'student01', '123456', NULL, 'student', 1, 'student01@ecenter.com', GETDATE(), GETDATE()),
('U00000002', 'student02', '123456', NULL, 'student', 1, 'student02@ecenter.com', GETDATE(), GETDATE()),
('U00000003', 'student03', '123456', NULL, 'student', 1, 'student03@ecenter.com', GETDATE(), GETDATE()),
('U00000004', 'teacher01', '123456', NULL, 'teacher', 1, 'teacher01@ecenter.com', GETDATE(), GETDATE()),
('U00000005', 'teacher02', '123456', NULL, 'teacher', 1, 'teacher02@ecenter.com', GETDATE(), GETDATE());
GO

INSERT INTO account (id, username, password, avatar, role, status, email, created_at, update_at)
VALUES
('U00000006', 'student04', '123456', NULL, 'student', 1, 'student04@ecenter.com', GETDATE(), GETDATE()),
('U00000007', 'student05', '123456', NULL, 'student', 1, 'student05@ecenter.com', GETDATE(), GETDATE()),
('U00000008', 'teacher03', '123456', NULL, 'teacher', 1, 'teacher03@ecenter.com', GETDATE(), GETDATE());


-- =============================
-- INSERT INTO student
-- =============================
INSERT INTO student (id, account_id, full_name, birth_date, phone_number, address, gender)
VALUES
('HV22112025001', 'U00000001', N'Nguyễn Văn A', '2004-05-12', '0901111111', N'Hà Nội', N'Nam'),
('HV22112025002', 'U00000002', N'Trần Thị B', '2005-07-20', '0902222222', N'Hồ Chí Minh', N'Nữ'),
('HV22112025003', 'U00000003', N'Lê Văn C', '2003-09-15', '0903333333', N'Đà Nẵng', N'Nam');
GO

INSERT INTO student (id, account_id, full_name, birth_date, phone_number, address, gender)
VALUES
('HV23112025004', 'U00000006', N'Đỗ Minh H', '2006-03-11', '0906666666', N'Hải Phòng', N'Nam'),
('HV23112025005', 'U00000007', N'Võ Thị I', '2004-12-25', '0907777777', N'Cần Thơ', N'Nữ');


-- =============================
-- INSERT INTO teacher
-- =============================
INSERT INTO teacher (id, account_id, full_name, specialization, qualification, phone_number, address, gender)
VALUES
('GV22112025001', 'U00000004', N'Phạm Thị D', N'IELTS', N'Thạc sĩ Ngôn ngữ Anh', '0904444444', N'Hà Nội', N'Nữ'),
('GV22112025002', 'U00000005', N'Hoàng Văn E', N'TOEIC', N'Cử nhân Sư phạm Anh', '0905555555', N'Hồ Chí Minh', N'Nam');
GO

INSERT INTO teacher (id, account_id, full_name, specialization, qualification, phone_number, address, gender)
VALUES
('GV23112025003', 'U00000008', N'Lưu Thảo K', N'IELTS', N'Thạc sĩ TESOL', '0908888888', N'Hải Phòng', N'Nữ');


-- =============================
-- INSERT INTO course
-- =============================
INSERT INTO course (id, name, description, status, number_of_lessons, fee)
VALUES
('KH001', N'IELTS Foundation', N'Khóa học nền tảng IELTS cho người mới bắt đầu', 1, 20, 3500000),
('KH002', N'TOEIC Intensive', N'Luyện thi TOEIC cấp tốc', 1, 15, 2800000);
GO

INSERT INTO course (id, name, description, status, number_of_lessons, fee)
VALUES
('KH003', N'IELTS Advanced', N'Khóa học nâng cao cho mục tiêu 6.5+', 1, 25, 4200000),
('KH004', N'English Communication', N'Giao tiếp tiếng Anh cơ bản đến nâng cao', 1, 18, 2500000);


-- =============================
-- INSERT INTO class
-- =============================
INSERT INTO class (id, course_id, status, name, require, target, max_students, start_date, end_date, teacher_id)
VALUES
('C100001', 'KH001', 1, N'Lớp IELTS Foundation A', 2.5, 4.5, 20, '2025-01-10', '2025-03-10', 'GV22112025001'),
('C100002', 'KH002', 1, N'Lớp TOEIC Intensive B', 300, 600, 25, '2025-02-01', '2025-03-01', 'GV22112025002'),
('C100003', 'KH003', 1, N'Lớp IELTS Advanced C', 4.5, 6.5, 15, '2025-03-05', '2025-05-05', 'GV23112025003');


-- =============================
-- INSERT INTO enrollment
-- =============================
INSERT INTO enrollment (id, student_id, course_id, enrollment_date, status, created_by)
VALUES
('DK231120250001', 'HV23112025004', 'KH001', '2025-11-23', 'active', 'U00000006'),
('DK231120250002', 'HV23112025005', 'KH002', '2025-11-23', 'active', 'U00000007'),
('DK231120250003', 'HV22112025001', 'KH003', '2025-11-23', 'active', 'U00000004');


-- =============================
-- INSERT INTO payment
-- =============================
INSERT INTO payment (id, enrollment_id, amount, payment_date, fee_collector_id, payer_id, method, status)
VALUES
('HD231120250001', 'DK231120250001', 3500000, '2025-11-23', 'U00000004', 'U00000006', 'cash', 'paid'),
('HD231120250002', 'DK231120250002', 2800000, '2025-11-23', 'U00000005', 'U00000007', 'momo', 'paid'),
('HD231120250003', 'DK231120250003', 4200000, '2025-11-23', 'U00000008', 'U00000001', 'bank_transfer', 'pending');


-- =============================
-- INSERT INTO classAssignment
-- =============================
INSERT INTO classAssignment (student_id, class_id, assigned_date, status)
VALUES
('HV23112025004', 'C100001', GETDATE(), 'learning'),
('HV23112025005', 'C100002', GETDATE(), 'learning'),
('HV22112025001', 'C100003', GETDATE(), 'learning');


-- =============================
-- INSERT INTO schedule
-- =============================
INSERT INTO schedule (id, class_id, session_date, start_time, end_time, room, teacher_id)
VALUES
('BH000000001', 'C100001', '2025-01-12', '18:00', '20:00', N'P101', 'GV22112025001'),
('BH000000002', 'C100002', '2025-02-03', '18:00', '20:00', N'P102', 'GV22112025002'),
('BH000000003', 'C100003', '2025-03-07', '18:00', '20:00', N'P201', 'GV23112025003');

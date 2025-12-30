-- =============================
-- DATABASE: EnglishCenterManagement (Oracle)
-- =============================

-- Lưu ý: Oracle không có lệnh CREATE DATABASE như SQL Server
-- Bạn chỉ cần dùng 1 schema và chạy script này trong schema đó.

-- =============================
-- TABLE: account
-- =============================
-- =============================
-- DATABASE: EnglishCenterManagement (Oracle)
-- =============================

-- Lưu ý: Oracle không có lệnh CREATE DATABASE như SQL Server
-- Bạn chỉ cần dùng 1 schema và chạy script này trong schema đó.

-- =============================
-- TABLE: account
-- =============================
CREATE TABLE "account" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "username" NVARCHAR2(100) NOT NULL,
    "password" VARCHAR2(255) NOT NULL,
    "avatar" VARCHAR2(255),
    "role" NVARCHAR2(20) CHECK ("role" IN ('admin', 'student', 'teacher')),
    "status" NUMBER(1) DEFAULT 1 NOT NULL,
    "email" VARCHAR2(255),
    "created_at" DATE DEFAULT SYSDATE,
    "update_at" DATE DEFAULT SYSDATE
);
/


-- =============================
-- TABLE: student
-- =============================
CREATE TABLE "student" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "account_id" NVARCHAR2(50),
    "full_name" NVARCHAR2(255) NOT NULL,
    "birth_date" DATE,
    "phone_number" VARCHAR2(20),
    "address" NVARCHAR2(255),
    "gender" NVARCHAR2(10),
    CONSTRAINT "fk_student_account" FOREIGN KEY ("account_id") REFERENCES "account"("id")
);
/


-- =============================
-- TABLE: teacher
-- =============================
CREATE TABLE "teacher" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "account_id" NVARCHAR2(50),
    "full_name" NVARCHAR2(255) NOT NULL,
    "specialization" NVARCHAR2(255),
    "qualification" NVARCHAR2(255),
    "phone_number" VARCHAR2(20),
    "address" NVARCHAR2(255),
    "gender" NVARCHAR2(10),
    CONSTRAINT "fk_teacher_account" FOREIGN KEY ("account_id") REFERENCES "account"("id")
);
/


-- =============================
-- TABLE: course
-- =============================
CREATE TABLE "course" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "name" NVARCHAR2(255) NOT NULL,
    "description" NVARCHAR2(255),
    "status" NUMBER(1) DEFAULT 1 NOT NULL,
    "number_of_lessons" NUMBER,
    "fee" NUMBER(12,2)
);
/


-- =============================
-- TABLE: class
-- =============================
CREATE TABLE "class" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "course_id" NVARCHAR2(50),
    "status" NUMBER(1) DEFAULT 1 NOT NULL,
    "name" NVARCHAR2(255),
    "require" NUMBER(5,2),
    "target" NUMBER(5,2),
    "max_students" NUMBER,
    "start_date" DATE,
    "end_date" DATE,
    "teacher_id" NVARCHAR2(50),
    CONSTRAINT "fk_class_course" FOREIGN KEY ("course_id") REFERENCES "course"("id"),
    CONSTRAINT "fk_class_teacher" FOREIGN KEY ("teacher_id") REFERENCES "teacher"("id")
);
/


-- =============================
-- TABLE: enrollment
-- =============================
CREATE TABLE "enrollment" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "student_id" NVARCHAR2(50),
    "course_id" NVARCHAR2(50),
    "enrollment_date" DATE DEFAULT SYSDATE,
    "status" NVARCHAR2(20) CHECK ("status" IN ('active', 'completed', 'cancelled')),
    "created_by" NVARCHAR2(50),
    CONSTRAINT "fk_enroll_student" FOREIGN KEY ("student_id") REFERENCES "student"("id"),
    CONSTRAINT "fk_enroll_course" FOREIGN KEY ("course_id") REFERENCES "course"("id")
);
/


-- =============================
-- TABLE: payment
-- =============================
CREATE TABLE "payment" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "enrollment_id" NVARCHAR2(50),
    "amount" NUMBER(12,2),
    "payment_date" DATE DEFAULT SYSDATE,
    "fee_collector_id" NVARCHAR2(50),
    "payer_id" NVARCHAR2(50),
    "method" NVARCHAR2(30) CHECK ("method" IN ('cash', 'bank_transfer', 'credit_card', 'momo')),
    "status" NVARCHAR2(20) CHECK ("status" IN ('paid', 'pending', 'failed')),
    CONSTRAINT "fk_payment_enroll" FOREIGN KEY ("enrollment_id") REFERENCES "enrollment"("id"),
    CONSTRAINT "fk_payment_collector" FOREIGN KEY ("fee_collector_id") REFERENCES "account"("id"),
    CONSTRAINT "fk_payment_payer" FOREIGN KEY ("payer_id") REFERENCES "account"("id")
);
/


-- =============================
-- TABLE: classAssignment
-- =============================
CREATE TABLE "classAssignment" (
    "student_id" NVARCHAR2(50),
    "class_id" NVARCHAR2(50),
    "assigned_date" DATE DEFAULT SYSDATE,
    "status" NVARCHAR2(20) CHECK ("status" IN ('learning', 'pass', 'not pass')),
    CONSTRAINT "pk_classAssign" PRIMARY KEY ("student_id", "class_id"),
    CONSTRAINT "fk_ca_student" FOREIGN KEY ("student_id") REFERENCES "student"("id"),
    CONSTRAINT "fk_ca_class" FOREIGN KEY ("class_id") REFERENCES "class"("id")
);
/


-- =============================
-- TABLE: schedule
-- =============================
CREATE TABLE "schedule" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "class_id" NVARCHAR2(50),
    "session_date" DATE,
    "start_time" DATE,
    "end_time" DATE,
    "room" NVARCHAR2(50),
    "teacher_id" NVARCHAR2(50),
    CONSTRAINT "fk_schedule_class" FOREIGN KEY ("class_id") REFERENCES "class"("id"),
    CONSTRAINT "fk_schedule_teacher" FOREIGN KEY ("teacher_id") REFERENCES "teacher"("id")
);
/


-- =============================
-- TABLE: attendance
-- =============================
CREATE TABLE "attendance" (
    "student_id" NVARCHAR2(50),
    "schedule_id" NVARCHAR2(50),
    "status" NVARCHAR2(20) CHECK ("status" IN ('present', 'absent', 'late', 'excused')),
    "note" NVARCHAR2(255),
    "teacher_id" NVARCHAR2(50),
    CONSTRAINT "pk_attendance" PRIMARY KEY ("student_id", "schedule_id"),
    CONSTRAINT "fk_attend_student" FOREIGN KEY ("student_id") REFERENCES "student"("id"),
    CONSTRAINT "fk_attend_schedule" FOREIGN KEY ("schedule_id") REFERENCES "schedule"("id"),
    CONSTRAINT "fk_attend_teacher" FOREIGN KEY ("teacher_id") REFERENCES "teacher"("id")
);
/


-- =============================
-- TABLE: score
-- =============================
CREATE TABLE "score" (
    "title" NVARCHAR2(255),
    "student_id" NVARCHAR2(50),
    "class_id" NVARCHAR2(50),
    "teacher_id" NVARCHAR2(50),
    "lisening" NUMBER(5,2),
    "speaking" NUMBER(5,2),
    "reading" NUMBER(5,2),
    "writing" NUMBER(5,2),
    "type" NVARCHAR2(20) CHECK ("type" IN ('assignment', 'test', 'final-test')),
    "created_at" DATE DEFAULT SYSDATE,
    "updated_at" DATE DEFAULT SYSDATE,
    CONSTRAINT "pk_score" PRIMARY KEY ("student_id", "class_id", "type"),
    CONSTRAINT "fk_score_student" FOREIGN KEY ("student_id") REFERENCES "student"("id"),
    CONSTRAINT "fk_score_class" FOREIGN KEY ("class_id") REFERENCES "class"("id"),
    CONSTRAINT "fk_score_teacher" FOREIGN KEY ("teacher_id") REFERENCES "teacher"("id")
);

-- =============================
-- INSERT DATA
-- =============================

insert into "account" values ('a001', 'admin01', '123456', null, 'admin', 1, 'admin01@ecenter.com', sysdate, sysdate);
insert into "account" values ('s001', 'student01', '123456', null, 'student', 1, 'student01@ecenter.com', sysdate, sysdate);
insert into "account" values ('s002', 'student02', '123456', null, 'student', 1, 'student02@ecenter.com', sysdate, sysdate);
insert into "account" values ('s003', 'student03', '123456', null, 'student', 1, 'student03@ecenter.com', sysdate, sysdate);
insert into "account" values ('t001', 'teacher01', '123456', null, 'teacher', 1, 'teacher01@ecenter.com', sysdate, sysdate);
insert into "account" values ('t002', 'teacher02', '123456', null, 'teacher', 1, 'teacher02@ecenter.com', sysdate, sysdate);
/

insert into "student" values ('st001', 's001', n'Nguyễn Văn A', to_date('2004-05-12', 'yyyy-mm-dd'), '0901111111', n'Hà Nội', n'Nam');
insert into "student" values ('st002', 's002', n'Trần Thị B', to_date('2005-07-20', 'yyyy-mm-dd'), '0902222222', n'Hồ Chí Minh', n'Nữ');
insert into "student" values ('st003', 's003', n'Lê Văn C', to_date('2003-09-15', 'yyyy-mm-dd'), '0903333333', n'Đà Nẵng', n'Nam');
/

insert into "teacher" values ('te001', 't001', n'Phạm Thị D', n'IELTS', n'Thạc sĩ Ngôn ngữ Anh', '0904444444', n'Hà Nội', n'Nữ');
insert into "teacher" values ('te002', 't002', n'Hoàng Văn E', n'TOEIC', n'Cử nhân Sư phạm Anh', '0905555555', n'Hồ Chí Minh', n'Nam');
/

insert into "course" values ('c001', n'IELTS Foundation', n'Khóa học nền tảng IELTS cho người mới bắt đầu', 1, 20, 3500000);
insert into "course" values ('c002', n'TOEIC Intensive', n'Luyện thi TOEIC cấp tốc', 1, 15, 2800000);
/

insert into "class" values ('cl001', 'c001', 1, n'IELTS F1', 4.0, 5.5, 20, to_date('2025-01-10','yyyy-mm-dd'), to_date('2025-03-30','yyyy-mm-dd'), 'te001');
insert into "class" values ('cl002', 'c002', 1, n'TOEIC I1', 450, 650, 25, to_date('2025-02-01','yyyy-mm-dd'), to_date('2025-04-15','yyyy-mm-dd'), 'te002');
/

insert into "enrollment" values ('en001', 'st001', 'c001', to_date('2025-01-05','yyyy-mm-dd'), 'active', 'a001');
insert into "enrollment" values ('en002', 'st002', 'c001', to_date('2025-01-06','yyyy-mm-dd'), 'completed', 'a001');
insert into "enrollment" values ('en003', 'st003', 'c002', to_date('2025-02-03','yyyy-mm-dd'), 'active', 'a001');
/

insert into "payment" values ('p001', 'en001', 3500000, to_date('2025-01-06','yyyy-mm-dd'), 'a001', 's001', 'cash', 'paid');
insert into "payment" values ('p002', 'en002', 3500000, to_date('2025-01-07','yyyy-mm-dd'), 'a001', 's002', 'bank_transfer', 'paid');
insert into "payment" values ('p003', 'en003', 2800000, to_date('2025-02-04','yyyy-mm-dd'), 'a001', 's003', 'momo', 'paid');
/

insert into "classAssignment" values ('st001', 'cl001', to_date('2025-01-10','yyyy-mm-dd'), 'learning');
insert into "classAssignment" values ('st002', 'cl001', to_date('2025-01-10','yyyy-mm-dd'), 'pass');
insert into "classAssignment" values ('st003', 'cl002', to_date('2025-02-05','yyyy-mm-dd'), 'learning');
/

insert into "schedule" values ('sch001', 'cl001', to_date('2025-01-15','yyyy-mm-dd'), to_date('18:00','hh24:mi'), to_date('20:00','hh24:mi'), n'Room 101', 'te001');
insert into "schedule" values ('sch002', 'cl001', to_date('2025-01-22','yyyy-mm-dd'), to_date('18:00','hh24:mi'), to_date('20:00','hh24:mi'), n'Room 101', 'te001');
insert into "schedule" values ('sch003', 'cl002', to_date('2025-02-10','yyyy-mm-dd'), to_date('18:30','hh24:mi'), to_date('20:30','hh24:mi'), n'Room 202', 'te002');
/

insert into "attendance" values ('st001', 'sch001', 'present', n'Học tốt', 'te001');
insert into "attendance" values ('st002', 'sch001', 'absent', n'Xin phép nghỉ ốm', 'te001');
insert into "attendance" values ('st003', 'sch003', 'late', n'Đến muộn 15 phút', 'te002');
/

insert into "score" values (n'Giữa kỳ IELTS', 'st001', 'cl001', 'te001', 5.0, 5.5, 5.0, 5.0, 'test', sysdate, sysdate);
insert into "score" values (n'Cuối kỳ IELTS', 'st001', 'cl001', 'te001', 5.5, 6.0, 5.5, 5.5, 'final-test', sysdate, sysdate);
insert into "score" values (n'Bài tập 1 TOEIC', 'st003', 'cl002', 'te002', 450, 460, 470, 0, 'assignment', sysdate, sysdate);
/
commit

SELECT "a"."id", "a"."avatar", "a"."created_at", "a"."email", "a"."password", "a"."role", "a"."status", "a"."update_at", "a"."username"
FROM "account" "a"
OFFSET :p_0 ROWS FETCH NEXT :p_1 ROWS ONLY
select * from "schedule"

select * from "account"
DROP TABLE "attendance" CASCADE CONSTRAINTS;
DROP TABLE "score" CASCADE CONSTRAINTS;
DROP TABLE "schedule" CASCADE CONSTRAINTS;
DROP TABLE "classassignment" CASCADE CONSTRAINTS;
DROP TABLE "payment" CASCADE CONSTRAINTS;
DROP TABLE "enrollment" CASCADE CONSTRAINTS;
DROP TABLE "class" CASCADE CONSTRAINTS;
DROP TABLE "course" CASCADE CONSTRAINTS;
DROP TABLE "student" CASCADE CONSTRAINTS;
DROP TABLE "teacher" CASCADE CONSTRAINTS;
DROP TABLE "account" CASCADE CONSTRAINTS;
commit

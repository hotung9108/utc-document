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

CREATE TABLE "student" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "account_id" NVARCHAR2(50),
    "full_name" NVARCHAR2(255) NOT NULL,
    "birth_date" DATE,
    "phone_number" VARCHAR2(20),
    "address" NVARCHAR2(255),
    "gender" NVARCHAR2(10),
    CONSTRAINT "fk_student_account"
        FOREIGN KEY ("account_id") REFERENCES "account"("id")
);

CREATE TABLE "teacher" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "account_id" NVARCHAR2(50),
    "full_name" NVARCHAR2(255) NOT NULL,
    "specialization" NVARCHAR2(255),
    "qualification" NVARCHAR2(255),
    "phone_number" VARCHAR2(20),
    "address" NVARCHAR2(255),
    "gender" NVARCHAR2(10),
    CONSTRAINT "fk_teacher_account"
        FOREIGN KEY ("account_id") REFERENCES "account"("id")
);

CREATE TABLE "course" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "name" NVARCHAR2(255) NOT NULL,
    "description" NVARCHAR2(1000),
    "status" NUMBER(1) DEFAULT 1 NOT NULL,
    "number_of_lessons" NUMBER,
    "fee" NUMBER(12,2)
);

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
    CONSTRAINT "fk_class_course"
        FOREIGN KEY ("course_id") REFERENCES "course"("id"),
    CONSTRAINT "fk_class_teacher"
        FOREIGN KEY ("teacher_id") REFERENCES "teacher"("id")
);

CREATE TABLE "enrollment" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "student_id" NVARCHAR2(50),
    "course_id" NVARCHAR2(50),
    "enrollment_date" DATE DEFAULT SYSDATE,
    "status" NVARCHAR2(20)
        CHECK ("status" IN ('active', 'completed', 'cancelled')),
    "created_by" NVARCHAR2(50),
    CONSTRAINT "fk_enroll_student"
        FOREIGN KEY ("student_id") REFERENCES "student"("id"),
    CONSTRAINT "fk_enroll_course"
        FOREIGN KEY ("course_id") REFERENCES "course"("id")
);

CREATE TABLE "payment" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "enrollment_id" NVARCHAR2(50),
    "amount" NUMBER(12,2),
    "payment_date" DATE DEFAULT SYSDATE,
    "fee_collector_id" NVARCHAR2(50),
    "payer_id" NVARCHAR2(50),
    "method" NVARCHAR2(30)
        CHECK ("method" IN ('cash', 'bank_transfer', 'credit_card', 'momo')),
    "status" NVARCHAR2(20)
        CHECK ("status" IN ('paid', 'pending', 'failed')),
    CONSTRAINT "fk_payment_enroll"
        FOREIGN KEY ("enrollment_id") REFERENCES "enrollment"("id"),
    CONSTRAINT "fk_payment_collector"
        FOREIGN KEY ("fee_collector_id") REFERENCES "account"("id"),
    CONSTRAINT "fk_payment_payer"
        FOREIGN KEY ("payer_id") REFERENCES "account"("id")
);

CREATE TABLE "classassignment" (
    "student_id" NVARCHAR2(50),
    "class_id" NVARCHAR2(50),
    "assigned_date" DATE DEFAULT SYSDATE,
    "status" NVARCHAR2(20)
        CHECK ("status" IN ('learning', 'pass', 'not pass')),
    CONSTRAINT "pk_classassignment"
        PRIMARY KEY ("student_id", "class_id"),
    CONSTRAINT "fk_ca_student"
        FOREIGN KEY ("student_id") REFERENCES "student"("id"),
    CONSTRAINT "fk_ca_class"
        FOREIGN KEY ("class_id") REFERENCES "class"("id")
);

CREATE TABLE "schedule" (
    "id" NVARCHAR2(50) PRIMARY KEY,
    "class_id" NVARCHAR2(50),
    "session_date" DATE,
    "start_time" DATE,
    "end_time" DATE,
    "room" NVARCHAR2(50),
    "teacher_id" NVARCHAR2(50),
    CONSTRAINT "fk_schedule_class"
        FOREIGN KEY ("class_id") REFERENCES "class"("id"),
    CONSTRAINT "fk_schedule_teacher"
        FOREIGN KEY ("teacher_id") REFERENCES "teacher"("id")
);

--CREATE TABLE "schedule" (
--    "id" NVARCHAR2(50) PRIMARY KEY,
--    "class_id" NVARCHAR2(50),
--    "session_date" DATE,
--    "start_time" DATE,
--    "end_time" DATE,
--    "room" NVARCHAR2(50),
--    "teacher_id" NVARCHAR2(50),
--    CONSTRAINT "fk_schedule_class"
--        FOREIGN KEY ("class_id") REFERENCES "class"("id"),
--    CONSTRAINT "fk_schedule_teacher"
--        FOREIGN KEY ("teacher_id") REFERENCES "teacher"("id")
--);

CREATE TABLE "score" (
    "title" NVARCHAR2(255),
    "student_id" NVARCHAR2(50),
    "class_id" NVARCHAR2(50),
    "teacher_id" NVARCHAR2(50),
    "lisening" NUMBER(5,2),
    "speaking" NUMBER(5,2),
    "reading" NUMBER(5,2),
    "writing" NUMBER(5,2),
    "type" NVARCHAR2(20)
        CHECK ("type" IN ('assignment', 'test', 'final-test')),
    "created_at" DATE DEFAULT SYSDATE,
    "updated_at" DATE DEFAULT SYSDATE,
    CONSTRAINT "pk_score"
        PRIMARY KEY ("student_id", "class_id", "type"),
    CONSTRAINT "fk_score_student"
        FOREIGN KEY ("student_id") REFERENCES "student"("id"),
    CONSTRAINT "fk_score_class"
        FOREIGN KEY ("class_id") REFERENCES "class"("id"),
    CONSTRAINT "fk_score_teacher"
        FOREIGN KEY ("teacher_id") REFERENCES "teacher"("id")
);
CREATE TABLE "attendance" (
    "student_id"   NVARCHAR2(50),
    "schedule_id"  NVARCHAR2(50),
    "status"       NVARCHAR2(20)
        CHECK ("status" IN ('present', 'absent', 'late', 'excused')),
    "note"         NVARCHAR2(255),
    "teacher_id"   NVARCHAR2(50),

    CONSTRAINT "pk_attendance"
        PRIMARY KEY ("student_id", "schedule_id"),

    CONSTRAINT "fk_att_student"
        FOREIGN KEY ("student_id")
        REFERENCES "student"("id"),

    CONSTRAINT "fk_att_schedule"
        FOREIGN KEY ("schedule_id")
        REFERENCES "schedule"("id"),

    CONSTRAINT "fk_att_teacher"
        FOREIGN KEY ("teacher_id")
        REFERENCES "teacher"("id")
);

--mockdata
-- 3 admin
select * from "account"
INSERT INTO "account" VALUES ('a001','admin01','123',NULL,'admin',1,'admin01@mail.com',SYSDATE,SYSDATE);
INSERT INTO "account" VALUES ('a002','admin02','123',NULL,'admin',1,'admin02@mail.com',SYSDATE,SYSDATE);
INSERT INTO "account" VALUES ('a003','admin03','123',NULL,'admin',1,'admin03@mail.com',SYSDATE,SYSDATE);

-- 20 student account
INSERT INTO "account"
SELECT
  'sa'||LPAD(LEVEL,3,'0'),
  'student'||LEVEL,
  '123',
  NULL,
  'student',
  1,
  'student'||LEVEL||'@mail.com',
  SYSDATE,
  SYSDATE
FROM dual
CONNECT BY LEVEL <= 20;

INSERT INTO "account"
SELECT
  'ta'||LPAD(LEVEL,3,'0'),
  'teacher'||LEVEL,
  '123',
  NULL,
  'teacher',
  1,
  'teacher'||LEVEL||'@mail.com',
  SYSDATE,
  SYSDATE
FROM dual
CONNECT BY LEVEL <= 11;

INSERT INTO "student"
SELECT
  'st'||LPAD(LEVEL,3,'0'),
  'sa'||LPAD(LEVEL,3,'0'),
  'Student '||LEVEL,
  DATE '2004-01-01' + LEVEL,
  '0900000'||LPAD(LEVEL,3,'0'),
  'Ha Noi',
  CASE WHEN MOD(LEVEL,2)=0 THEN 'female' ELSE 'male' END
FROM dual
CONNECT BY LEVEL <= 20;

INSERT INTO "teacher"
SELECT
  'te'||LPAD(LEVEL,3,'0'),
  'ta'||LPAD(LEVEL,3,'0'),
  'Teacher '||LEVEL,
  'English',
  'Bachelor',
  '0910000'||LPAD(LEVEL,3,'0'),
  'Ha Noi',
  CASE WHEN MOD(LEVEL,2)=0 THEN 'female' ELSE 'male' END
FROM dual
CONNECT BY LEVEL <= 11;

/

-- 11 teacher account

/


INSERT INTO "course" VALUES ('c001','IELTS Foundation','IELTS basic',1,20,3500000);
INSERT INTO "course" VALUES ('c002','TOEIC Intensive','TOEIC fast track',1,15,2800000);
INSERT INTO "course" VALUES ('c003','English Communication','Speaking focus',1,18,3000000);

-- course c001
INSERT INTO "class" VALUES ('cl001','c001',1,'IELTS F1',4.0,5.5,20,DATE '2025-01-10',DATE '2025-03-30','te001');
INSERT INTO "class" VALUES ('cl002','c001',1,'IELTS F2',4.5,6.0,20,DATE '2025-02-01',DATE '2025-04-15','te002');

-- course c002
INSERT INTO "class" VALUES ('cl003','c002',1,'TOEIC I1',450,650,25,DATE '2025-01-15',DATE '2025-03-20','te003');
INSERT INTO "class" VALUES ('cl004','c002',1,'TOEIC I2',500,700,25,DATE '2025-02-10',DATE '2025-04-25','te004');

-- course c003
INSERT INTO "class" VALUES ('cl005','c003',1,'COM 1',0,0,18,DATE '2025-01-05',DATE '2025-03-10','te005');
INSERT INTO "class" VALUES ('cl006','c003',1,'COM 2',0,0,18,DATE '2025-02-01',DATE '2025-04-01','te006');

SELECT COUNT(*) FROM "account";   -- 34
SELECT COUNT(*) FROM "student";   -- 20
SELECT COUNT(*) FROM "teacher";   -- 11
SELECT COUNT(*) FROM "course";    -- 3
SELECT COUNT(*) FROM "class";     -- 6
select * from "attendance"
commit
select * from "account" 
select * from "student"
select * from "teacher"
where 'id' = 'st001'
DESC "account";
DESC "student";

select SYSDATE from DUAL

select * from "attendance"


des dba_role_privs
SELECT * FROM dba_role_privs;


--Lấy danh sách thông tin cơ bản của tất cả học viên nữ.
SELECT "id", "full_name", "birth_date", "phone_number"
FROM "student"
WHERE "gender" = 'female';

--Hiển thị danh sách các khóa học có học phí trên 3,000,000 VNĐ và đang hoạt động.
SELECT "name", "fee", "number_of_lessons"
FROM "course"
WHERE "fee" > 3000000 AND "status" = 1;


--Danh sách học viên theo độ tuổi từ trẻ nhất đến lớn tuổi nhất.
SELECT "full_name", "birth_date", "address"
FROM "student"
ORDER BY "birth_date" DESC;

--Liệt kê các lớp học sắp xếp theo ngày bắt đầu, trùng ngày thì sắp xếp theo tên lớp. 
SELECT "name", "start_date", "max_students"
FROM "class"
ORDER BY "start_date" ASC, "name" ASC;

--Hiển thị tên lớp học, tên khóa học tương ứng và tên giảng viên phụ trách.
SELECT cl."name" AS Class_Name, 
       co."name" AS Course_Name, 
       te."full_name" AS Teacher_Name,
       cl."start_date"
FROM "class" cl
JOIN "course" co ON cl."course_id" = co."id"
JOIN "teacher" te ON cl."teacher_id" = te."id";

--Tìm danh sách các học viên chưa từng đóng bất kỳ khoản tiền nào (hoặc chưa có thông tin trong bảng thanh toán). 
SELECT "id", "full_name"
FROM "student"
WHERE "id" NOT IN (
    SELECT e."student_id"
    FROM "enrollment" e
    JOIN "payment" p ON e."id" = p."enrollment_id"
);

--Tìm những khóa học có tổng số lớp đã mở lớn hơn hoặc bằng hai lớp.
SELECT "course_id", COUNT("id") AS Number_Of_Classes
FROM "class"
GROUP BY "course_id"
HAVING COUNT("id") >= 2;

--Báo cáo danh sách giảng viên, nếu chưa có chuyên môn thì hiển thị là "Chưa cập nhật". 
SELECT "full_name", NVL("specialization", 'Chưa cập nhật') AS "Chuyen_Mon", NVL("phone_number", 'N/A') AS "Lien_Lac"
FROM "teacher";

--Tìm tất cả các tài khoản có email thuộc tên miền "gmail.com" hoặc "mail.com". 
SELECT "username", "email", "role"
FROM "account"
WHERE "email" LIKE '%@gmail.com' OR "email" LIKE '%@mail.com';

--Tìm các lớp học có lịch khai giảng vào các ngày cuối tuần (Thứ 7, Chủ Nhật).
SELECT "name", "start_date", 
       TO_CHAR("start_date", 'Day') AS "Day_Of_Week"
FROM "class"
WHERE TRIM(TO_CHAR("start_date", 'Day')) IN ('Saturday', 'Sunday');

--Với mỗi khóa học, hãy liệt kê tên tất cả các lớp học thuộc khóa đó trên cùng một dòng (cách nhau bởi dấu phẩy). 
SELECT co."name" AS Course_Name,
       LISTAGG(cl."name", ', ') WITHIN GROUP (ORDER BY cl."name") AS List_Of_Classes
FROM "course" co
JOIN "class" cl ON co."id" = cl."course_id"
GROUP BY co."name";

--Tính tuổi hiện tại của học viên dựa trên ngày sinh. 
SELECT "full_name", 
       "birth_date", 
       TRUNC(MONTHS_BETWEEN(SYSDATE, "birth_date") / 12) AS "Age"
FROM "student";

--Dự tính doanh thu tối đa của từng lớp học. 
SELECT cl."name" AS Class_Name, 
       c."fee", 
       cl."max_students",
       (c."fee" * cl."max_students") AS Max_Revenue
FROM "class" cl
JOIN "course" c ON cl."course_id" = c."id";

--Tính tỷ lệ lấp đầy (Fill Rate) của từng lớp học. 
SELECT c."name", 
       c."max_students", 
       COUNT(ca."student_id") AS "Current_Enrollment",
       ROUND((COUNT(ca."student_id") / c."max_students") * 100, 2) || '%' AS "Fill_Rate"
FROM "class" c
LEFT JOIN "classassignment" ca ON c."id" = ca."class_id"
GROUP BY c."name", c."max_students"
ORDER BY "Fill_Rate" DESC;

--Lấy ra thông tin lần đóng tiền gần nhất của mỗi học viên. 
SELECT * FROM (
    SELECT s."full_name", 
           p."amount", 
           p."payment_date",
           ROW_NUMBER() OVER (PARTITION BY s."id" ORDER BY p."payment_date" DESC) as rn
    FROM "payment" p
    JOIN "enrollment" e ON p."enrollment_id" = e."id"
    JOIN "student" s ON e."student_id" = s."id"
) WHERE rn = 1;



--Hàm tính số tiền nợ của học viên.
CREATE OR REPLACE FUNCTION func_get_student_debt(
    p_enrollment_id IN NVARCHAR2
) RETURN NUMBER IS
    v_course_fee NUMBER(12,2);
    v_total_paid NUMBER(12,2);
    v_debt NUMBER(12,2);
BEGIN
    SELECT c."fee" INTO v_course_fee
    FROM "course" c
    JOIN "enrollment" e ON c."id" = e."course_id"
    WHERE e."id" = p_enrollment_id;

    SELECT NVL(SUM("amount"), 0) INTO v_total_paid
    FROM "payment"
    WHERE "enrollment_id" = p_enrollment_id AND "status" = 'paid';

    v_debt := v_course_fee - v_total_paid;

    RETURN v_debt;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1;
END;
/

SELECT func_get_student_debt('enr002') FROM DUAL;

--Hàm kiểm tra số chỗ trống còn lại của lớp học.
CREATE OR REPLACE FUNCTION func_get_class_remaining_slots(
    p_class_id IN NVARCHAR2
) RETURN NUMBER IS
    v_max_students NUMBER;
    v_current_students NUMBER;
BEGIN
    SELECT "max_students" INTO v_max_students
    FROM "class"
    WHERE "id" = p_class_id;

    SELECT COUNT(*) INTO v_current_students
    FROM "classassignment"
    WHERE "class_id" = p_class_id;

    RETURN v_max_students - v_current_students;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; 
END;
/

SELECT func_get_class_remaining_slots('cl002') FROM DUAL;

--Hàm tính điểm trung bình tổng kết của học viên.
CREATE OR REPLACE FUNCTION func_calc_final_score(
    p_student_id IN NVARCHAR2,
    p_class_id IN NVARCHAR2
) RETURN NUMBER IS
    v_avg_score NUMBER(5,2);
BEGIN
    -- Tính trung bình cộng 4 kỹ năng của bài final-test
    SELECT (NVL("lisening",0) + NVL("speaking",0) + NVL("reading",0) + NVL("writing",0)) / 4
    INTO v_avg_score
    FROM "score"
    WHERE "student_id" = p_student_id 
      AND "class_id" = p_class_id 
      AND "type" = 'final-test';

    RETURN ROUND(v_avg_score, 2);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Chưa có điểm
END;
/

SELECT func_calc_final_score('st001', 'cl001') AS Diem_Trung_Binh FROM DUAL;
SELECT func_calc_final_score('st002', 'cl001') AS Diem_Trung_Binh FROM DUAL;

--Thủ tục đăng ký học viên vào lớp (Có kiểm tra điều kiện).
CREATE OR REPLACE PROCEDURE proc_enroll_student_to_class(
    p_student_id IN NVARCHAR2,
    p_class_id IN NVARCHAR2,
    p_admin_id IN NVARCHAR2
) IS
    v_slots NUMBER;
    v_course_id NVARCHAR2(50);
    v_enroll_id NVARCHAR2(50);
    v_count NUMBER;
    
    v_max_id NVARCHAR2(50);
    v_num_part NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM "classassignment"
    WHERE "student_id" = p_student_id AND "class_id" = p_class_id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Lỗi: Học viên ' || p_student_id || ' đã đăng ký lớp này rồi!');
    END IF;

    v_slots := func_get_class_remaining_slots(p_class_id);
    IF v_slots <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Lỗi: Lớp học đã đầy!');
    END IF;

    BEGIN
        SELECT "course_id" INTO v_course_id FROM "class" WHERE "id" = p_class_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'Lỗi: Mã lớp học không tồn tại!');
    END;

    SELECT MAX("id") INTO v_max_id FROM "enrollment";

    IF v_max_id IS NULL THEN
        v_enroll_id := 'enr001';
    ELSE
        v_num_part := TO_NUMBER(SUBSTR(v_max_id, 4)) + 1;
        
        v_enroll_id := 'enr' || LPAD(v_num_part, 3, '0');
    END IF;

    INSERT INTO "enrollment" ("id", "student_id", "course_id", "enrollment_date", "status", "created_by")
    VALUES (v_enroll_id, p_student_id, v_course_id, SYSDATE, 'active', p_admin_id);

    INSERT INTO "classassignment" ("student_id", "class_id", "assigned_date", "status")
    VALUES (p_student_id, p_class_id, SYSDATE, 'learning');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Đăng ký thành công! Mã hồ sơ mới: ' || v_enroll_id);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Lỗi hệ thống: ' || SQLERRM);
END;
/

EXEC proc_enroll_student_to_class('st008', 'cl001', 'a001');
select * from "enrollment"

--Thủ tục thanh toán học phí.
CREATE OR REPLACE PROCEDURE proc_make_payment(
    p_enrollment_id IN NVARCHAR2,
    p_amount_input IN NUMBER,
    p_method IN NVARCHAR2,
    p_collector_id IN NVARCHAR2,
    p_payer_id IN NVARCHAR2
) IS
    v_debt_before NUMBER;    
    v_debt_after NUMBER;
    v_actual_amount NUMBER;    
    v_refund_amount NUMBER;    
    
    v_payment_id NVARCHAR2(50);
    v_max_id NVARCHAR2(50);
    v_num_part NUMBER;
    v_check_exists NUMBER;
    v_status_pay NVARCHAR2(20);
BEGIN
    IF p_amount_input <= 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Lỗi: Số tiền thanh toán phải lớn hơn 0!');
    END IF;

    SELECT COUNT(*) INTO v_check_exists FROM "account" WHERE "id" = p_collector_id;
    IF v_check_exists = 0 THEN RAISE_APPLICATION_ERROR(-20006, 'Lỗi: Người thu tiền không tồn tại!'); END IF;

    SELECT COUNT(*) INTO v_check_exists FROM "account" WHERE "id" = p_payer_id;
    IF v_check_exists = 0 THEN RAISE_APPLICATION_ERROR(-20007, 'Lỗi: Người đóng tiền không tồn tại!'); END IF;

    v_debt_before := func_get_student_debt(p_enrollment_id);

    IF v_debt_before <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Thông báo: Học viên này đã hoàn thành học phí. Không cần đóng thêm.');
        RETURN;
    END IF;

    IF p_amount_input > v_debt_before THEN
        v_actual_amount := v_debt_before; 
        v_refund_amount := p_amount_input - v_debt_before; 
        v_status_pay := 'paid';
        
        DBMS_OUTPUT.PUT_LINE('CẢNH BÁO: Khách đóng thừa tiền!');
        DBMS_OUTPUT.PUT_LINE('- Số tiền nợ: ' || TO_CHAR(v_debt_before, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE('- Khách đưa:  ' || TO_CHAR(p_amount_input, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE('-> Hệ thống chỉ thu: ' || TO_CHAR(v_actual_amount, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE('-> Vui lòng trả lại khách: ' || TO_CHAR(v_refund_amount, '999,999,999'));
    ELSE
        v_actual_amount := p_amount_input;
        v_refund_amount := 0;
        
        IF v_actual_amount = v_debt_before THEN
            v_status_pay := 'paid';
        ELSE
            v_status_pay := 'pending';
        END IF;
    END IF;

    SELECT MAX("id") INTO v_max_id FROM "payment";
    IF v_max_id IS NULL THEN
        v_payment_id := 'pay001';
    ELSE
        v_num_part := TO_NUMBER(REGEXP_SUBSTR(v_max_id, '\d+')) + 1;
        v_payment_id := 'pay' || LPAD(v_num_part, 3, '0');
    END IF;

    INSERT INTO "payment" ("id", "enrollment_id", "amount", "payment_date", "fee_collector_id", "payer_id", "method", "status")
    VALUES (v_payment_id, p_enrollment_id, v_actual_amount, SYSDATE, p_collector_id, p_payer_id, p_method, v_status_pay);

    IF v_status_pay = 'paid' THEN
        UPDATE "payment"
        SET "status" = 'paid'
        WHERE "enrollment_id" = p_enrollment_id AND "status" = 'pending';
        
        UPDATE "enrollment"
        SET "status" = 'active' 
        WHERE "id" = p_enrollment_id;
        
        DBMS_OUTPUT.PUT_LINE('-> Đã cập nhật tất cả các khoản pending cũ thành PAID.');
    END IF;

    COMMIT;
    
    v_debt_after := v_debt_before - v_actual_amount;
    
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Giao dịch thành công! Mã: ' || v_payment_id);
    IF v_debt_after = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Trạng thái: ĐÃ HOÀN THÀNH HỌC PHÍ (Cleared)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Trạng thái: CÒN NỢ ' || TO_CHAR(v_debt_after, '999,999,999') || ' VNĐ');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Lỗi hệ thống: ' || SQLERRM);
END;
/

select * from "payment"

EXEC proc_make_payment_v2('enr001', 1000000, 'cash', 'a001', 'sa001');
EXEC proc_make_payment_v2('enr002', 5000000, 'cash', 'a001', 'sa001');


--Thủ tục xét duyệt qua môn.
CREATE OR REPLACE PROCEDURE proc_evaluate_student_status(
    p_student_id IN NVARCHAR2,
    p_class_id IN NVARCHAR2
) IS
    v_avg_score NUMBER;
BEGIN
    v_avg_score := func_calc_final_score(p_student_id, p_class_id);

    IF v_avg_score >= 5.0 THEN
        UPDATE "classassignment"
        SET "status" = 'pass'
        WHERE "student_id" = p_student_id AND "class_id" = p_class_id;
        
        DBMS_OUTPUT.PUT_LINE('Học viên ĐẬU với điểm TB: ' || v_avg_score);
    ELSE
        UPDATE "classassignment"
        SET "status" = 'not pass'
        WHERE "student_id" = p_student_id AND "class_id" = p_class_id;
        
        DBMS_OUTPUT.PUT_LINE('Học viên TRƯỢT với điểm TB: ' || v_avg_score);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Lỗi xét duyệt: ' || SQLERRM);
END;
/

EXEC proc_evaluate_student_status('st001', 'cl001');

SET SERVEROUTPUT ON;


--Cursor tính thưởng giảng viên.
DECLARE
    CURSOR c_teacher_performance IS
        SELECT t."full_name",
               COUNT(c."id") AS total_classes,
               SUM(c."max_students") AS total_capacity,
               (SELECT COUNT(*) 
                FROM "classassignment" ca 
                JOIN "class" cl ON ca."class_id" = cl."id" 
                WHERE cl."teacher_id" = t."id") AS total_actual_students
        FROM "teacher" t
        JOIN "class" c ON t."id" = c."teacher_id"
        GROUP BY t."id", t."full_name";

    v_bonus NUMBER;
    v_base_bonus_per_class CONSTANT NUMBER := 500000; 
    v_student_bonus CONSTANT NUMBER := 20000;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== BẢNG TÍNH THƯỞNG GIẢNG VIÊN ===');
    
    FOR r_tea IN c_teacher_performance LOOP
        v_bonus := (r_tea.total_classes * v_base_bonus_per_class) + 
                   (r_tea.total_actual_students * v_student_bonus);
                   
        DBMS_OUTPUT.PUT_LINE('Giáo viên: ' || r_tea."full_name");
        DBMS_OUTPUT.PUT_LINE(' - Số lớp phụ trách: ' || r_tea.total_classes);
        DBMS_OUTPUT.PUT_LINE(' - Tổng số học viên: ' || r_tea.total_actual_students);
        DBMS_OUTPUT.PUT_LINE(' -> TIỀN THƯỞNG: ' || TO_CHAR(v_bonus, '999,999,999') || ' VNĐ');
        DBMS_OUTPUT.PUT_LINE('...................................');
    END LOOP;
END;
/

--Cursor quét công nợ cả hệ thống
DECLARE
    CURSOR c_debtors IS
        SELECT s."full_name", 
               s."phone_number",
               co."name" AS course_name,
               co."fee" AS course_fee,
               NVL(SUM(p."amount"), 0) AS total_paid
        FROM "enrollment" e
        JOIN "student" s ON e."student_id" = s."id"
        JOIN "course" co ON e."course_id" = co."id"
        LEFT JOIN "payment" p ON e."id" = p."enrollment_id" AND p."status" = 'paid'
        WHERE e."status" = 'active' 
        GROUP BY s."full_name", s."phone_number", co."name", co."fee"
        HAVING NVL(SUM(p."amount"), 0) < co."fee";

BEGIN
    DBMS_OUTPUT.PUT_LINE('=== BÁO CÁO CÔNG NỢ HỌC PHÍ ===');
    
    FOR r_debt IN c_debtors LOOP
        DBMS_OUTPUT.PUT_LINE('Học viên: ' || r_debt."full_name" || ' (SĐT: ' || r_debt."phone_number" || ')');
        DBMS_OUTPUT.PUT_LINE(' - Khóa học: ' || r_debt.course_name);
        DBMS_OUTPUT.PUT_LINE(' - Học phí: ' || TO_CHAR(r_debt.course_fee, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE(' - Đã đóng: ' || TO_CHAR(r_debt.total_paid, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE(' -> CÒN NỢ: ' || TO_CHAR(r_debt.course_fee - r_debt.total_paid, '999,999,999') || ' VNĐ');
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    END LOOP;
END;
/

--Cursor báo cáo học viên cần kèm
DECLARE
    CURSOR c_low_score_students (p_class_id NVARCHAR2) IS
        SELECT s."full_name", sc."lisening", sc."speaking", sc."reading", sc."writing"
        FROM "score" sc
        JOIN "student" s ON sc."student_id" = s."id"
        WHERE sc."class_id" = p_class_id 
          AND sc."type" = 'final-test';

    v_rec c_low_score_students%ROWTYPE;
    v_avg NUMBER;
    v_found BOOLEAN := FALSE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- DANH SÁCH HỌC VIEN CẦN PHỤ ĐẠO (Lớp cl001) ---');
    
    OPEN c_low_score_students('cl001');
    
    LOOP
        FETCH c_low_score_students INTO v_rec;
        EXIT WHEN c_low_score_students%NOTFOUND;
        
        v_avg := (v_rec."lisening" + v_rec."speaking" + v_rec."reading" + v_rec."writing") / 4;
        
        IF v_avg < 5.0 OR 
           v_rec."lisening" < 4.0 OR v_rec."speaking" < 4.0 OR 
           v_rec."reading" < 4.0 OR v_rec."writing" < 4.0 THEN
           
            DBMS_OUTPUT.PUT_LINE('Học viên: ' || v_rec."full_name");
            DBMS_OUTPUT.PUT_LINE(' - Điểm TB: ' || ROUND(v_avg, 2));
            DBMS_OUTPUT.PUT_LINE(' - Chi tiết: L:' || v_rec."lisening" || ' S:' || v_rec."speaking" || 
                                 ' R:' || v_rec."reading" || ' W:' || v_rec."writing");
            DBMS_OUTPUT.PUT_LINE('-----------------------------------');
            v_found := TRUE;
        END IF;
    END LOOP;
    
    IF NOT v_found THEN
        DBMS_OUTPUT.PUT_LINE('Không có học viên nào bị điểm kém trong lớp này.');
    END IF;
    
    CLOSE c_low_score_students;
END;
/

--Thủ tục đăng ký và tạo công nợ.
CREATE OR REPLACE PROCEDURE proc_enroll_with_payment(
    p_student_id IN NVARCHAR2,
    p_course_id IN NVARCHAR2,
    p_admin_id IN NVARCHAR2
) IS
    v_enroll_id NVARCHAR2(50);
    v_payment_id NVARCHAR2(50);
    v_fee NUMBER(12,2);
    v_payer_acc_id NVARCHAR2(50);
    v_num_part NUMBER;
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM "enrollment" 
    WHERE "student_id" = p_student_id AND "course_id" = p_course_id AND "status" = 'active';
    IF v_count > 0 THEN RAISE_APPLICATION_ERROR(-20011, 'Học viên đã đăng ký khóa này!'); END IF;

    BEGIN
        SELECT "fee" INTO v_fee FROM "course" WHERE "id" = p_course_id;
        SELECT "account_id" INTO v_payer_acc_id FROM "student" WHERE "id" = p_student_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20013, 'Không tìm thấy thông tin Khóa học hoặc Học viên!');
    END;

    SELECT MAX(TO_NUMBER(REGEXP_SUBSTR("id", '\d+'))) INTO v_num_part 
    FROM "enrollment" WHERE "id" LIKE 'enr%';
    
    v_enroll_id := 'enr' || LPAD(NVL(v_num_part, 0) + 1, 3, '0');

    SELECT MAX(TO_NUMBER(REGEXP_SUBSTR("id", '\d+'))) INTO v_num_part 
    FROM "payment" WHERE "id" LIKE 'pay%';
    
    v_payment_id := 'pay' || LPAD(NVL(v_num_part, 0) + 1, 3, '0');

    INSERT INTO "enrollment" ("id", "student_id", "course_id", "enrollment_date", "status", "created_by")
    VALUES (v_enroll_id, p_student_id, p_course_id, SYSDATE, 'active', p_admin_id);

    INSERT INTO "payment" ("id", "enrollment_id", "amount", "payment_date", "fee_collector_id", "payer_id", "method", "status")
    VALUES (v_payment_id, v_enroll_id, v_fee, SYSDATE, p_admin_id, v_payer_acc_id, 'cash', 'pending');

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Đăng ký xong! Mã ĐK: ' || v_enroll_id || ' - Hóa đơn chờ: ' || v_payment_id);
EXCEPTION
    WHEN OTHERS THEN ROLLBACK; DBMS_OUTPUT.PUT_LINE('Lỗi: ' || SQLERRM);
END;
/

--Thủ tục hủy đăng ký và hủy công nợ.
CREATE OR REPLACE PROCEDURE proc_cancel_enrollment(
    p_enrollment_id IN NVARCHAR2
) IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM "enrollment" WHERE "id" = p_enrollment_id;
    IF v_count = 0 THEN 
        RAISE_APPLICATION_ERROR(-20012, 'Mã đăng ký không tồn tại!'); 
    END IF;

    DELETE FROM "payment" 
    WHERE "enrollment_id" = p_enrollment_id;

    DELETE FROM "enrollment" 
    WHERE "id" = p_enrollment_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Đã xóa vĩnh viễn hồ sơ đăng ký ' || p_enrollment_id || ' và toàn bộ lịch sử thanh toán liên quan.');

EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE('Lỗi khi xóa dữ liệu: ' || SQLERRM);
END;
/

select * from "payment"
select * from "enrollment"

EXEC proc_enroll_with_payment('st020', 'c001', 'a001');
EXEC proc_cancel_enrollment('enr009');








SHOW PARAMETER;
ALTER TABLESPACE DATA1 ALTER DATAFILE 'C:\USERS\HOTUNG\APP\ORADATA\ORCL\DATA100.DBF' SIZE 200M  AUTOEXTEND ON NEXT 1M MAXSIZE 500M;
ALTER DATABASE DATAFILE 'C:\USERS\HOTUNG\APP\ORADATA\ORCL\DATA100.DBF' AUTOEXTEND ON NEXT 1M MAXSIZE 500M;
ALTER DATABASE DATAFILE 'C:\USERS\HOTUNG\APP\ORADATA\ORCL\DATA100.DBF' RESIZE 20M;

SELECT * FROM DBA_TABLESPACES;
SELECT * FROM DBA_DATA_FILES;

CREATE TABLESPACE ts_data
DATAFILE '/u01/oradata/ORCL/ts_data01.dbf'
SIZE 10G
AUTOEXTEND ON
NEXT 1G
MAXSIZE 100G;


select * from "account"







-- 1. Tạo Role cho Quản trị viên (Toàn quyền)
CREATE ROLE role_admin;

-- 2. Tạo Role cho Giáo viên (Quyền hạn chế)
CREATE ROLE role_teacher;

-- 3. Tạo Role cho Học viên (Quyền xem)
CREATE ROLE role_student;

-- Cấp quyền đăng nhập
GRANT CREATE SESSION TO role_admin;

-- Cấp quyền thao tác trên các bảng quan trọng (Ví dụ đại diện)
GRANT SELECT ANY TABLE TO role_admin;
GRANT UPDATE ANY TABLE TO role_admin;
GRANT INSERT ANY TABLE TO role_admin;
GRANT DELETE ANY TABLE TO role_admin;


-- Cấp quyền đăng nhập
GRANT CREATE SESSION TO role_teacher;
 
-- Chỉ cho phép XEM danh sách học viên và lớp học (Không được sửa hồ sơ học viên)
GRANT SELECT ON "student" TO role_teacher;
GRANT SELECT ON "class" TO role_teacher;
 
-- Cho phép CHẤM ĐIỂM và ĐIỂM DANH (Được Insert và Update)
GRANT SELECT, INSERT ON "score" TO role_teacher;
-- Chỉ cho phép UPDATE cột listening, speaking,... trên bảng score
GRANT UPDATE (listening, speaking, reading, writing) 
ON "score" 
TO role_teacher;
GRANT SELECT, INSERT, UPDATE ON "attendance" TO role_teacher;

--Cấp quyền đăng nhập
GRANT CREATE SESSION TO role_student;
 
-- Chỉ cho phép XEM thời khóa biểu và điểm
GRANT SELECT ON "course" TO role_student;
GRANT SELECT ON "schedule" TO role_student;
GRANT SELECT ON "score" TO role_student;

-- 1. Tạo user cho Giáo viên mới (Cô Hằng)
CREATE USER te_hangnt IDENTIFIED BY matkhau123
DEFAULT TABLESPACE USERS
QUOTA 50M ON USERS; -- Cấp 50MB đất để lưu dữ liệu cá nhân
 
-- 2. Gán Role Giáo viên cho cô Hằng
GRANT role_teacher TO te_hangnt;

-- 1. Tạo user cho Học viên (Bạn Nam)
CREATE USER st_namnv IDENTIFIED BY matkhau123
DEFAULT TABLESPACE USERS; 
-- Lưu ý: Học viên thường không cần QUOTA vì họ không được quyền INSERT bảng nào cả, 
-- họ chỉ SELECT dữ liệu do Admin tạo sẵn.
 
-- 2. Gán Role Học viên
GRANT role_student TO st_namnv;

ALTER USER st_namnv ACCOUNT LOCK;

ALTER USER st_namnv ACCOUNT UNLOCK;


ALTER USER te_hangnt IDENTIFIED BY MatKhauMoi2025;
-- CASCADE để xóa luôn các bảng/dữ liệu rác nếu thầy Tuấn lỡ tạo riêng
DROP USER te_tuanpa CASCADE;
GRANT CREATE USER TO acc_truongphong WITH ADMIN OPTION;
GRANT SELECT ON "payment" TO acc_truongphong WITH GRANT OPTION;

GRANT EXECUTE ON proc_make_payment TO QUANLY;

GRANT SELECT ON "course" TO PUBLIC;


SELECT username, account_status FROM dba_users;



SELECT role FROM dba_roles;



SELECT * FROM dba_role_privs;


SELECT * FROM dba_sys_privs;
SELECT * FROM dba_tab_privs;


desc "classassignment"
select * from "classassignment"
select "class_id", count("student_id") from "classassignment"
group by "class_id"

select * from "account"
where "account"."id" = 'a001'
update "account" 
Set "password" = 2
where "account"."id" = 'a001'
commit
select * from employees;

-- 1
select * from JOBS
where jobs.min_salary >= 10000

-- 2
select * from EMPLOYEES inner join JOB_HISTORY on EMPLOYEES.EMPLOYEE_ID = JOB_HISTORY.EMPLOYEE_ID
where EXTRACT(YEAR FROM HIRE_DATE) > 2002 and EXTRACT(YEAR FROM HIRE_DATE) < 2005

SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN DATE '2002-01-01' AND DATE '2005-12-31';

-- 3
select * from EMPLOYEES join JOBS on EMPLOYEES.JOB_ID = JOBS.JOB_ID
where JOBS.JOB_ID in ('IT_Programmer', 'Sales Man');

SELECT E.FIRST_NAME, E.HIRE_DATE
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE J.JOB_TITLE IN ('IT Programmer', 'Sales Man');

--4
select * from EMPLOYEES inner join JOB_HISTORY on EMPLOYEES.EMPLOYEE_ID = JOB_HISTORY.EMPLOYEE_ID
WHERE JOB_HISTORY.HIRE_DATE > TO_DATE('2008-01-01', 'YYYY-MM-DD');

-- 5 :Display details of employee with ID 150 or 160. 
SELECT * FROM EMPLOYEES 
where employee_id in (150, 160)

--6. Display first name, salary, commission pct, and hire date for employees with salary 
--less than 10000. 
SELECT first_name, salary, commission_pct, hire_date from employees
where salary < 10000

--7. Display job Title, the difference between minimum and maximum salaries for jobs 
--with max salary in the range 10000 to 20000. 
SELECT job_title, max_salary - min_salary AS diff
FROM JOBS
WHERE max_salary BETWEEN 10000 AND 20000;

--8. Display first name, salary, and round the salary to thousands. 
SELECT first_name, round(salary, -3) AS round_salary
FROM employees

--9. Display details of jobs in the descending order of the title. 
SELECT * FROM JOBS
ORDER BY job_title DESC;

--10. Display employees where the first name or last name starts with S. 
SELECT *
FROM employees
WHERE first_name LIKE 'S%' AND last_name LIKE 'S%'

--11. Display employees who joined in the month of May. 
SELECT * FROM employees
WHERE TO_CHAR(HIRE_DATE, 'MM') = '05';

--12. Display details of the employees where commission percentage is null and salary in 
--the range 5000 to 10000 and department is 30. 
SELECT * FROM EMPLOYEES
WHERE commission_pct IS NULL AND salary BETWEEN 5000 AND 10000 AND department_id = 30

--13. Display first name and date of first salary of the employees. 

--14. Display first name and experience of the employees. 

--15. Display first name of employees who joined in 2001.
select * from EMPLOYEES
where TO_CHAR(HIRE_DATE, 'YYYY') = 2001

--16. Display first name and last name after converting the first letter of each name to 
--upper case and the rest to lower case. 
select INITCAP(first_name), INITCAP(last_name) from EMPLOYEES


--17. Display the first word in job title. 


--18. Display the length of first name for employees where last name contain character ‘b’ 
--after 3rd position. 
SELECT FIRST_NAME, LENGTH(FIRST_NAME) AS NAME_LENGTH
FROM EMPLOYEES
WHERE INSTR(LOWER(LAST_NAME), 'b', 4) > 0;

--19. Display first name in upper case and email address in lower case for employees 
--where the first name and email address are same irrespective of the case. 
SELECT UPPER(FIRST_NAME) AS FIRST_NAME,
       LOWER(EMAIL) AS EMAIL
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME) = UPPER(EMAIL);

--20. Display employees who joined in the current year. 
SELECT * FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'yyyy') = TO_CHAR(SYSDATE, 'yyyy')

--21. Display the number of days between system date and 1st January 2011.
SELECT trunc(SYSDATE - DATE '2011-01-01') AS days_diff
FROM dual;

--22. Display how many employees joined in each month of the current year. 
SELECT 
--23. Display manager ID and number of employees managed by the manager. 
--24. Display number of employees joined after 15th of the month. 
--25. Display the country ID and number of cities we have in the country. 
--26. Display average salary of employees in each department who have commission 
--percentage. 
--27. Display job ID, number of employees, sum of salary, and difference between highest 
--salary and lowest salary of the employees of the job. 
--28. Display job ID for jobs with average salary more than 10000. 
--29. Display years in which more than 10 employees joined. 
--30. Display departments in which more than five employees have commission 
--percentage. 
--31. Display employee ID for employees who did more than one job in the past. 
--32. Display job ID of jobs that were done by more than 3 employees for more than 100 
--days. 
--33. Display department ID, year, and Number of employees joined. 
--34. Display departments where any manager is managing more than 5 employees. 
--35. Change salary of employee 115 to 8000 if the existing salary is less than 6000. 
--36. Insert a new employee into employees with all the required details. 
--37. Delete department 20. 
--38. Change job ID of employee 110 to IT_PROG if the employee belongs to department 
--10 and the existing job ID does not start with IT. 
--39. Insert a row into departments table with manager ID 120 and location ID in any 
--location ID for city Tokyo. 
--40. Display department name and number of employees in the department. 
--41. Display job title, employee ID, number of days between ending date and starting 
--date for all jobs in department 30 from job history. 
--42. Display department name and manager first name. 
--43. Display department name, manager name, and city. 
--44. Display country name, city, and department name. 
--45. Display job title, department name, employee last name, starting date for all jobs 
--from 2000 to 2005. 
--46. Display job title and average salary of employees 
--47. Display job title, employee name, and the difference between maximum salary for 
--the job and salary of the employee. 
--48. Display last name, job title of employees who have commission percentage and 
--belongs to department 30. 
--49. Display details of jobs that were done by any employee who is currently drawing 
--more than 15000 of salary. 
--50. Display department name, manager name, and salary of the manager for all 
--managers whose experience is more than 5 years. 
--51. Display employee name if the employee joined before his manager. 
--52. Display employee name, job title for the jobs employee did in the past where the job 
--was done less than six months. 
--53. Display employee name and country in which he is working. 
--54. Display department name, average salary and number of employees with 
--commission within the department. 
--55. Display the month in which more than 5 employees joined in any department located 
--in Sydney. 
--56. Display details of departments in which the maximum salary is more than 10000. 
--57. Display details of departments managed by ‘Smith’. 
--58. Display jobs into which employees joined in the current year. 
--59. Display employees who did not do any job in the past. 
--60. Display job title and average salary for employees who did a job in the past. 
--61. Display country name, city, and number of departments where department has more 
--than 5 employees. 
--62. Display details of manager who manages more than 5 employees. 
--63. Display employee name, job title, start date, and end date of past jobs of all 
--employees with commission percentage null. 
--64. Display the departments into which no employee joined in last two years. 
--65. Display the details of departments in which the max salary is greater than 10000 for 
--employees who did a job in the past. 
--66. Display details of current job for employees who worked as IT Programmers in the 
--past. 
--67. Display the details of employees drawing the highest salary in the department. 
--68. Display the city of employee whose employee ID is 105. 
--69. Display third highest salary of all employees

--CREATE OR REPLACE PROCEDURE LietKeNhanVien_TheoPhong(
--    p_dept_name IN VARCHAR2
--) AS
--    v_dept_id   DEPARTMENTS.DEPARTMENT_ID%TYPE;
--    v_count_emp NUMBER;
--BEGIN
--    -- Kiểm tra phòng ban có tồn tại không
--    SELECT DEPARTMENT_ID
--    INTO v_dept_id
--    FROM DEPARTMENTS
--    WHERE UPPER(DEPARTMENT_NAME) = UPPER(p_dept_name);
--
--    -- Đếm số nhân viên trong phòng ban
--    SELECT COUNT(*)
--    INTO v_count_emp
--    FROM EMPLOYEES
--    WHERE DEPARTMENT_ID = v_dept_id;
--
--    IF v_count_emp = 0 THEN
--        DBMS_OUTPUT.PUT_LINE('Không có nhân viên trong phòng ' || p_dept_name);
--    ELSE
--        DBMS_OUTPUT.PUT_LINE('Danh sách nhân viên trong phòng ' || p_dept_name || ':');
--        FOR rec IN (
--            SELECT FIRST_NAME || ' ' || LAST_NAME AS fullname
--            FROM EMPLOYEES
--            WHERE DEPARTMENT_ID = v_dept_id
--        ) LOOP
--            DBMS_OUTPUT.PUT_LINE('- ' || rec.fullname);
--        END LOOP;
--    END IF;
--
--EXCEPTION
--    WHEN NO_DATA_FOUND THEN
--        DBMS_OUTPUT.PUT_LINE('Tên phòng ban chưa chính xác');
--END LietKeNhanVien_TheoPhong;
--/
--
--SET SERVEROUTPUT ON;
--
--BEGIN
--    LietKeNhanVien_TheoPhong('IT');   -- tên phòng ban hợp lệ, có NV
--    LietKeNhanVien_TheoPhong('XYZ');  -- tên phòng ban không tồn tại
--END;
--/
--
--DROP PROCEDURE LietKeNhanVien_TheoPhong;
CREATE OR REPLACE PROCEDURE LietKeNhanVien_TheoPhongBan(
    TenPhongBan in varchar2
)
as 
    IdPhongBan DEPARTMENTS.DEPARTMENT_ID%TYPE;
    DemNhanVien number;
BEGIN
    SELECT DEPARTMENT_ID
    into IdPhongBan
    from DEPARTMENTS
    WHERE UPPER(DEPARTMENT_NAME) = UPPER(TenPhongBan);
    
    SELECT COUNT(*)
    INTO DemNhanVien
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = IdPhongBan;
    IF DemNhanVien = 0 then
        DBMS_OUTPUT.PUT_LINE('Không có nhân viên trong phòng'|| TenPhongBan);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Danh sách nhân viên trong phòng ' || TenPhongBan || ':');
        FOR rec IN (
            SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
            FROM EMPLOYEES
            WHERE DEPARTMENT_ID = IdPhongBan
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(rec.EMPLOYEE_ID || ' - ' || rec.FIRST_NAME || ' ' || rec.LAST_NAME);
        END LOOP;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Tên phòng ban chưa chính xác');
END LietKeNhanVien_TheoPhongBan;

SET SERVEROUTPUT ON;

BEGIN
    LietKeNhanVien_TheoPhongBan('IT');  
    LietKeNhanVien_TheoPhongBan('XYZ'); 
    LietKeNhanVien_TheoPhongBan('SALES');
END;
/
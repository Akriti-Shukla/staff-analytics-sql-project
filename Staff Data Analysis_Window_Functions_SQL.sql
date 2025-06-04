-- Let's create a database named Staff_Data
CREATE DATABASE Staff_Data;
USE Staff_Data;

-- Now, let's create a staff table

DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- Let's verify the table structure

DESC staff;

-- Now, it's time to insert some values into the table

INSERT INTO staff (first_name, last_name, department, position, salary, hire_date)
VALUES
('Ana', 'Shane', 'Sales', 'Sales Executive', 50000.00, '2020-01-10'),
('Ava', 'Roy', 'Sales', 'Sales Executive', 52000.00, '2019-03-15'),
('Madan', 'Kumar', 'Sales', 'Sales Manager', 75000.00, '2018-11-05'),
('Amar', 'Singh', 'Sales', 'Sales Executive', 51000.00, '2021-06-20'),
('Shree', 'Wadia', 'Sales', 'Sales Executive', 49500.00, '2022-02-18'),
('Rohan', 'Bhatia', 'IT', 'Software Engineer', 70000.00, '2019-07-01'),
('Lal', 'Daas', 'IT', 'Software Engineer', 72000.00, '2020-09-11'),
('Peter', 'Joe', 'IT', 'IT Manager', 90000.00, '2017-12-22'),
('Amy', 'Singh', 'IT', 'Software Engineer', 73000.00, '2021-04-14'),
('Samantha', 'Adams', 'IT', 'Support Engineer', 60000.00, '2022-01-09'),
('Aly', 'White', 'HR', 'HR Executive', 48000.00, '2020-05-30'),
('Raam', 'Kapoor', 'HR', 'HR Executive', 47000.00, '2021-02-13'),
('Frank', 'Lee', 'HR', 'HR Manager', 65000.00, '2018-09-03'),
('Nancy', 'Tyler', 'HR', 'Recruiter', 46000.00, '2022-03-20'),
('Victoria', 'Scott', 'HR', 'HR Executive', 48500.00, '2023-01-15'),
('Gracy', 'Hilton', 'Finance', 'Accountant', 55000.00, '2019-06-10'),
('Bob', 'White', 'Finance', 'Accountant', 54000.00, '2020-08-25'),
('Clove', 'Tyler', 'Finance', 'Finance Manager', 80000.00, '2017-03-12'),
('Om', 'Kapoor', 'Finance', 'Accountant', 56000.00, '2021-12-30'),
('Ava', 'Scott', 'Finance', 'Analyst', 52000.00, '2022-10-02'),
('Arvind', 'Kumar', 'Sales', 'Sales Executive', 50500.00, '2020-07-08'),
('Liam', 'Carter', 'Sales', 'Sales Executive', 50800.00, '2021-01-19'),
('Noah', 'Ward', 'IT', 'Software Engineer', 71500.00, '2020-03-23'),
('Ava', 'Scott', 'HR', 'Recruiter', 45500.00, '2022-11-14'),
('Isla', 'Kumar', 'Finance', 'Analyst', 53000.00, '2021-09-07'),
('Homy', 'Patt', 'Sales', 'Sales Executive', 49900.00, '2019-04-17'),
('Ally', 'Jane', 'IT', 'Support Engineer', 61000.00, '2022-06-12'),
('Arpit', 'Kumar', 'HR', 'HR Executive', 47500.00, '2020-10-20'),
('Aria', 'Scott', 'Finance', 'Accountant', 55800.00, '2021-05-11'),
('Rita', 'Gray', 'Sales', 'Sales Executive', 50200.00, '2023-03-25'),
('Shrey', 'Singh', 'Sales', 'Sales Executive', 50000.00, '2022-08-19'),
('William', 'Singh', 'IT', 'Software Engineer', 73500.00, '2021-11-03'),
('James', 'Singh', 'HR', 'Recruiter', 47000.00, '2020-02-06'),
('Sohan', 'Kumar', 'Finance', 'Analyst', 54000.00, '2022-05-09'),
('Lokesh', 'Patel', 'Sales', 'Sales Executive', 49800.00, '2020-12-13'),
('Harish', 'Kumar', 'IT', 'Support Engineer', 60500.00, '2023-01-01'),
('Simran', 'Singh', 'HR', 'HR Executive', 48000.00, '2019-07-21'),
('Anant', 'Shukla', 'Finance', 'Accountant', 55000.00, '2020-04-27'),
('Jay', 'Shukla', 'Sales', 'Sales Executive', 50900.00, '2021-03-14'),
('Ramesh', 'Kumar', 'Sales', 'Sales Executive', 51200.00, '2023-04-18');

SELECT * FROM staff;

-- Let's analyze this staff data using important window functions in SQL


-- 1) Rank staff salaries within each department

SELECT
    staff_id,
    first_name,
    last_name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM staff;

-- 2) Calculate average salary per department, shown per employee

SELECT
    staff_id,
    first_name,
    department,
    salary,
    ROUND(AVG(salary) OVER (PARTITION BY department), 2) AS avg_dept_salary
FROM staff;

-- 3) Find cumulative salary cost over time (company-wide)

SELECT
    staff_id,
    first_name,
    hire_date,
    salary,
    SUM(salary) OVER (ORDER BY hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_salary
FROM staff;

-- 4) Show previous employee’s salary (LEAD/LAG)

SELECT
    staff_id,
    first_name,
    department,
    salary,
    LAG(salary, 1) OVER (PARTITION BY department ORDER BY hire_date) AS previous_salary,
    LEAD(salary, 1) OVER (PARTITION BY department ORDER BY hire_date) AS next_salary
FROM staff;


-- 5) Count of staff hired so far (by hire date)

SELECT
    staff_id,
    first_name,
    hire_date,
    COUNT(*) OVER (ORDER BY hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_hires
FROM staff;
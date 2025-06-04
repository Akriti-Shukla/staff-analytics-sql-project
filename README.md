# 📊 Staff Data Analysis Using SQL Window Functions

## 🗂 Project Overview

In this SQL project, we perform **in-depth analysis on staff data** using **powerful window functions** to derive meaningful insights across departments and roles. The project demonstrates real-world SQL skills in querying, ranking, and aggregating data to assist in informed decision-making within an organization.

We start by creating a database named `Staff_Data`, followed by a `staff` table populated with sample records. The main objective is to explore how SQL **window functions** can simplify complex analytics without the need for nested queries or joins.

---

## 🎯 Why This Analysis Matters

Effective staff analysis helps organizations:

- Identify salary distribution and fairness across departments  
- Track workforce trends like hiring patterns and salary progression  
- Manage budgeting and salary planning effectively  
- Understand employee metrics in context rather than isolation  

Using **window functions** in SQL makes these analyses:

- ✅ **Easier to write and read** than traditional subqueries  
- ✅ **More efficient** for performing calculations across groups  
- ✅ **Dynamic**, allowing multiple analyses in a single query context  

---

## 🛠 Key Steps

1. **Database & Table Setup**
   - Created a new database `Staff_Data`
   - Defined and created a table `staff` with relevant columns (e.g., name, department, salary, hire date, etc.)
   - Inserted sample data (40+ rows) representing staff across multiple departments

2. **Window Function-Based Analysis**
   - 📌 **RANK()** – Ranked employee salaries within each department  
   - 📌 **AVG()** – Calculated department-wise average salary and showed it per employee  
   - 📌 **SUM()** – Computed the cumulative salary cost company-wide over time (ordered by hire date)  
   - 📌 **LEAD() / LAG()** – Displayed the salary of the previous or next employee based on hire order  
   - 📌 **COUNT()** – Counted how many employees were hired up to a given point in time  

---

```sql

-- 1) Rank staff salaries within each department

SELECT
    staff_id,
    first_name,
    last_name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM staff;

```

```sql

-- 2) Calculate average salary per department, shown per employee

SELECT
    staff_id,
    first_name,
    department,
    salary,
    ROUND(AVG(salary) OVER (PARTITION BY department), 2) AS avg_dept_salary
FROM staff;

```

```sql

-- 3) Find cumulative salary cost over time (company-wide)

SELECT
    staff_id,
    first_name,
    hire_date,
    salary,
    SUM(salary) OVER (ORDER BY hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_salary
FROM staff;

```

```sql

-- 4) Show previous employee’s salary (LEAD/LAG)

SELECT
    staff_id,
    first_name,
    department,
    salary,
    LAG(salary, 1) OVER (PARTITION BY department ORDER BY hire_date) AS previous_salary,
    LEAD(salary, 1) OVER (PARTITION BY department ORDER BY hire_date) AS next_salary
FROM staff;

```

```sql

-- 5) Count of staff hired so far (by hire date)

SELECT
    staff_id,
    first_name,
    hire_date,
    COUNT(*) OVER (ORDER BY hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_hires
FROM staff;

```



## 📈 Conclusion

This project highlights the **power and versatility of SQL window functions** in real-world data analysis. Unlike traditional aggregate functions, window functions allow us to maintain row-level context while performing group-based calculations, making the results far more insightful and dynamic.

Through this exercise, I deepened my understanding of:

- Partitioning and ordering data within window frames  
- Performing analytical tasks like ranking, running totals, and comparisons  
- Writing clean, readable SQL for complex reporting needs  
- Practical examples of SQL window functions  
- Best practices for staff and HR data analysis  
- Writing efficient queries to analyze trends within departments  
- Real-world use cases that apply across industries  

---



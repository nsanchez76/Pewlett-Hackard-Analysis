--Employee_Database_challenge

--Retrieve data from employees table
SELECT emp_no, first_name, last_name
FROM employees;

--Retrive data from titles table
SELECT title, from_date, to_date
FROM titles;

--Creating new table "retirement_employees"
SELECT emp_no, first_name, last_name, birth_date
INTO retirement_employees
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

--Creating new table "employee_titles"
SELECT emp_no, title, from_date, to_date
INTO employee_titles
FROM titles;

--Joining retirement_employees and employee_titles tables
SELECT retirement_employees.emp_no,
     retirement_employees.first_name,
     retirement_employees.last_name,
     employee_titles.title,
	 employee_titles.from_date,
	 employee_titles.to_date
INTO retirement_titles
FROM retirement_employees
INNER JOIN employee_titles
ON retirement_employees.emp_no = employee_titles.emp_no;

--Creating new table "distinct_titles"
SELECT emp_no, first_name, last_name, title
INTO distinct_titles
FROM retirement_titles;

SELECT * FROM distinct_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE retirement_titles.to_date = '9999-01-01'
ORDER BY emp_no, title DESC;

SELECT * FROM unique_titles

--Calculating retiring titles
SELECT title, COUNT(emp_no) AS "count"
INTO retiring_titles
FROM retirement_titles
GROUP BY title;

SELECT * FROM retiring_titles;

--Mentorship Eligibility
SELECT DISTINCT ON(emp_no)
	employees.emp_no, 
	employees.first_name, 
	employees.last_name, 
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date
INTO emp_data
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND to_date = '9999-01-01';

SELECT * FROM emp_data;

SELECT DISTINCT ON(emp_no)
	employees.emp_no, 
	employees.first_name, 
	employees.last_name, 
	titles.title
INTO title_data
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no;

SELECT * FROM title_data;

SELECT
	emp_data.emp_no, 
	emp_data.first_name, 
	emp_data.last_name, 
	emp_data.birth_date,
	emp_data.from_date,
	emp_data.to_date,
	title_data.title
INTO mentorship_eligibility
FROM emp_data
INNER JOIN title_data
ON emp_data.emp_no = title_data.emp_no;

--Calculating mentorship titles
SELECT title, COUNT(emp_no) AS "count"
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title;

SELECT * FROM mentorship_titles;
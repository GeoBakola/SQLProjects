--We are working on a dataset from an HR Database.
--Checking the 'employees' table

SELECT *
FROM employees;

--Sorting the employees by their last name, salary and hire date

SELECT *
FROM employees
ORDER BY last_name;

SELECT *
FROM employees
ORDER BY salary DESC;

SELECT *
FROM employees
ORDER BY hire_date DESC;

--Finding the total sum of employees, the departments and job specialties

SELECT COUNT(*) AS number_employees, COUNT(DISTINCT job_id) AS specialties, COUNT(DISTINCT department_id) AS departments
FROM employees;

--Finding the averaage salary of all employees and the total amount the company is paying for salaries

SELECT AVG(salary) AS avg_salary
FROM employees;

SELECT sum(salary) AS total_salaries
FROM employees;

--Finding the employees with the highest and lowest salaries

SELECT first_name, last_name,salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

SELECT first_name, last_name,salary
FROM employees
ORDER BY salary DESC
LIMIT 1;

--Finding the number of employees per department and the five departments with the most employees

SELECT COUNT(employee_id) AS number_employees, department_id
FROM employees
GROUP BY department_id
ORDER BY COUNT(employee_id) DESC
LIMIT 5;

--Finding the five specialties with the most employees

SELECT COUNT(employee_id) AS number_employees, job_id
FROM employees
GROUP BY job_id
ORDER BY COUNT(employee_id) DESC
LIMIT 5;

--Finding how many employees were hired per department from 1990 to the end of 1995

SELECT COUNT(employee_id) AS number_employees, department_id
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1995-12-31'
GROUP BY department_id
ORDER BY COUNT(employee_id) DESC;

--Finding how many employeed are being supervised per manager and the total salaries they manage (Managers with at least 2 supervisees)

SELECT manager_id,COUNT(employee_id) AS number_employees, SUM(salary) AS budget
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING count(employee_id) >=2
ORDER BY budget DESC;

--Finding the lowest and highest salary for departments which have more than two employees

SELECT COUNT(employee_id) AS number_employees, MIN(salary) AS minimum, MAX(salary) AS maximum, department_id
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) >2
ORDER BY department_id ;

--Finding the average salary of the specialties with more than one employees

SELECT COUNT(employee_id) AS number_employees, ROUND(AVG(salary)) AS job_avg, job_id
FROM employees
GROUP BY job_id
HAVING COUNT(employee_id) >1
ORDER BY job_avg DESC;


--Finding each department's average salary and total budget, sorted by the average salary

SELECT COUNT(employee_id) AS number_employees, ROUND(AVG(salary)) as department_avg, SUM(salary) AS total_salaries, department_id
FROM employees
GROUP BY department_id
ORDER BY department_avg DESC;

--Filtering the previous, for departments with more than two employees and average salary higher than 6000

SELECT COUNT(employee_id) AS number_employees, ROUND(AVG(salary)) as department_avg, SUM(salary) AS total_salaries, department_id
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) >2 AND AVG(salary)>6000
ORDER BY department_avg DESC;

--Printing the departments' names alongside the rest of the information

SELECT COUNT(employees.employee_id) AS number_employees, ROUND(AVG(employees.salary)) as department_avg,
           SUM(employees.salary) AS total_salaries, employees.department_id, departments.department_name
FROM employees, departments
WHERE employees.department_id= departments.department_id
GROUP BY employees.department_id, departments.department_name
HAVING COUNT(employees.employee_id) >2 AND AVG(employees.salary)>6000
ORDER BY employees.department_id ;


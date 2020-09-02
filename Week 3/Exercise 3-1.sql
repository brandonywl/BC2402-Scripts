# Question 1. Show all tables in the schema
show tables;

# Question 2. Display first names, last names and gender of all employees.
SELECT `first_name`, `last_name`, `gender` FROM `employees`.`employees`;

# Question 3. Display all distinct job titles
SELECT DISTINCT(`title`) from `employees`.`titles`;

# Question 4. How many employees are there?
SELECT COUNT(*) from `employees`.`employees`;

# Question 5. How many salary records are there?
SELECT COUNT(*) FROM `employees`.`salaries`;

# Question 6. How many departments are there?
SELECT COUNT(*) FROM `employees`.`departments`;

# Question 7. What are the names of the departments?
SELECT DISTINCT(`dept_name`) FROM `employees`.`departments`;

# Question 8. Display the name of all female employees.
SELECT `first_name`, `last_name` FROM `employees`.`employees` WHERE `gender` = 'F';

# Question 9. How many male employees are there?
SELECT COUNT(*) FROM `employees`.`employees` WHERE `gender` = 'M';

# Question 10.	Display employee information for those who were hired before the year 1990.
SELECT * from `employees`.`employees` WHERE `hire_date` < str_to_date('1990', '%Y');

# Question 11. Find male employees who were hired after 1995;
SELECT * from `employees`.`employees` WHERE `hire_date` > str_to_date('1995', '%Y') and `gender` = 'M';

# Question 12. How many employees have their first names as either Adin, Deniz, Youssef and Roded?
SELECT COUNT(*) FROM `employees`.`employees` WHERE `first_name` = 'Adin' or `first_name` = 'Deniz' or `first_name` = 'Youssef' or `first_name` = 'Roded';

# Question 13. How many employees are: (a) Engineers
SELECT COUNT(*) FROM `employees`.`titles` WHERE `title` LIKE '%Engineer';
# Question 13 (b) Non-engineers
SELECT COUNT(*) FROM `employees`.`titles` WHERE `title` NOT LIKE '%Engineer';

# Question 14. How many employees were hired between 1990/01/01 and 1994/01/01.
SELECT COUNT(*) from `employees`.`employees` WHERE `hire_date` >= str_to_date('1990/01/01', '%Y/%m/%d') and  `hire_date` <= str_to_date('1994/01/01', '%Y/%m/%d');

# Question 15. Find the list of unique last names of female employees (in alphabetical order), who were born before the year 1970, and hired after 1996. 
SELECT DISTINCT(`last_name`) from `employees`.`employees` WHERE `birth_date` < str_to_date('1970', '%Y') and `hire_date` > str_to_date('1996', '%Y') ORDER BY `last_name`;

# Question 16. For each gender, how many employees were hired before 1989;
SELECT COUNT(*) from `employees`.`employees` WHERE `hire_date` < str_to_date('1989', '%Y') GROUP BY `gender`;

# Question 17. For each gender: (a) how many employees in each department?
SELECT `employees`.`gender`,`departments`.`dept_name`, COUNT(*) FROM `employees`.`employees` 
LEFT JOIN `employees`.`dept_emp` ON `employees`.`emp_no` = `dept_emp`.`emp_no` 
LEFT JOIN `employees`.`departments` ON `dept_emp`.`dept_no` = `departments`.`dept_no` 
GROUP BY `departments`.`dept_name`, `employees`.`gender`
ORDER BY `employees`.`gender` ASC;
# (b) hired between the years of 1994-1996?
SELECT `gender`, COUNT(*) FROM `employees`.`employees` WHERE (`hire_date` BETWEEN '1994-01-01' and '1996-12-31') GROUP BY `gender`;

# Wrong
# Question 18. List the names of all employees with department managers appointed starting from 1992/09/08 and ending at 1996/01/03.
SELECT first_name, last_name
	FROM employees.employees
    JOIN employees.dept_emp
    ON employees.employees.emp_no = employees.dept_emp.emp_no
    JOIN employees.dept_manager
    ON dept_emp.dept_no = dept_manager.dept_no
    WHERE dept_manager.from_date = '1992-09-08' AND dept_manager.to_date = '1996-01-03';

# Question 19. List the names of every employee and their respective job titles.
SELECT `employees`.`employees`.`first_name`, `employees`.`employees`.`last_name`, `employees`.`titles`.`title`
	FROM `employees`.`employees`
    JOIN `employees`.`titles`
    ON `employees`.`employees`.`emp_no` = `employees`.`titles`.`emp_no`
    WHERE `employees`.`titles`.`to_date` = '9999-01-01';
    # Remove WHERE clause to get first answer

# Question 20. Find the average paid salary of every department
SELECT `dept_emp`.`dept_no`, avg(`salaries`.`salary`) AS avg_sal
FROM `employees`.`dept_emp` 
JOIN `employees`.`salaries`
ON `employees`.`salaries`.`emp_no` = `employees`.`dept_emp`.`emp_no`
GROUP BY `dept_no`;


# Question 21. Find the average paid salary of every department and their number of employees
SELECT `dept_emp`.`dept_no`, COUNT(DISTINCT(`dept_emp`.`emp_no`)) AS empAmt, avg(`salaries`.`salary`) AS avg_sal
FROM `employees`.`dept_emp` 
JOIN `employees`.`salaries`
ON `employees`.`salaries`.`emp_no` = `employees`.`dept_emp`.`emp_no`
GROUP BY `dept_no`;

# Question 22. Number of employees in every department who have received more than $130000 in a salary transaction
SELECT `dept_emp`.`dept_no`, COUNT(DISTINCT(`dept_emp`.`emp_no`)) AS empAmt
FROM `employees`.`dept_emp` 
JOIN `employees`.`salaries`
ON `employees`.`salaries`.`emp_no` = `employees`.`dept_emp`.`emp_no`
WHERE `employees`.`salaries`.`salary` > 130000
GROUP BY `dept_no`;
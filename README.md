# Pewlett Hackard Retirement Analysis

## Analysis Overview
### Purpose
To prepare for an expected wave of retirements, Pewlett Hackard (PH) has requested a thorough analysis of their workforce. The goal is to determine the number of employees retiring per job title and also identify which employees are eligible to participate in a mentorship program. 

## Results
* Senior-level employees make up the largest percentage (70%) of expected retirees. 
* Engineering jobs (Assistant Engineer, Engineer, and Senior Engineer) account for 50% of expected retires.
* Approximately 1,550 employees are eligible for mentorship. 
* There are far more retirees (72,458) than there are mentorship-eligible employees (1,550) to fill their roles.

![Retirees by Title](/Data/unique_titles.csv)

## Summary
### Total Roles to be Filled
In total, 72,458 positions will need to be filled due to retirements.

### Mentorship
There are more retirees than there are employees eligible for mentorship. Each department has enough qualified, retirement-ready employees to mentor the next generation of PH employees. 

### Additional Analyses
Additonal queries could provide more insight to help PH prepare for the expected retirees. For example, the following query produces a table of total retirees by department. 
```
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title,
	de.dept_no,
	d.dept_name
INTO retirees_department
FROM retirement_titles as rt
INNER JOIN dept_emp as de
	ON rt.emp_no = de.emp_no
INNER JOIN departments as d
	ON de.dept_no = d.dept_no
WHERE rt.to_date = '9999-01-01'
ORDER BY emp_no, rt.to_date DESC;

SELECT COUNT(dept_name), dept_name
FROM retirees_department
GROUP BY dept_name
ORDER BY count DESC
```

This can be taken one step further to show the expected retirees by title, by department. 
```
SELECT COUNT(dept_name), dept_name, title
FROM retirees_department
GROUP BY dept_name, title
ORDER BY dept_name, count DESC
```

With these tables, it is evident that the Development and Production departments are expecting the largest number of retirees. Within both departments, Senior Engineers make up the largest group of retirees.

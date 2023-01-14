-- DELIVERABLE 1
-- retirement_titles
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;


-- unique_titles
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- retiring_titles
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC

-- DELIVERABLE 2
-- Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
	ON e.emp_no = de.emp_no
INNER JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01')
	AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

-- DELIVERABLE 3
-- Retirements by Department
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

SELECT COUNT(dept_name), dept_name, title
FROM retirees_department
GROUP BY dept_name, title
ORDER BY dept_name
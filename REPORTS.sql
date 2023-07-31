
-- Employees (employee_id, first_name, last_name, department, salary)
-- Projects (project_id, project_name, start_date, end_date)
-- Tasks (task_id, task_name, project_id, assigned_to, status)
-- And we want to create a report that includes the top earners, active projects, and employee task assignments. We'll also implement a trigger function to update employee salaries automatically when they're assigned a new project.

-- Indexes:
-- Indexes improve the performance of database queries. Let's create an index for the Employees table to speed up salary-based searches.

sql

CREATE INDEX idx_salary ON Employees(salary);
Trigger Function:
-- Let's create a trigger function that automatically updates an employee's salary when they are assigned a new project. For the sake of simplicity, we'll assume a 5% salary increase when an employee gets a new project.

-- -- sql

-- CREATE OR REPLACE FUNCTION update_salary_on_project_assignment()
-- RETURNS TRIGGER AS $$
-- BEGIN
--   UPDATE Employees
--   SET salary = salary * 1.05 -- 5% increase
--   WHERE employee_id = NEW.assigned_to;
--   RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE TRIGGER project_assignment_trigger
-- AFTER INSERT ON Tasks
-- FOR EACH ROW
-- EXECUTE FUNCTION update_salary_on_project_assignment();
-- Report:
-- Now let's create the SQL query to generate the report. We want to show the top 5 earners, active projects, and task assignments for employees.

-- sql
-- -- Top 5 Earners
SELECT employee_id, first_name, last_name, department, salary
FROM Employees
ORDER BY salary DESC
LIMIT 5;

-- Active Projects
SELECT project_id, project_name, start_date, end_date
FROM Projects
WHERE end_date >= CURRENT_DATE;

-- Employee Task Assignments
SELECT t.task_id, t.task_name, t.status, e.first_name || ' ' || e.last_name AS assigned_to
FROM Tasks t
JOIN Employees e ON t.assigned_to = e.employee_id;

/** Let's consider a table Employees that stores information about employees in a company. 
Each employee has a unique employee_id, and each department has a unique department_id. */

/* Imagine you have a big box of colorful marbles, and you want to organize them neatly. 
Each marble has a unique pattern, but some patterns might repeat. 
You want to make sure you can find any marble easily without digging through the whole box.

Normalization in a database is like sorting those marbles. 
It's a process where you organize information in a way that reduces messiness and repetition. 
You break down information into smaller parts and arrange them in a logical order. 
This makes it easier to find and manage data without wasting time.
*/

-- Create the Employees table
CREATE TABLE Employees (
  employee_id INT PRIMARY KEY,
  employee_name VARCHAR(50),
  department_id INT,
  department_name VARCHAR(50),
  department_location VARCHAR(50)
);

-- Insert sample data into the Employees table
INSERT INTO Employees (employee_id, employee_name, department_id, department_name, department_location) VALUES
  (1, 'John Doe', 1, 'HR', 'New York'),
  (2, 'Jane Smith', 2, 'Finance', 'Chicago'),
  (3, 'Mike Johnson', 1, 'HR', 'New York');


/** 
Functional Dependencies:
employee_id → employee_name, department_id
department_id → department_name, department_location

For any relation R, attribute Y is functionally dependent on attribute X.
if for every valid instance of X, that value of X uniquely determines the value of Y.

============================================================================================================


First Normal Form (1NF):
Ensure that each column contains only atomic (indivisible) values.
The Employees table is already in 1NF because all the values are atomic.

Second Normal Form (2NF):
Remove partial dependencies by splitting the table based on primary keys and dependent attributes.
In our case, there are no partial dependencies, so we skip this step. */


-- Create the EmployeeInfo table
CREATE TABLE EmployeeInfo (
  employee_id INT PRIMARY KEY,
  employee_name VARCHAR(50),
  department_id INT
);

-- Create the Departments table
CREATE TABLE Departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(50),
  department_location VARCHAR(50)
);

-- Insert sample data into the EmployeeInfo table
INSERT INTO EmployeeInfo (employee_id, employee_name, department_id) VALUES
  (1, 'John Doe', 1),
  (2, 'Jane Smith', 2),
  (3, 'Mike Johnson', 1);

-- Insert sample data into the Departments table
INSERT INTO Departments (department_id, department_name, department_location) VALUES
  (1, 'HR', 'New York'),
  (2, 'Finance', 'Chicago');
  
  
  /** Separate Dependent Attributes
We'll keep the Departments table as it is and remove the department_name and department_location attributes from the EmployeeInfo table. */

-- Update EmployeeInfo table to reference Departments table using foreign key
ALTER TABLE EmployeeInfo
ADD FOREIGN KEY (department_id) REFERENCES Departments(department_id);

-- Update EmployeeInfo table to remove department-related attributes
ALTER TABLE EmployeeInfo
DROP COLUMN department_name,
DROP COLUMN department_location;


/** Third Normal Form (3NF):
Remove transitive dependencies by splitting the table based on primary keys and non-key attributes.
To achieve 3NF, we will separate department_id, department_name, and department_location into a separate Departments table. */

-- To achieve 3NF, we will separate department_id, department_name, and department_location into a separate Departments table.

-- Create the Departments table
CREATE TABLE Departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(50),
  department_location VARCHAR(50)
);

-- Update Employees table to reference Departments table using foreign key
ALTER TABLE Employees
ADD FOREIGN KEY (department_id) REFERENCES Departments(department_id);

-- Boyce–Codd Normal Form (BCNF) is based on functional dependencies that take into account all candidate keys in a relation
-- In BCNF, a table is considered to be in this form if, for every non-trivial functional dependency X → Y, X is a superkey.

/** 
The following functional dependencies are non-trivial:
employee_id → employee_name
department_id → department_name

On the other hand, the following functional dependencies would be considered trivial:

employee_id → employee_id
department_id → department_id
*/
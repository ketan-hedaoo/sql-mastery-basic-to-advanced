USE ProjectDB
DROP TABLE IF EXISTS Students
DROP TABLE IF EXISTS Orders
DROP TABLE IF EXISTS Users
DROP TABLE IF EXISTS Products
DROP TABLE IF EXISTS Employees
DROP TABLE IF EXISTS Items
DROP TABLE IF EXISTS ClassEnrollments
DROP TABLE IF EXISTS Parent
DROP TABLE IF EXISTS Child

--==========================================================================
--1. PRIMARY KEY
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50)
);

--2. FOREIGN KEY
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
)

--3. UNIQUE
CREATE TABLE Users (
    email VARCHAR(100) UNIQUE,
    username VARCHAR(50) UNIQUE
)

--4. NOT NULL
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
)

--5. CHECK
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    age INT CHECK (age >= 18)
)

--6. DEFAULT
CREATE TABLE Items (
    item_id INT PRIMARY KEY,
    stock_qty INT DEFAULT 0
)

--8. Composite Key
CREATE TABLE ClassEnrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id)
)


--==========================================================================
--Add Constraints once table is created
CREATE TABLE Parent (
    category VARCHAR(50) PRIMARY KEY
)

CREATE TABLE Child (
    id INT,
    name VARCHAR(100),
    qty TINYINT,
    price NUMERIC(18, 2),
    category VARCHAR(50)
)


--1. Add PRIMARY KEY
ALTER TABLE Child
ADD CONSTRAINT pk_child PRIMARY KEY (id)

--2. Add FOREIGN KEY Constraint
ALTER TABLE Child
ADD CONSTRAINT fk_child FOREIGN KEY (category) REFERENCES Parent(category)

--3. Add UNIQUE Constraint
ALTER TABLE Child
ADD CONSTRAINT uq_child UNIQUE (name)

--4. Add NOT NULL Constraint
ALTER TABLE Child
ALTER COLUMN qty INT NOT NULL

--5. Add CHECK Constraint
ALTER TABLE Child
ADD CONSTRAINT chk_child CHECK (price >= 0)

--6. Add DEFAULT Constraint
ALTER TABLE Child
ADD CONSTRAINT df_child DEFAULT 1 FOR qty
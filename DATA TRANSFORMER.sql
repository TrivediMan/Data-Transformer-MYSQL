mysql> Create database data_trans;
Query OK, 1 row affected (0.155 sec)

mysql> SHOW databases;
+--------------------+
| Database           |
+--------------------+
| cdb                |
| companydb          |
| data_trans         |
| fusion             |
| huion              |
| information_schema |
| jay                |
| joins              |
| man                |
| man2               |
| man4               |
| man5               |
| man_sql            |
| mark               |
| markii             |
| mt                 |
| mysql              |
| performance_schema |
| rdj                |
| sakila             |
| sys                |
| trivedi            |
| vision             |
| workforce_db       |
| world              |
+--------------------+
25 rows in set (0.056 sec)

mysql> USE data_trans;
Database changed
mysql> CREATE TABLE Customers (
    ->     CustomerID INT PRIMARY KEY,
    ->     FirstName VARCHAR(50),
    ->     LastName VARCHAR(50),
    ->     Email VARCHAR(50));
Query OK, 0 rows affected (0.496 sec)

mysql> CREATE TABLE Orders (
    ->     OrderID INT PRIMARY KEY,
    ->     CustomerID INT,
    ->     OrderDate DATE,
    ->     TotalAmount DECIMAL(10,2),
    ->     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    -> );
Query OK, 0 rows affected (0.876 sec)

mysql> CREATE TABLE Employees (
    ->     EmployeeID INT PRIMARY KEY,
    ->     FirstName VARCHAR(50),
    ->     LastName VARCHAR(50),
    ->     Department VARCHAR(50),
    ->     HireDate DATE,
    ->     Salary DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.320 sec)

mysql> INSERT INTO Customers (CustomerID, FirstName, LastName, Email)
    -> VALUES
    -> (1, 'Amit', 'Sharma', ' amit.sharma@example.com '),
    -> (2, 'Priya', 'Patel', ' priya.patel@example.com '),
    -> (3, 'Ravi', 'Kumar', ' ravi.kumar@example.com ');
Query OK, 3 rows affected (0.144 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
    -> VALUES
    -> (101, 1, '2023-07-01', 150.50),
    -> (102, 2, '2023-07-03', 200.75),
    -> (103, 1, '2023-07-05', 1200.00);
Query OK, 3 rows affected (0.147 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, HireDate, Salary)
    -> VALUES
    -> (1, 'Suresh', 'Nair', 'Sales', '2020-01-15', 50000.00),
    -> (2, 'Meena', 'Reddy', 'HR', '2021-03-20', 55000.00),
    -> (3, 'Arjun', 'Singh', 'IT', '2019-11-10', 75000.00);
Query OK, 3 rows affected (0.135 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> SELECT o.OrderID, o.OrderDate, o.TotalAmount, c.CustomerID, c.FirstName, c.LastName
    -> FROM Orders o
    -> INNER JOIN Customers c ON o.CustomerID = c.CustomerID;
+---------+------------+-------------+------------+-----------+----------+
| OrderID | OrderDate  | TotalAmount | CustomerID | FirstName | LastName |
+---------+------------+-------------+------------+-----------+----------+
|     101 | 2023-07-01 |      150.50 |          1 | Amit      | Sharma   |
|     102 | 2023-07-03 |      200.75 |          2 | Priya     | Patel    |
|     103 | 2023-07-05 |     1200.00 |          1 | Amit      | Sharma   |
+---------+------------+-------------+------------+-----------+----------+
3 rows in set (0.015 sec)

mysql>
mysql> SELECT c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.OrderDate, o.TotalAmount
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;
+------------+-----------+----------+---------+------------+-------------+
| CustomerID | FirstName | LastName | OrderID | OrderDate  | TotalAmount |
+------------+-----------+----------+---------+------------+-------------+
|          1 | Amit      | Sharma   |     101 | 2023-07-01 |      150.50 |
|          1 | Amit      | Sharma   |     103 | 2023-07-05 |     1200.00 |
|          2 | Priya     | Patel    |     102 | 2023-07-03 |      200.75 |
|          3 | Ravi      | Kumar    |    NULL | NULL       |        NULL |
+------------+-----------+----------+---------+------------+-------------+
4 rows in set (0.015 sec)

mysql>
mysql> SELECT o.OrderID, o.OrderDate, o.TotalAmount, c.CustomerID, c.FirstName, c.LastName
    -> FROM Orders o
    -> RIGHT JOIN Customers c ON o.CustomerID = c.CustomerID;
+---------+------------+-------------+------------+-----------+----------+
| OrderID | OrderDate  | TotalAmount | CustomerID | FirstName | LastName |
+---------+------------+-------------+------------+-----------+----------+
|     101 | 2023-07-01 |      150.50 |          1 | Amit      | Sharma   |
|     103 | 2023-07-05 |     1200.00 |          1 | Amit      | Sharma   |
|     102 | 2023-07-03 |      200.75 |          2 | Priya     | Patel    |
|    NULL | NULL       |        NULL |          3 | Ravi      | Kumar    |
+---------+------------+-------------+------------+-----------+----------+
4 rows in set (0.019 sec)

mysql>
mysql> SELECT c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.OrderDate, o.TotalAmount
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    -> UNION
    -> SELECT c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.OrderDate, o.TotalAmount
    -> FROM Customers c
    -> RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;
+------------+-----------+----------+---------+------------+-------------+
| CustomerID | FirstName | LastName | OrderID | OrderDate  | TotalAmount |
+------------+-----------+----------+---------+------------+-------------+
|          1 | Amit      | Sharma   |     103 | 2023-07-05 |     1200.00 |
|          1 | Amit      | Sharma   |     101 | 2023-07-01 |      150.50 |
|          2 | Priya     | Patel    |     102 | 2023-07-03 |      200.75 |
|          3 | Ravi      | Kumar    |    NULL | NULL       |        NULL |
+------------+-----------+----------+---------+------------+-------------+
4 rows in set (0.026 sec)

mysql>
mysql> SELECT DISTINCT c.CustomerID, c.FirstName, c.LastName
    -> FROM Customers c
    -> JOIN Orders o ON c.CustomerID = o.CustomerID
    -> WHERE o.TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);
+------------+-----------+----------+
| CustomerID | FirstName | LastName |
+------------+-----------+----------+
|          1 | Amit      | Sharma   |
+------------+-----------+----------+
1 row in set (0.019 sec)

mysql>
mysql> SELECT EmployeeID, FirstName, LastName, Salary
    -> FROM Employees
    -> WHERE Salary > (SELECT AVG(Salary) FROM Employees);
+------------+-----------+----------+----------+
| EmployeeID | FirstName | LastName | Salary   |
+------------+-----------+----------+----------+
|          3 | Arjun     | Singh    | 75000.00 |
+------------+-----------+----------+----------+
1 row in set (0.025 sec)

mysql>
mysql> SELECT OrderID, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth
    -> FROM Orders;
+---------+-----------+------------+
| OrderID | OrderYear | OrderMonth |
+---------+-----------+------------+
|     101 |      2023 |          7 |
|     102 |      2023 |          7 |
|     103 |      2023 |          7 |
+---------+-----------+------------+
3 rows in set (0.010 sec)

mysql>
mysql> SELECT OrderID, DATEDIFF(CURDATE(), OrderDate) AS DaysSinceOrder
    -> FROM Orders;
+---------+----------------+
| OrderID | DaysSinceOrder |
+---------+----------------+
|     101 |            889 |
|     102 |            887 |
|     103 |            885 |
+---------+----------------+
3 rows in set (0.012 sec)

mysql>
mysql> SELECT OrderID, DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedDate
    -> FROM Orders;
+---------+---------------+
| OrderID | FormattedDate |
+---------+---------------+
|     101 | 01-Jul-2023   |
|     102 | 03-Jul-2023   |
|     103 | 05-Jul-2023   |
+---------+---------------+
3 rows in set (0.013 sec)

mysql>
mysql> SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS FullName
    -> FROM Employees;
+------------+-------------+
| EmployeeID | FullName    |
+------------+-------------+
|          1 | Suresh Nair |
|          2 | Meena Reddy |
|          3 | Arjun Singh |
+------------+-------------+
3 rows in set (0.009 sec)

mysql>
mysql> SELECT REPLACE(FirstName, 'Arjun', 'Arjunesh') AS UpdatedName
    -> FROM Employees;
+-------------+
| UpdatedName |
+-------------+
| Suresh      |
| Meena       |
| Arjunesh    |
+-------------+
3 rows in set (0.009 sec)

mysql>
mysql> SELECT UPPER(FirstName) AS FirstNameUpper, LOWER(LastName) AS LastNameLower
    -> FROM Employees;
+----------------+---------------+
| FirstNameUpper | LastNameLower |
+----------------+---------------+
| SURESH         | nair          |
| MEENA          | reddy         |
| ARJUN          | singh         |
+----------------+---------------+
3 rows in set (0.015 sec)

mysql>
mysql> SELECT CustomerID, TRIM(Email) AS CleanEmail
    -> FROM Customers;
+------------+-------------------------+
| CustomerID | CleanEmail              |
+------------+-------------------------+
|          1 | amit.sharma@example.com |
|          2 | priya.patel@example.com |
|          3 | ravi.kumar@example.com  |
+------------+-------------------------+
3 rows in set (0.011 sec)

mysql>
mysql> SELECT OrderID, OrderDate, TotalAmount,
    ->        SUM(TotalAmount) OVER (ORDER BY OrderDate) AS RunningTotal
    -> FROM Orders;
+---------+------------+-------------+--------------+
| OrderID | OrderDate  | TotalAmount | RunningTotal |
+---------+------------+-------------+--------------+
|     101 | 2023-07-01 |      150.50 |       150.50 |
|     102 | 2023-07-03 |      200.75 |       351.25 |
|     103 | 2023-07-05 |     1200.00 |      1551.25 |
+---------+------------+-------------+--------------+
3 rows in set (0.017 sec)

mysql>
mysql> SELECT OrderID, TotalAmount,
    ->        RANK() OVER (ORDER BY TotalAmount DESC) AS OrderRank
    -> FROM Orders;
+---------+-------------+-----------+
| OrderID | TotalAmount | OrderRank |
+---------+-------------+-----------+
|     103 |     1200.00 |         1 |
|     102 |      200.75 |         2 |
|     101 |      150.50 |         3 |
+---------+-------------+-----------+
3 rows in set (0.015 sec)

mysql>
mysql> SELECT OrderID, TotalAmount,
    ->        CASE
    ->            WHEN TotalAmount > 1000 THEN '10% Discount'
    ->            WHEN TotalAmount > 500 THEN '5% Discount'
    ->            ELSE 'No Discount'
    ->        END AS Discount
    -> FROM Orders;
+---------+-------------+--------------+
| OrderID | TotalAmount | Discount     |
+---------+-------------+--------------+
|     101 |      150.50 | No Discount  |
|     102 |      200.75 | No Discount  |
|     103 |     1200.00 | 10% Discount |
+---------+-------------+--------------+
3 rows in set (0.028 sec)

mysql>
mysql> SELECT EmployeeID, FirstName, LastName, Salary,
    ->        CASE
    ->            WHEN Salary > 70000 THEN 'High'
    ->            WHEN Salary BETWEEN 40000 AND 70000 THEN 'Medium'
    ->            ELSE 'Low'
    ->        END AS SalaryCategory
    -> FROM Employees;
+------------+-----------+----------+----------+----------------+
| EmployeeID | FirstName | LastName | Salary   | SalaryCategory |
+------------+-----------+----------+----------+----------------+
|          1 | Suresh    | Nair     | 50000.00 | Medium         |
|          2 | Meena     | Reddy    | 55000.00 | Medium         |
|          3 | Arjun     | Singh    | 75000.00 | High           |
+------------+-----------+----------+----------+----------------+
3 rows in set (0.021 sec)
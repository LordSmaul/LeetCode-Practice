-- 1757: Recyclabe and Low Fat Products 
-- https://leetcode.com/problems/recyclable-and-low-fat-products/
SELECT product_id 
FROM Products 
WHERE low_fats = 'Y' AND recyclable = 'Y';

-- 584: Find Customer Referee 
-- https://leetcode.com/problems/find-customer-referee/
SELECT name 
FROM Customer 
WHERE referee_id != 2 OR referee_id IS NULL;

-- 595: Big Countries
-- https://leetcode.com/problems/big-countries/
SELECT name, population, area 
FROM World 
WHERE area >= 3000000 OR population >= 25000000;

-- 1148: Artical Views I
-- https://leetcode.com/problems/article-views-i/
SELECT DISTINCT author_id AS id 
FROM Views 
WHERE author_id = viewer_id 
ORDER BY author_id ASC;

-- 1683: Invalid Tweets
-- https://leetcode.com/problems/invalid-tweets/
SELECT tweet_id 
FROM Tweets 
WHERE LENGTH(content) > 15;

-- 1378: Replace Employee ID With The Unique Identifier 
-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/
SELECT eu.unique_id, e.name 
FROM Employees e 
LEFT JOIN EmployeeUNI eu 
ON eu.id = e.id;

-- 1068: Product Sales Analysis I 
-- https://leetcode.com/problems/product-sales-analysis-i/
SELECT p.product_name, s.year, s.price 
FROM Sales s 
LEFT JOIN Product p ON p.product_id = s.product_id;

-- 1581: Customer Who Visitied but Did Not Make Any Transactions
-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/
SELECT v.customer_id, COUNT(v.customer_id) AS count_no_trans 
FROM Visits v 
LEFT JOIN Transactions t ON v.visit_id = t.visit_id 
WHERE t.visit_id IS NULL 
GROUP BY v.customer_id;

-- 197: Rising Temperature
-- https://leetcode.com/problems/rising-temperature/
SELECT w1.id 
FROM Weather w1, Weather w2 
WHERE DATEDIFF(w1.recordDate, w2.recordDate) = 1 AND w1.temperature > w2.temperature;

-- 1661: 
-- Average Time of Process per Machine
-- https://leetcode.com/problems/average-time-of-process-per-machine/
SELECT s.machine_id, ROUND(AVG(e.timestamp - s.timestamp), 3) AS processing_time
FROM Activity s LEFT JOIN Activity e ON s.machine_id = e.machine_id
WHERE s.activity_type = 'start' AND e.activity_type = 'end'
GROUP BY machine_id;

-- 577: Employee Bonus
-- https://leetcode.com/problems/employee-bonus/
SELECT e.name, b.bonus 
FROM Employee e 
LEFT JOIN Bonus b ON e.empID = b.empID 
WHERE b.bonus < 1000 OR b.bonus IS NULL;

-- 1280: Students and Examinations
-- https://leetcode.com/problems/students-and-examinations/
SELECT st.student_id, st.student_name, su.subject_name, COUNT(e.student_id) AS attended_exams 
FROM Students st 
JOIN Subjects su 
LEFT JOIN Examinations e ON st.student_id = e.student_id AND su.subject_name = e.subject_name 
GROUP BY st.student_id, su.subject_name ORDER BY st.student_id, su.subject_name;

-- 570: Managers with at Least 5 Direct Reports
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/
SELECT e1.name 
FROM Employee e1 
LEFT JOIN Employee e2 ON e1.id = e2.managerId 
GROUP BY e1.id 
HAVING Count(e2.managerId) >= 5;

-- 1934: Confirmation Rate 
-- https://leetcode.com/problems/confirmation-rate/
SELECT s.user_id, ROUND(AVG(IF(c.action='confirmed', 1, 0)), 2) AS confirmation_rate 
FROM Signups s 
LEFT JOIN Confirmations c ON s.user_id = c.user_id 
GROUP BY user_id;

-- 620: Not Boring Movies
-- https://leetcode.com/problems/not-boring-movies/
SELECT * 
FROM Cinema 
WHERE id % 2 != 0 AND description != 'boring'
ORDER BY id DESC;

-- 1251: Average Selling Price 
-- https://leetcode.com/problems/average-selling-price/
SELECT p.product_id, IFNULL(ROUND(SUM(units*price)/SUM(units), 2), 0) AS average_price 
FROM Prices p 
LEFT JOIN UnitsSold u ON p.product_id = u.product_id 
AND u.purchase_date BETWEEN p.start_date AND p.end_date 
GROUP BY product_id;

-- 1075: Project Employyes I
-- https://leetcode.com/problems/project-employees-i/
SELECT project_id, ROUND(AVG(e.experience_years), 2) AS average_years 
FROM Project p 
LEFT JOIN Employee e ON p.employee_id = e.employee_id 
GROUP BY project_id;

-- 1633: Percentage of Users Attended a Contest
-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/
SELECT contest_id, ROUND(COUNT(user_id)/(SELECT COUNT(*) FROM Users)*100, 2) AS percentage 
FROM Register 
GROUP BY contest_id 
ORDER BY percentage DESC, contest_id ASC;

-- 1211: Queries Quality and Percentage
-- https://leetcode.com/problems/queries-quality-and-percentage/
SELECT query_name, ROUND(AVG(rating/position),2) AS quality, ROUND(COUNT(CASE WHEN rating < 3 THEN 1 END)/COUNT(rating)*100, 2) AS poor_query_percentage 
FROM Queries
GROUP BY query_name;

-- 1193: Monthly Transactions I
-- https://leetcode.com/problems/monthly-transactions-i/
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country, COUNT(id) AS trans_count, SUM(IF(state='approved', 1, 0)) AS approved_count, SUM(amount) AS trans_total_amount, SUM(IF(state='approved', amount, 0)) AS approved_total_amount 
FROM Transactions 
GROUP BY month, country;

-- 1174: Immediate Food Delivery II
-- https://leetcode.com/problems/immediate-food-delivery-ii/
SELECT ROUND(AVG(order_date = customer_pref_delivery_date)*100, 2) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) 
IN (
    SELECT customer_id, MIN(order_date) 
    FROM Delivery 
    GROUP BY customer_id
);

-- 550: Game Play Analysis IV
-- https://leetcode.com/problems/game-play-analysis-iv/
SELECT ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM Activity
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) 
IN (
    SELECT player_id, MIN(event_date) 
    FROM Activity 
    GROUP BY player_id
);

-- 2356: NUmber of Unique Subjects Taught by Each Teacher
-- https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt 
FROM Teacher
GROUP BY teacher_id;

-- 1141: User Activity for the Past 30 Days I
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users 
FROM Activity 
WHERE DATEDIFF('2019-07-27', activity_date) BETWEEN 0 AND 29 
GROUP BY day;

-- 1070: Product Sales Analysis III
-- https://leetcode.com/problems/product-sales-analysis-iii/
SELECT product_id, year AS first_year, quantity, price 
FROM Sales 
WHERE (product_id, year) 
IN (
    SELECT product_id, MIN(year) AS year 
    FROM Sales 
    GROUP BY product_id
);

-- 596: Classes More Than 5 Students
-- https://leetcode.com/problems/classes-more-than-5-students/
SELECT class 
FROM Courses 
GROUP BY class 
HAVING COUNT(class) >= 5; 

-- 1729: Find Followes Count
-- https://leetcode.com/problems/find-followers-count/
SELECT user_id, COUNT(follower_id) AS followers_count 
FROM Followers 
GROUP BY user_id 
ORDER BY user_id ASC;

-- 619: Single Biggest Number
-- https://leetcode.com/problems/biggest-single-number/
SELECT MAX(num) AS num 
FROM (
    SELECT num 
    FROM MyNumbers 
    GROUP BY num 
    HAVING COUNT(*) = 1
) AS nums;

-- 1045: Customers Who Bought All Products
-- https://leetcode.com/problems/customers-who-bought-all-products/
SELECT customer_id 
FROM Customer 
GROUP BY customer_id 
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*) 
    FROM Product
);

-- 1731: The Number of Employees Which Report to Each Employee
-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/
SELECT e1.employee_id, e1.name, COUNT(e2.employee_id) AS reports_count, ROUND(AVG(e2.age)) AS average_age 
FROM Employees e1 
LEFT JOIN Employees e2 
ON e1.employee_id = e2.reports_to 
WHERE e2.reports_to IS NOT NULL 
GROUP BY employee_id 
ORDER BY employee_id;

-- 1789: Primary Department For Each Employee
-- https://leetcode.com/problems/primary-department-for-each-employee/
SELECT employee_id, department_id 
FROM Employee 
WHERE primary_flag = 'Y' 
OR employee_id IN (
    SELECT employee_id 
    FROM Employee 
    GROUP BY employee_id 
    HAVING COUNT(employee_id) = 1
);

-- 610: Triangle Judegment
-- https://leetcode.com/problems/triangle-judgement/
SELECT x, y, z, IF(x + y > z AND x + z > y AND y + z > x, 'Yes', 'No') AS triangle 
FROM Triangle;

-- 180: Consecutive Numbers
--  https://leetcode.com/problems/consecutive-numbers/
SELECT DISTINCT l1.num AS ConsecutiveNums 
FROM Logs l1, Logs l2, Logs l3 
WHERE l1.id = l2.id - 1 AND l2.id = l3.id-1 AND l1.num = l2.num AND l2.num = l3.num;

-- 1164: Product Price at a Given Date
-- https://leetcode.com/problems/product-price-at-a-given-date/
(SELECT product_id, 10 AS price 
FROM Products 
GROUP BY product_id 
HAVING MIN(change_date) > '2019-08-16' )
UNION ALL
(SELECT product_id, new_price AS price 
FROM Products 
WHERE (product_id, change_date) IN (
    SELECT product_id, MAX(change_date) 
    FROM Products 
    WHERE change_date <= '2019-08-16' 
    GROUP BY product_id
));

-- 1204: Last Person to Fit in the Bus
-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/
SELECT person_name 
FROM (
    SELECT person_name, turn, sum(weight) OVER (ORDER BY turn) AS total 
    FROM Queue
) t1 
WHERE total <= 1000 
ORDER BY turn DESC
LIMIT 1;

-- 1907: COunt Salary Categories
-- https://leetcode.com/problems/count-salary-categories/
SELECT 'Low Salary' AS category, 
COUNT(IF(income < 20000, 1, null)) AS accounts_count 
FROM Accounts
UNION ALL
SELECT 'Average Salary' AS category, 
COUNT(IF(income >= 20000 AND income <= 50000, 1, null)) AS accounts_count 
FROM Accounts
UNION ALL
SELECT 'High Salary' AS category, 
COUNT(IF(income > 50000, 1, null)) AS accounts_count 
FROM Accounts;

-- 1978: Employees Whose Manager Left the Company
-- https://leetcode.com/problems/employees-whose-manager-left-the-company/
SELECT employee_id 
FROM Employees 
WHERE salary < 30000 AND manager_id NOT IN (
    SELECT employee_id 
    FROM Employees
) 
ORDER BY employee_id;

-- 626: Exchange Seats
--

-- 1341: Movie Rating
-- https://leetcode.com/problems/movie-rating/
(SELECT u.name AS results 
FROM MovieRating mr 
JOIN Users u ON u.user_id = mr.user_id 
GROUP BY u.name 
ORDER BY COUNT(*) DESC, u.name LIMIT 1)
UNION ALL
(SELECT title AS results 
FROM MovieRating mr 
JOIN Movies m ON m.movie_id = mr.movie_id 
WHERE DATE_FORMAT(mr.created_at, '%Y-%m') = '2020-02' 
GROUP BY m.title 
ORDER BY AVG(mr.rating) DESC, m.title LIMIT 1);

-- 1321: Restaurant Growth
--

-- 602: Friend Requests II: Who Has the Most Friends
--

-- 585: Investments in 2016
--

-- 185: Department Top Three Salaries
--

-- 1667: Fix Names in a Table
-- https://leetcode.com/problems/fix-names-in-a-table/
SELECT user_id, CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2))) AS name 
FROM Users 
ORDER BY user_id;

-- 1527: Patients With a Condition
-- https://leetcode.com/problems/patients-with-a-condition/
SELECT patient_id, patient_name, conditions 
FROM Patients 
WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%';

-- 196: Delete Duplicate Emails
-- https://leetcode.com/problems/delete-duplicate-emails/
DELETE p1 
FROM Person p1, Person p2 
WHERE p1.email = p2.email AND p1.id > p2.id;

-- 176: Second Highest Salary
-- https://leetcode.com/problems/second-highest-salary/
SELECT MAX(salary) AS SecondHighestSalary 
FROM Employee 
WHERE salary < (
    SELECT MAX(salary) 
    FROM Employee
);

-- 1484: Group SOld Products By The Date
-- https://leetcode.com/problems/group-sold-products-by-the-date/
SELECT sell_date, COUNT(DISTINCT product) AS num_sold, GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') AS products 
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;

-- 1327: List the Products Ordered in a Period 
-- https://leetcode.com/problems/list-the-products-ordered-in-a-period/
SELECT product_name, SUM(unit) AS unit 
FROM Products p, Orders o 
WHERE p.product_id = o.product_id AND DATE_FORMAT(order_date, '%Y-%m') = '2020-02' 
GROUP BY product_name 
HAVING unit >= 100;

-- 1517: Find Users With Valid E-Mails
-- https://leetcode.com/problems/find-users-with-valid-e-mails/
SELECT * 
FROM USERS 
WHERE mail REGEXP '^[a-zA-Z][A-Za-z0-9_.\-]*@leetcode[.]com$';
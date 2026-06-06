SELECT count(*) FROM sales;
DESCRIBE sales;
SELECT `Order Date`, `Ship Date` FROM sales LIMIT 5;
SELECT * FROM sales;

ALTER TABLE sales ADD COLUMN Order_Date_fixed DATE;
ALTER TABLE sales ADD COLUMN Ship_Date_fixed DATE;
SELECT * FROM sales;

SET SQL_SAFE_UPDATES = 0;

UPDATE sales SET Order_Date_fixed = STR_TO_DATE(`Order Date`, '%m/%d/%Y');
UPDATE sales SET Ship_Date_fixed = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');

SELECT `Order Date`, Order_Date_fixed, `Ship Date`, Ship_Date_fixed
FROM sales
LIMIT 10;
ALTER TABLE sales DROP COLUMN `Order Date`;
ALTER TABLE sales DROP COLUMN `Ship Date`;

ALTER TABLE sales CHANGE Order_Date_fixed `Order Date` DATE;
ALTER TABLE sales CHANGE Ship_Date_fixed `Ship Date` DATE;

-- Customers table
SELECT `Customer ID`, COUNT(DISTINCT Segment) AS segment_count
FROM sales
GROUP BY `Customer ID`
HAVING segment_count > 1;

CREATE TABLE customers AS
SELECT DISTINCT `Customer ID`, `Customer Name`,Segment
FROM sales;

SELECT count(*)
FROM customers;

ALTER TABLE customers
MODIFY `Customer ID` VARCHAR(20);

ALTER TABLE customers
ADD PRIMARY KEY (`Customer ID`);

SELECT *
FROM customers
ORDER BY `Customer ID`;


-- Products table
SELECT `Product ID`,count(DISTINCT `Product Name`) as p
FROM sales 
GROUP BY `Product ID`
HAVING p>1;

SELECT `Product ID`, `Product Name` 
FROM sales 
WHERE `Product ID` = 'FUR-BO-10002213';


CREATE TABLE products AS
SELECT DISTINCT `Product ID`, `Product Name`, Category, `Sub-Category`
FROM sales;

ALTER TABLE products ADD COLUMN Product_Key INT AUTO_INCREMENT PRIMARY KEY;
SELECT * FROM Products;

ALTER TABLE products
MODIFY COLUMN Product_Key INT AUTO_INCREMENT FIRST;

-- Orders table
DROP TABLE orders;
CREATE TABLE orders AS
SELECT DISTINCT `Order ID`,`Customer ID`,`Order Date`
FROM sales;

ALTER TABLE orders MODIFY COLUMN `Order ID` VARCHAR(20) PRIMARY KEY;

ALTER TABLE orders MODIFY COLUMN `Customer ID` VARCHAR(20);
ALTER TABLE orders
ADD CONSTRAINT orders_fk
FOREIGN KEY (`Customer ID` )
REFERENCES customers(`Customer ID`);
SELECT * FROM Orders;

-- shipping
CREATE TABLE shipping AS
SELECT DISTINCT
    `Order ID`,
    `Ship Mode`,
    `Ship Date`,
    Country,
    City,
    State,
    `Postal Code`,
    Region
FROM sales;

ALTER TABLE shipping MODIFY COLUMN `Order ID` VARCHAR(20) PRIMARY KEY;
ALTER TABLE shipping
ADD CONSTRAINT shipping_fk
FOREIGN KEY (`Order ID` )
REFERENCES orders(`Order ID`);
DESCRIBE shipping;

SHOW CREATE TABLE shipping;

-- sales table
CREATE TABLE order_items AS
SELECT DISTINCT
    `Row ID`,
    `Order ID`,
    `Product ID`,
    `Product Name`,
    Quantity,
    Sales,
    Discount,
    Profit
FROM sales;

ALTER TABLE order_items
MODIFY COLUMN `Row ID` INT PRIMARY KEY;

ALTER TABLE order_items MODIFY COLUMN `Order ID` VARCHAR(20);
ALTER TABLE order_items
ADD CONSTRAINT order_items_fk
FOREIGN KEY (`Order ID`)
REFERENCES orders(`Order ID`);








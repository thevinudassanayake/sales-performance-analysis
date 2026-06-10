-- 1. Product performance: revenue and profit by category
SELECT p.Category,ROUND(SUM(oi.Sales),2) as Total_Sales, ROUND(SUM(oi.Profit),2) as Total_Profit, 
SUM(oi.Quantity) as Units_Sold
FROM order_items as oi
JOIN products as p ON oi.`Product ID` = p.`Product ID`
GROUP BY p.Category
ORDER BY Total_Sales DESC;

-- 2. Top 10 sub-categories by revenue
SELECT p.`Sub-Category`, ROUND(SUM(oi.Sales),2) as Total_Sales, ROUND(SUM(oi.Profit),2) as Total_Profit
FROM order_items as oi
JOIN products as p ON oi.`Product ID` = p.`Product ID`
GROUP BY p.`Sub-Category`
ORDER BY Total_Sales DESC
LIMIT 10;

-- 3. Revenue trend by year
SELECT YEAR(o.`Order Date`) AS Order_Year, ROUND(SUM(oi.Sales), 2) AS Total_Sales, ROUND(SUM(oi.Profit), 2) AS Total_Profit
FROM order_items as oi
JOIN orders as o ON oi.`Order ID` = o.`Order ID`
GROUP BY Order_Year
ORDER BY Order_Year;

-- 4. Regional (branch) performance
SELECT s.Region, ROUND(SUM(oi.Sales), 2) AS Total_Sales, ROUND(SUM(oi.Profit), 2) AS Total_Profit, ROUND(SUM(oi.Profit) / SUM(oi.Sales) * 100, 2) AS Profit_Margin_Pct
FROM order_items oi
JOIN orders as o ON oi.`Order ID` = o.`Order ID`
JOIN shipping as s ON o.`Order ID` = s.`Order ID`
GROUP BY s.Region
ORDER BY Total_Sales DESC;

-- 5. Top 10 customers by total spend
SELECT c.`Customer Name`, c.Segment,
       ROUND(SUM(oi.Sales), 2) AS Total_Spend,
       ROUND(SUM(oi.Profit), 2) AS Total_Profit
FROM order_items as oi
JOIN orders as o ON oi.`Order ID` = o.`Order ID`
JOIN customers as c ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.`Customer Name`, c.Segment
ORDER BY Total_Spend DESC
LIMIT 10;

-- 6. Discount impact on profit
SELECT
  CASE
    WHEN Discount = 0 THEN 'No Discount'
    WHEN Discount <= 0.2 THEN 'Low (1-20%)'
    WHEN Discount <= 0.4 THEN 'Medium (21-40%)'
    ELSE 'High (>40%)'
  END AS Discount_Band,
  ROUND(AVG(Profit), 2) AS Avg_Profit,
  ROUND(AVG(Sales), 2) AS Avg_Sales,
  COUNT(*) AS Order_Count
FROM order_items
GROUP BY Discount_Band
ORDER BY Avg_Profit DESC;

-- 7. Shipping mode impact on profit
SELECT s.`Ship Mode`,
       COUNT(*) AS Total_Orders,
       ROUND(SUM(oi.Sales), 2) AS Total_Sales,
       ROUND(AVG(oi.Profit), 2) AS Avg_Profit
FROM order_items as oi
JOIN orders as o ON oi.`Order ID` = o.`Order ID`
JOIN shipping s ON o.`Order ID` = s.`Order ID`
GROUP BY s.`Ship Mode`
ORDER BY Avg_Profit DESC;

-- 8. Top 5 most profitable products per category 
SELECT Category, `Product Name`, Total_Profit, rnk
FROM (

  SELECT p.Category, oi.`Product Name`,
         ROUND(SUM(oi.Profit), 2) as Total_Profit,
         RANK() OVER (PARTITION BY p.Category ORDER BY SUM(oi.Profit) DESC) as rnk
  FROM order_items as oi
  JOIN products as p ON oi.`Product ID` = p.`Product ID`
  GROUP BY p.Category, oi.`Product Name`
  
)ranked
WHERE rnk <= 5;
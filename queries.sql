USE superstore;

SELECT *
FROM sales;

-- What are the total sales and profit for each category?
SELECT Category, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM sales
GROUP BY Category;

-- How many orders were placed in each region?
SELECT Region, COUNT(DISTINCT `Order ID`) AS TotalOrders
FROM sales
GROUP BY Region;

-- What is the average discount for each sub-category?
SELECT `Sub-Category`, AVG(Discount) AS AverageDiscount
FROM sales
GROUP BY `Sub-Category`;

-- Which ship mode is used the most and least?
SELECT `Ship Mode`, COUNT(*) AS OrderCount
FROM sales
GROUP BY `Ship Mode`
ORDER BY OrderCount DESC;

-- What is the overall profit percentage?
SELECT (SUM(Profit) / SUM(Sales)) * 100 AS ProfitPercentage
FROM sales;

-- Which products had a negative profit?
SELECT `Product Name`, Profit
FROM sales
WHERE Profit < 0;

-- What is the distribution of the quantity of products sold in each category?
SELECT Category, AVG(Quantity) AS AvgQuantity, MIN(Quantity) AS MinQuantity, MAX(Quantity) AS MaxQuantity
FROM sales
GROUP BY Category;

-- How does the average discount vary across different regions?
SELECT Region, AVG(Discount) AS AvgDiscount
FROM sales
GROUP BY Region;

-- For each year, what is the total sales and profit?
SELECT YEAR(`Order Date`) AS OrderYear, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM sales
GROUP BY OrderYear
ORDER BY OrderYear;

-- What are the top 5 cities with the highest total sales?
SELECT City, SUM(Sales) AS TotalSales
FROM sales
GROUP BY City
ORDER BY TotalSales DESC
LIMIT 5;

-- How many orders have a negative profit margin (profit divided by sales)?
SELECT COUNT(*) AS NegativeProfitOrders
FROM sales
WHERE (Profit / Sales) < 0;

-- What is the average profit margin for each category?
SELECT Category, AVG(Profit / Sales) AS AvgProfitMargin
FROM sales
GROUP BY Category;

-- For each product category, what is the total sales and profit, and what percentage of total sales does it represent?
WITH CategorySales AS (
    SELECT
        Category,
        SUM(Sales) AS TotalCategorySales,
        SUM(Profit) AS TotalCategoryProfit
    FROM sales
    GROUP BY Category
)
SELECT
    c.Category,
    c.TotalCategorySales,
    c.TotalCategoryProfit,
    (c.TotalCategorySales / s.TotalOverallSales) * 100 AS SalesPercentage
FROM CategorySales c
JOIN (
    SELECT SUM(Sales) AS TotalOverallSales
    FROM sales
) s ON 1=1;


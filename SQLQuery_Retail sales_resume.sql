USE RetailSalesDB;

CREATE TABLE SalesData (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code INT,
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales FLOAT
);

select * from [dbo].[train]

Step 2: Data Cleaning & Preprocessing
1️⃣ Check for NULL values

SELECT 
    SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS Null_Order_ID,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS Null_Order_Date,
    SUM(CASE WHEN Ship_Date IS NULL THEN 1 ELSE 0 END) AS Null_Ship_Date,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Null_Customer_ID,
    SUM(CASE WHEN Postal_Code IS NULL THEN 1 ELSE 0 END) AS Null_Postal_Code,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS Null_Region,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Null_Sales
FROM train;

Fix NULL Values
If Postal_Code or any column has NULL values, update them with a default value.

Fix NULLs in Postal Code

UPDATE  [dbo].[train]
SET Postal_Code = 0 
WHERE Postal_Code IS NULL;

------------------------------------------------------------------------------------------------
Basic SQL Queries for Sales Analysis
Now that data is clean, lets analyze it.

--------------------------------------------------------------------------------------------------
Get Total Sales for Each Month

SELECT 
    FORMAT(Order_Date, 'yyyy-MM') AS Month, 
    SUM(Sales) AS Total_Sales
FROM [dbo].[train]
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY Month;
✅ This helps in identifying sales trends over time.

---------------------------------------------------------------------------
op 5 Best-Selling Product Categories

SELECT top 5
    Category, 
    SUM(Sales) AS Total_Revenue
FROM [dbo].[train]
GROUP BY Category
ORDER BY Total_Revenue DESC;
This identifies the most profitable product categories are:
Technology	827455.870952964
Furniture	728658.574223876
Office Supplies	705422.333252728

-----------------------------------------------------------------------------------------
 Sales Performance by Region

SELECT 
    Region, 
    SUM(Sales) AS Total_Sales
FROM [dbo].[train]
GROUP BY Region
ORDER BY Total_Sales DESC;
✅ Helps in understanding which regions generate the highest revenue are:
West	710219.683321834
East	669518.723715305
Central	492646.912053883
South	389151.459338546

----------------------------------------------------------------------------------------
Get Top 5 Best-Selling Product Categories

SELECT TOP 5 
    Category, 
    SUM(Sales) AS Total_Revenue
FROM train
GROUP BY Category
ORDER BY Total_Revenue DESC;

Shows the top 5 product categories with the highest sales.
Technology	827455.870952964
Furniture	728658.574223876
Office Supplies	705422.333252728

-----------------------------------------------------------------------------
Get Top 5 Customers by Total Spending

SELECT TOP 5 
    Customer_Name, 
    SUM(Sales) AS Total_Spending
FROM train
GROUP BY Customer_Name
ORDER BY Total_Spending DESC;
✅ Finds the most valuable customers based on total purchases.

Sean Miller	25043.0504860878
Tamara Chand	19052.217195034
Raymond Buch	15117.3389587402
Tom Ashbrook	14595.6198644638
Adrian Barton	14473.571243763

------------------------------------------------------------------------------------------

Get Top 5 Best-Selling Products

SELECT TOP 5 
    Product_Name, 
    COUNT(Order_ID) AS Total_Orders, 
    SUM(Sales) AS Total_Sales
FROM train
GROUP BY Product_Name
ORDER BY Total_Sales DESC;
✅ Finds the top 5 products by total revenue and order count.

Canon imageCLASS 2200 Advanced Copier	5	61599.822265625
Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind	10	27453.3840332031
Cisco TelePresence System EX90 Videoconferencing Unit	1	22638.48046875
HON 5400 Series Task Chairs for Big and Tall	8	21870.5755004883
GBC DocuBind TL300 Electric Binding System	11	19823.

----------------------------------------------------------------------------------------------------
SELECT @@SERVERNAME, SERVERPROPERTY('InstanceName');






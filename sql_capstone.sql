CREATE DATABASE capstone_1;
SELECT * FROM blinkit_table;
USE capstone_1;

ALTER TABLE blinkit_table
CHANGE `Item Fat Content` Item_Fat_Content VARCHAR(255);

ALTER TABLE blinkit_table
CHANGE `Item Identifier` Item_Identifier VARCHAR(255),
CHANGE `Item Type` Item_Type VARCHAR(255),
CHANGE `Outlet Establishment Year` Outlet_Establishment_Year INT,
CHANGE `Outlet Identifier` Outlet_Identifier VARCHAR(255),
CHANGE `Outlet Location Type` Outlet_Location_Type VARCHAR(255),
CHANGE `Outlet Size` Outlet_Size VARCHAR(255),
CHANGE `Outlet Type` Outlet_Type VARCHAR(255),
CHANGE `Item Visibility` Item_Visibility DECIMAL(10,4),
CHANGE `Item Weight` Item_Weight DECIMAL(10,2),
CHANGE `Sales` Sales DECIMAL(10,2),
CHANGE `Rating` Rating DECIMAL(3,2);

SELECT CAST(SUM(Sales) / 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM blinkit_table
WHERE Outlet_Establishment_Year = 2022;

SELECT CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales 
FROM blinkit_table
WHERE Outlet_Establishment_Year = 2022;

SELECT COUNT(*) AS No_Of_Items 
FROM blinkit_table
WHERE Outlet_Establishment_Year = 2022;

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating 
FROM blinkit_table;

SELECT Item_Fat_Content, 
       SUM(Sales) AS Total_Sales
FROM blinkit_table
GROUP BY Item_Fat_Content;

SELECT Item_Fat_Content,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_table
GROUP BY Item_Fat_Content
ORDER BY Sales DESC;

SELECT 
    Outlet_Location_Type,
    ROUND(SUM(CASE 
                WHEN LOWER(Item_Fat_Content) IN ('low fat', 'lf') THEN Sales 
                ELSE 0 
              END), 2) AS Low_Fat,
    ROUND(SUM(CASE 
                WHEN LOWER(Item_Fat_Content) IN ('regular', 'reg') THEN Sales 
                ELSE 0 
              END), 2) AS Regular
FROM blinkit_table
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

SELECT 
    Outlet_Establishment_Year,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_table
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales DESC;

SELECT 
    Outlet_Size,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        (SUM(Sales) * 100.0) / 
        (SELECT SUM(Sales) FROM blinkit_table)
        AS DECIMAL(10,2)
    ) AS Sales_Percentage
FROM blinkit_table
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

SELECT 
    Outlet_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(
        (SUM(Sales) * 100.0) / 
        (SELECT SUM(Sales) FROM blinkit_table)
        AS DECIMAL(10,2)
    ) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_table
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;











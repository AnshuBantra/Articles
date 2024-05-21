WITH

    EmployeeDepartmentHistory AS (
            SELECT      *
                FROM    AdventureWorks2019.HumanResources.EmployeeDepartmentHistory
                WHERE   EndDate IS NULL
        )
    , employee_rates AS (
        SELECT      BusinessEntityID
                    , Rate
                    , ModifiedDate
            FROM    AdventureWorks2019.HumanResources.EmployeePayHistory AS EPH1
            WHERE   EPH1.ModifiedDate = (   SELECT      MAX(EPH2.ModifiedDate)
                                                FROM    AdventureWorks2019.HumanResources.EmployeePayHistory AS EPH2
                                                WHERE   EPH2.BusinessEntityID = EPH1.BusinessEntityID
                                        )
        )
    , employees AS (
        SELECT  DISTINCT
                    HRE.BusinessEntityID    AS Employee_ID
                    , PPE.FirstName         AS First_Name
                    , PPE.LastName          AS Last_Name
                    , HRE.HireDate          AS Hire_Date
                    , HRD.Name              AS Department
                    , ROUND(HEP.Rate, 2)    AS Rate
                    , AVG(HEP.Rate) OVER (PARTITION BY HRD.Name) AS Avg_Department_Rate
            FROM        AdventureWorks2019.HumanResources.Employee                  AS HRE 
                JOIN    EmployeeDepartmentHistory                                   AS HED
                        ON HRE.BusinessEntityID = HED.BusinessEntityID
                JOIN    AdventureWorks2019.HumanResources.Department                AS HRD
                        ON HED.DepartmentID = HRD.DepartmentID
                JOIN    employee_rates                                              AS HEP
                        ON HRE.BusinessEntityID = HEP.BusinessEntityID
                JOIN    AdventureWorks2019.Person.Person                            AS PPE
                        ON HRE.BusinessEntityID = PPE.BusinessEntityID
            -- ORDER BY
            --         HRE.BusinessEntityID
        )
    , order_details AS (
            SELECT      
                        OrderDate
                        , ROUND(SUM(TotalDue),0)            AS Total_Sales
                        , COUNT(DISTINCT SalesOrderID)      AS Order_Count
                FROM    AdventureWorks2019.Sales.SalesOrderHeader
                GROUP BY
                        OrderDate
                -- ORDER BY
                --         OrderDate
        )

-- Row_Number
    -- SELECT    
    --         Employee_ID
    --         , Rate
    --         , ROW_NUMBER() OVER(ORDER BY Rate DESC) As Rate_Rank
    --     FROM
    --         employees

-- Dense_Rank
    -- SELECT  
    --         Employee_ID
    --         , Hire_Date
    --         , DENSE_RANK() OVER(ORDER BY Hire_Date) As Hire_Rank
    --     FROM
    --         employees
    --     ORDER BY
    --         Hire_Rank

-- Employee Rate compared to Department AVG
    --     SELECT      Employee_ID
    --                 , Department
    --                 , Rate
    --                 , AVG(Rate) OVER( PARTITION BY Department) AS AVG_Dept_Rate
    --         FROM    employees
    --         WHERE   Employee_ID<= 218

-- SELECT      Employee_ID
--             , Rate
--             , PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY rate) OVER() AS Rate_90_percentile
--     FROM    employees
--     ORDER BY
--             rate DESC


-- -- -- Running Sum
-- SELECT      OrderDate
--             , Total_Sales
--             , SUM(Total_Sales) OVER(ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING  AND CURRENT ROW) AS Running_Sales
--             , Order_Count
--             , SUM(Order_Count) OVER(ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING  AND CURRENT ROW) AS Running_Orders
--     FROM    order_details
--     ORDER BY
--             OrderDate


-- -- -- Moving 7 Day Average Sales
-- SELECT  
--             OrderDate
--             , Total_Sales
--             , AVG(Total_Sales) OVER(ORDER BY OrderDate ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS Avg_7_Day_Sales
--     FROM    order_details


-- Lead & Lag
SELECT      OrderDate
            , LAg(Total_Sales) OVER(ORDER BY OrderDate )  AS Previous_Days_Sales
            , Total_Sales
            , LEAD(Total_Sales) OVER(ORDER BY OrderDate ) AS Next_Days_Sales
    FROM    order_details
    WHERE   OrderDate < '2011-06-04'
        OR  OrderDate > '2014-06-27'
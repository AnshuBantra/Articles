-- CTE's.sql

-- 1. Hierarchical Data Processing:
WITH
    RecursiveOrg AS (
        SELECT  RLE.BusinessEntityID        AS EmployeeID
                , RLE.LoginID
                , RLE.JobTitle
                , RLE.OrganizationLevel     AS ManagerID
            FROM    HumanResources.Employee AS RLE
            WHERE   OrganizationLevel IS NULL -- Root Level Employees
        UNION ALL
        SELECT      DRE.BusinessEntityID    AS EmployeeID
                    , DRE.LoginID
                    , DRE.JobTitle
                    , DRE.OrganizationLevel AS ManagerID
            FROM    HumanResources.Employee AS DRE
                JOIN
                    RecursiveOrg            AS RO ON DRE.OrganizationLevel = RO.EmployeeID  -- Direct Reporting Employees
        )
-- Main Query --
SELECT      *
    FROM    RecursiveOrg;


-- 2. Data Transformation and Aggregation:
WITH
    ProductHierarcy AS (
        SELECT      pp.ProductID
                    , pp.Name                       AS ProductName
                    , ps.ProductSubcategoryID       AS SubSategoryID
                    , ps.Name                       AS Subcategory
                    , pc.ProductCategoryID          AS CategoryID
                    , pc.Name                       AS Category
            FROM    Production.Product              AS pp
                JOIN
                    Production.ProductSubcategory   AS ps   ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
                JOIN
                    Production.ProductCategory      AS pc   ON ps.ProductCategoryID = pc.ProductCategoryID        
    ),

    ProductSales AS (
        SELECT      sod.ProductID
                    , SUM(sod.LineTotal)    AS TotalSales
            FROM    Sales.SalesOrderDetail  AS sod
            GROUP BY sod.ProductID
    )

-- Main Query --
SELECT      ph.Category
            , ROUND(SUM(TotalSales), 2) As TotalSales
    FROM    ProductSales    AS ps
        JOIN
            ProductHierarcy AS ph   on ps.ProductID = ph.ProductID
    GROUP BY
            ph.Category;


--3. Subquery Replacement
WITH
    ProductHierarcy AS (
        SELECT      pp.ProductID
                    , pp.Name                       AS ProductName
                    , pp.ListPrice                  AS ListPrice
                    , ps.ProductSubcategoryID       AS SubSategoryID
                    , ps.Name                       AS Subcategory
                    , pc.ProductCategoryID          AS CategoryID
                    , pc.Name                       AS Category
            FROM    Production.Product              AS pp
                JOIN
                    Production.ProductSubcategory   AS ps   ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
                JOIN
                    Production.ProductCategory      AS pc   ON ps.ProductCategoryID = pc.ProductCategoryID        
    ),

    AVG_Price_By_Category AS (
        SELECT      Category
                    , AVG(ListPrice) AS AvgListPrice
            FROM    ProductHierarcy
            GROUP BY
                    Category
    )

SELECT      ph.ProductName
            , ph.Subcategory
            , ph.Category
            , ph.ListPrice
            , avgp.AvgListPrice
    FROM    ProductHierarcy         AS ph
        JOIN    
            AVG_Price_By_Category   AS avgp on ph.Category = avgp.Category
    WHERE   ph.ListPrice > avgp.AvgListPrice


-- Recursive

WITH RecursiveBOM AS (
    SELECT      ComponentID
                , ProductAssemblyID
                , ComponentID AS TopLevelProduct
        FROM    Production.BillOfMaterials
        WHERE   ProductAssemblyID = 749
    UNION ALL
    SELECT      bom.ComponentID
                , bom.ProductAssemblyID
                , rb.TopLevelProduct
        FROM    Production.BillOfMaterials  AS  bom
        JOIN    RecursiveBOM                AS  rb ON bom.ProductAssemblyID = rb.ComponentID
)
SELECT  DISTINCT
            *
    FROM    RecursiveBOM
    ORDER BY
            TopLevelProduct;



WITH
    EmployeeDetails AS (
        SELECT	    BusinessEntityID        AS EmployeeID
                    , LoginID
                    , JobTitle
                    , OrganizationLevel     AS ManagerID
            FROM    HumanResources.Employee
    ),

    RecursiveOrg AS (   
        SELECT	    *
            FROM    EmployeeDetails         AS RLE  -- Root Level Employees
            WHERE   ManagerID IS NULL
        UNION ALL
        SELECT      *
            FROM    EmployeeDetails         AS DRE  -- Direct Reporting Employees
                JOIN
                    RecursiveOrg            AS RO ON DRE.ManagerID = RO.ManagerID
        )
-- Main Query --
SELECT      *
    FROM    RecursiveOrg;
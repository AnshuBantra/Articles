# **Comprehensive Guide to Common Table Expressions (CTE's) in SQL**

## **Introduction to CTE's:**

Structured Query Language (SQL) is a powerful tool used for managing and manipulating relational databases. It provides various features and constructs to simplify complex queries and improve code readability. One such feature is **Common Table Expressions (CTE's)**, which offer several benefits and play a crucial role in managing complex queries, enhancing code readability & efficiency and also maintainability of SQL queries. In this guide, we'll delve into the syntax, benefits, and practical examples of CTE's using the AdventureWorks database as a reference.


### What are Common Table Expressions (CTE's)?

A Common Table Expression, often abbreviated as CTE, is a temporary result set that can be referenced within a SQL statement, including SELECT, INSERT, UPDATE, DELETE, or even another CTE. CTE's provide a way to define a named temporary result set, which can then be used multiple times in the same query. They are particularly useful for breaking down complex queries and logic into more manageable and understandable parts.

> ***"Any damn fool can write code that a computer can understand, the trick is to write code that humans can understand."***
>
>     Martin Fowler, Software Engineer and Author

This statement underscores the importance of writing code that is easy for humans to comprehend. CTE's can aid in achieving this goal by breaking down complex SQL queries into smaller, manageable and more understandable parts.


### **Syntax of CTE's:**

CTE's are defined using the **`WITH`** keyword, followed by the name of the CTE and its column list (optional). The CTE definition is enclosed within parentheses, similar to a subquery. Here's the basic syntax:

```sql
WITH
    CTE_name (column1, column2, ...) AS (
        -- CTE query definition
        SELECT      ...
            FROM    ...
            WHERE   ...
    )

SELECT      *
    FROM    CTE_name
```

Once defined, you can reference the CTE within the same query or subsequent queries.

#### **Benefits of CTE's:**

1. **Improved Readability and Maintainability:**
   CTE's enhance the readability of SQL queries by providing a clear and descriptive way to define temporary result sets. CTE's do this by allowing you to break down complex queries into smaller, more readable parts. By giving a name to each temporary result set, you can easily understand the purpose and logic of each part of the query. This improves code maintainability, as it becomes easier to debug and modify SQL queries.
2. **Code Reusability:**
   Since CTE's can be referenced multiple times within the same query or across different queries, they promote code reusability and reduce redundancy. Instead of duplicating complex subqueries, you can define them once as CTE's and reuse them wherever needed. This reduces redundancy and helps maintain consistency across your SQL codebase.
3. **Optimization and Performance:**
   In certain scenarios, using CTE's can lead to improved query performance by allowing the SQL optimizer to optimize each part of the query individually.  SQL query optimizers can often recognize and optimize CTE's, leading to more efficient execution plans. Additionally, by breaking down complex queries into smaller parts, you can sometimes improve the overall performance by allowing the database engine to optimize each part individually.
4. **Recursive Queries:**
   CTE's support recursion, meaning they can reference themselves within the definition. This feature is particularly useful for querying hierarchical data structures such as organizational charts, file systems, or product categories. Recursive CTE's enable you to traverse and manipulate hierarchical data with ease, making them a powerful tool for data analysis.
5. **Clarity in Self-Join Queries:**
   CTE's can enhance the clarity of self-joins in SQL queries. Instead of directly joining a table to itself, you can define a CTE representing the table with a different alias. This makes the query more intuitive and easier to understand, especially for developers who may not be familiar with the database schema.

---


## **Practical Examples of CTE's:**

Let's explore some common scenarios and practical examples where CTE's can be applied effectively using the AdventureWorks database ([Link to download AdventureWorks database](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)).

### **1: Recursive CTE for Hierarchical Data:**

Suppose you have a table representing an organizational hierarchy with columns like employee_id, manager_id, and name. Using a recursive CTE, you can traverse the hierarchy to find all employees reporting to a particular manager or to construct an organizational chart.

```sql
WITH
    RecursiveOrg AS (
        SELECT	    RLE.BusinessEntityID        AS EmployeeID
                    , RLE.LoginID
                    , RLE.JobTitle
                    , RLE.OrganizationLevel     AS ManagerID
            FROM    HumanResources.Employee     AS RLE
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
```

This recursive CTE retrieves all employees in the organization along with their managers, starting from the top-level employees.


### **2: **Data Transformation and Aggregation**:**

CTE's can help us perform multi-level aggregations. Creating such multi-level aggregations can also help SQL Optimizer to optimise and make queries efficient. CTE's will store the results of aggregations, which can then be ustilised in the main query for final summarization:

```sql
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
```

This CTE calculates the total sales amount for each category, improving the readability and efficiency of the query.


### **3: **Subquery Replacement**:**

CTE's can help us perform multi-level aggregations. Creating such multi-level aggregations can also help SQL Optimizer to optimise and make queries efficient. CTE's will store the results of aggregations, which can then be ustilised in the main query for final summarization:

```sql
;WITH
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

-- Main Query --
SELECT      ph.ProductName
            , ph.Subcategory
            , ph.Category
            , ph.ListPrice
            , avgp.AvgListPrice
    FROM    ProductHierarcy         AS ph
        JOIN  
            AVG_Price_By_Category   AS avgp on ph.Category = avgp.Category
    WHERE   ph.ListPrice > avgp.AvgListPrice;
```

This CTE helps is getting a list of all products which have an above average price in their category.



**Conclusion:**

Common Table Expressions (CTEs) are a valuable feature of SQL that offer several benefits for query development and optimization. By improving code readability, promoting code reusability, and enabling advanced query techniques such as recursive processing, CTE's empower developers and data analysts to write more efficient and maintainable SQL code. Understanding when and how to leverage CTEs can greatly enhance your ability to work with relational databases and perform complex data analysis tasks. Experiment with CTE's in your SQL queries to unlock their full potential and enhance your data manipulation skills.

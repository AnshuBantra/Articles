# Another Way to Join Data in SQL

Joins are one of the most important and fundamental concepts in SQL, allowing you to combine data from multiple tables based on related columns. Joins enable you to establish relationships between tables, creating more comprehensive data views and unlocking the ability to perform complex analysis.

Till very recently, the above paragraph was what started my sessions / classes on SQL Joins. I would further continue saying another simple way to combine data if you have similar data (i.e. different table for transactional data of each year) in different tables is UNION.

![](https://miro.medium.com/v2/resize:fit:700/1*E36Da2h_KnXPiFsFYkEKFw.png)

Set Operations in SQL

However, today I’ll discuss in detail “ **Set Operations** ” in SQL. Set operations allow you to combine or compare results from multiple queries or data sets. These operations are particularly useful for manipulating and analyzing data from multiple tables, providing a convenient way to perform tasks such as finding common records, differences, or merging data sets.

![](https://miro.medium.com/v2/resize:fit:212/1*NKkyDL9pX_Vr4SnIGtzR1A.png)

UNION

**1. UNION Operator**

The UNION operation in SQL combines the results of two or more SELECT statements into a single result set. It returns all distinct rows from each of the input queries.

```
SELECT  column1
        , column2
  FROM  table1
UNION
SELECT  column1
        , column2
  FROM  table2;
```

The queries either side of ‘ **UNION** ’ must have the same number of columns and compatible data types for corresponding columns. If we take these two tables fy17 & fy18 as example, which have repeating `store_names` and ‘ **UNION** ’ them.

![](https://miro.medium.com/v2/resize:fit:1000/1*wq7CyLvGEX6NVP8cPsNeTg.png)

We see that by default, ‘ **UNION** ’ returns only distinct rows from the records of tables being combined together.

![](https://miro.medium.com/v2/resize:fit:700/1*aM6Q6-AhDNFMDLiT1j9qsA.png)

If you want to include duplicate rows, use ‘ **UNION ALL** ’.

![](https://miro.medium.com/v2/resize:fit:700/1*8LFtDbg2m9NunOQSo37nxA.png)

![](https://miro.medium.com/v2/resize:fit:212/1*QJ28QE1ScLvItV612Otdng.png)

**2. INTERSECT Operator**

The ‘ **INTERSECT** ’ operation might be the easiest way SQL provides to find common records between two data sets. ‘ **INTERSECT** ’ returns only the rows that are present in the result sets of both queries.

```
SELECT  column1
        , column2
  FROM  table1
INTERSECT
SELECT  column1
        , column2
  FROM  table2;
```

In this case as we can see these two tables have varied color names.

![](https://miro.medium.com/v2/resize:fit:700/1*d9VAfvkg2GZjyR4WxxiLAg.png)

When these tables are joined, with the set operator ‘ **INTERSECT** ’, it returns the common data points found in both these tables.

![](https://miro.medium.com/v2/resize:fit:700/1*qxDJSp52egP5RgVnMV4dJA.png)

Similar to UNION, the queries in ‘ **INTERSECT** ’ must have the same number of columns and compatible data types.

![](https://miro.medium.com/v2/resize:fit:222/1*TzkLFs349l7Y-eIbKxSnTQ.png)

**3. EXCEPT Operator**

The ‘ **EXCEPT** ’ operation (sometimes called ‘ **MINUS** ’ operator in some databases) returns the rows that are present in the first query but not in the second. In other words, returns the records unique to the first query. This is useful for finding records that exist in one data set but not in another.

```
SELECT  column1
        , column2
  FROM  table1
EXCEPT
SELECT  column1
        , column2
  FROM  table2;
```

Using the same example of tbl1 and tbl2 if we use ‘ **EXCEPT** ’ operator. It provides the colors present in tbl1 which are not present in tbl2 and removes the ones that are common in both tables.

![](https://miro.medium.com/v2/resize:fit:700/1*8ZcOJrbmayINTQj63dCPhQ.png)

Like the other set operations, the queries must have the same number of columns and compatible data types.

**Tips for Using Set Operations in SQL**

1. ***Consistency in Queries*** : Ensure that all SELECT statements in a set operation have the same number of columns and compatible data types in each column.
2. ***Order of Column*** *s* : The columns must appear in the same order in each query for set operations to work correctly.
3. ***Performance Considerations*** : While set operations are powerful, they can be resource-intensive, especially with large data sets. Use them judiciously and consider optimizing your queries as needed.
4. ***Handling Duplicates*** : By default, ‘UNION’ removes duplicates, while ‘UNION ALL’ does not. Choose the appropriate option based on your use case.

In conclusion, set operations in SQL are a set of versatile tools for combining, comparing, and manipulating data from multiple queries. By mastering these operations, you can perform more complex data analysis tasks and gain deeper insights from your data.

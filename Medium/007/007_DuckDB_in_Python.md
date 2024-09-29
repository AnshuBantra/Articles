# Using DuckDB in Python: A Comprehensive Guide

### Introduction to DuckDB

DuckDB is a high-performance, in-memory/in-process analytical database management system designed to execute complex analytical SQL queries fast, efficiently, and reliably over large datasets. It is often referred to as the "SQLite for analytics" due to its lightweight nature and ease of integration, making it ideal for analytics tasks, able to run entirely in memory or within an application.

It basically means that, DuckDB can process data fast, similar to traditional databases like PostgreSQL or SQLite, but without the need for an external server process. DuckDB is particularly well-suited for data analysis tasks, making it a powerful tool for data scientists and analysts.

### **Why DuckDB?**

* **In-Process DB** : DuckDB can be embedded directly into your Python environment, which means you don't need to manage a separate database server.
* **Columnar Storage** : It stores data in a columnar format, optimized for analytical queries.
* **SQL support** : DuckDB fully supports SQL queries, making it easy to interact with large datasets using well-known SQL syntax.
* **Fast and efficient** : DuckDB is designed for speed, particularly for analytical workloads like large aggregations or filtering operations.
* **Compatible with Pandas, Parquet, and Arrow** : It supports modern data formats, enabling seamless interaction with other data science libraries.

Let's explore how to use DuckDB in Python, going from installation to performing various operations like loading data, querying, and interacting with other Python libraries.

### Installation

To get started with DuckDB in Python, you need to install the DuckDB Python package. You can do this using `pip` or `conda`, depending on your environment:

```bash
pip install duckdb
```

or

```bash
conda install python-duckdb -c conda-forge
```

### Creating a DuckDB Database

In DuckDB, databases are either stored as files or kept in memory. For simplicity, let's first work with an **in-memory** database.

```python
import duckdb as dd

# Create an in-memory DuckDB connection
con = dd.connect(':memory:')
```

This command creates an in-memory database, meaning all operations are performed in the memory and won't persist after the session ends.

Alternatively, you can create a **persistent** DuckDB database by specifying a file path:

```python
# Create a persistent DuckDB database
con = dd.connect('my_database.db')
```

This stores the database in the file `my_database.db` in the current working directory, on your disk, making it persistent between sessions.

### Basic Usage

Once installed, you can start using DuckDB to run SQL queries directly within your Python environment. Here's a simple example:

```python
import duckdb as dd

# Running a basic SQL query
result = dd.sql("SELECT 'DuckDB_is_cool' AS answer").fetchall()
print( type(result) )		# <class 'list'>	# List of Tuples
print(result)
```

![1727571427796](image/007_DuckDB_in_Python/1727571427796.png)

```python
import duckdb as dd

# Running a basic SQL query
relation = dd.sql("SELECT 'DuckDB_is_cool' AS answer")
print( type(relation) )		# <class 'duckdb.duckdb.DuckDBPyRelation'>	# This class represents a symbolic representation of SQL queries, known as a "relation".
print(relation)
```

![1727571481479](image/007_DuckDB_in_Python/1727571481479.png)


## Running SQL Queries & Data Ingestion

DuckDB supports standard SQL syntax, so you can run any SQL query with ease. Let's start by creating a on file DataBase and looking at it.

```python
import duckdb as dd

# Create / connect to database
con = dd.connect('my_database.db')
con.sql('SHOW ALL TABLES)
```

![1727581657005](image/007_DuckDB_in_Python/1727581657005.png)

### Let's start by creating a table and inserting some data, manually.

#### Example 1: Creating a Table and Inserting Data Manually

```python
import duckdb as dd

# Create / connect to database
con = dd.connect('my_database.db')

# Create a table
con.execute('''
CREATE TABLE countries (
    country VARCHAR,
    code VARCHAR,
    region VARCHAR,
    sub_region VARCHAR,
    intermediate_region VARCHAR
);
''')

# Insert data in table
con.execute('''
INSERT INTO countries VALUES
('Australia', 'AUS', 'Oceania', 'Australia and New Zealand', ''),
('India', 'IND', 'Asia', 'Southern Asia', '');
''')

```

```python
# Result of show tables after creating a table
con.sql('SHOW ALL TABLES')
```

![1727580105451](image/007_DuckDB_in_Python/1727580105451.png)

#### Example 2: Creating a Table and Inserting Data Manually

```python
# Create second table
con.execute('''
CREATE TABLE employees (
    id INTEGER,
    name VARCHAR,
    age INTEGER,
    salary DOUBLE
);
''')

# Insert some data in second table
con.execute('''
INSERT INTO employees VALUES
(1, 'Person 1', 30, 70000),
(2, 'Person 2', 25, 55000),
(3, 'Person 3', 35, 80000);
''')
```

```python
# Result of show tables after creating a table
con.sql('SHOW ALL TABLES')
```

![1727580311145](image/007_DuckDB_in_Python/1727580311145.png)

### Data Ingestion directly from files

DuckDB can ingest data from various formats, including CSV, Parquet, and JSON files. You can read these files into DuckDB relations (tables) and query them directly:

```python
# Reading a CSV file
relation = dd.read_csv("countries.csv")

# Querying the relation
result = dd.sql("SELECT * FROM relation").fetchall()
for row in result[:2]:
    print(row)
```

![1727581011224](image/007_DuckDB_in_Python/1727581011224.png)

### Working with DataFrames

DuckDB seamlessly integrates with popular data analysis libraries like Pandas, Polars, and PyArrow. This allows you to query DataFrames directly:

```python
import pandas as pd
import duckdb

# Creating a Pandas DataFrame
pandas_df = pd.DataFrame({"a": [1, 2, 3]})

# Querying the DataFrame using DuckDB
result = duckdb.sql("SELECT * FROM pandas_df").fetchall()
print(result)
```

### Advanced Querying and Data Manipulation

DuckDB supports advanced SQL features, including window functions, CTEs (Common Table Expressions), and complex joins. Here's an example of using a CTE:

```python
query = """
WITH cte AS (
    SELECT a, b, a + b AS sum_ab
    FROM my_table
)
SELECT *
FROM cte
WHERE sum_ab > 10
"""

result = duckdb.sql(query).fetchall()
print(result)
```

### Performance Optimization

DuckDB is optimized for performance, especially for analytical queries. It uses vectorized execution and columnar storage to speed up query processing. Additionally, DuckDB can operate directly on compressed data formats like Parquet, reducing the need for data decompression.

### Integration with Jupyter Notebooks

DuckDB can be used directly within Jupyter Notebooks, making it a great tool for interactive data analysis. You can use the `jupysql` package to simplify SQL query development in Jupyter:

```python
import duckdb
import pandas as pd
%load_ext sql

# Connecting to DuckDB
conn = duckdb.connect()
%sql conn --alias duckdb

# Running a SQL query
%sql SELECT * FROM my_table
```

### Conclusion

DuckDB is a versatile and powerful tool for data analysis in Python. Its ease of use, performance optimizations, and seamless integration with popular data analysis libraries make it an excellent choice for data scientists and analysts. Whether you're working with small datasets or large analytical workloads, DuckDB provides the tools you need to perform efficient and effective data analysis.

---

I hope this article helps you get started with DuckDB in Python! If you have any specific questions or need further details, feel free to ask.

Source: Conversation with Copilot, 29/09/2024
(1) Python API – DuckDB. https://duckdb.org/docs/api/python/overview.html.
(2) Jupyter Notebooks - DuckDB. https://duckdb.org/docs/guides/python/jupyter.html.
(3) Using DuckDB for fast data analysis in Python in 2023: A tutorial and .... https://www.tensorscience.com/posts/introduction-to-duckdb-python-tutorial.html.

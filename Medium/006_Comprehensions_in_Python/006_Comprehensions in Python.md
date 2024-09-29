### Comprehensions in Python

In Python, comprehension is a concise and expressive way to create data structures like lists, dictionaries, and sets by specifying the elements and conditions in a compact syntax, usually using a single line of code rather than using traditional loops and append operations. This makes your code shorter and often more readable, and is referred to as a more ‘ ***Pythonic*** ’ way of writing code.

Python places a strong emphasis on readability and simplicity, and building lists, dictionaries, and sets with comprehensions is regarded as a ‘ ***Pythonic*** ’ approach. They are idiomatic to the language and widely used in Python codebases. Comprehensions align with the guidelines outlined in ‘ ***PEP 20*** ’, also known as the Zen of Python. ‘ ***PEP 20*** ’ provides a set of guiding principles for writing Python code. Specifically, comprehensions adhere to several principles from the Zen of Python:

1. **Readability counts:** Comprehensions offer a more concise and readable way to create data structures compared to traditional loops. They allow you to express the construction of lists, dictionaries, and sets in a single line of code, enhancing readability and making the intention of the code clearer.
2. **Simple is better than complex:** Comprehensions provide a simple and expressive way to create data structures, promoting clarity and simplicity in code.
3. **Sparse is better than dense:** Comprehensions allow for the creation of data structures with minimal syntactic overhead, leading to more readable and less dense code.

While ‘ ***PEP 20*** ’ does not explicitly mention comprehensions, their alignment with these principles demonstrates their compatibility with the broader Python philosophy of simplicity, readability, and elegance. However, with ‘ ***Python 3.12*** ’, more changes are being introduced, which will make the use of ‘Comprehensions’ up to 2x more efficient, as per the ‘[***PEP 709***](https://peps.python.org/pep-0709/)’, documentation. Apart from the above reasons, which make use of comprehensions more ‘ ***Pythonic*** ’, comprehensions are also generally preferred in Python for the following reasons:

1. **Efficiency:** Comprehensions are often more efficient than equivalent loop-based approaches. They are optimized internally by the Python interpreter and are generally faster in execution.
2. **Expressiveness:** Comprehensions allow you to express complex operations in a compact and expressive manner. This can lead to more elegant and maintainable code.

---

#### In Python, there are mainly three types of comprehensions:

* **List Comprehensions:** These are used to create lists. List comprehensions provide a concise way to create lists by iterating over an ‘ *iterable* ’ object and applying an expression to each element. The basic syntax is as below:

```
[item for item in iterable]
```

![](https://cdn-images-1.medium.com/max/800/1*YTE4oYhwFN3adC1st9ZRTA.png)
List Comprehension

* **Dictionary Comprehensions:** Similar to list comprehensions, dictionary comprehensions allow you to create dictionaries. They use a similar syntax but produce dictionaries instead of lists. The basic syntax is:

```
{key_expression: value_expression for item in iterable}
```

![](https://cdn-images-1.medium.com/max/800/1*8WqLjBbhVBgE3YNGf93N3Q.png)


Dictionary Comprehension

* **Set Comprehensions:** Set comprehensions are used to create sets. They follow a similar syntax to list comprehensions, but instead of square brackets, they use curly braces. Set comprehensions automatically remove duplicate elements from the resulting set. The basic syntax is:

```
{expression for item in iterable}
```

![](https://cdn-images-1.medium.com/max/800/1*zfRI4HFFGbFnS5AudpPJBg.png)


Set Comprehension

Each of these comprehensions generates a different type of collection (list, dictionary, or set) based on the specified expression and conditions. Let’s look at these in detail.

List Comprehensions

**The basic syntax of list comprehension is:**
 **[** expression ***for* **item ***in* **iterable**]**

Where:

* **expression:** is the operation or value to be computed for each element.
* **item:** is the variable representing each element in the iterable.
* **iterable:** is any Python iterable object like a list, tuple, string, etc.

```python
# Code using loop to create a list of first 10 even numbers
even_nums = []
for x in range(2, 21, 2):
  even_nums.append(x)
print(even_nums)

# List comprehension equivalent for creating a list of first 10 even numbers
even_nums = [x for x in range(2, 21, 2)]
print(even_nums)
```

![](https://cdn-images-1.medium.com/max/800/1*kVcP_l23DU7GYBpYnEaclg.png)
Creates a list of Even numbers between 2 and 20

```python
# Code using loop to create squares of a list of numbers (Using even_nums list)
squares = []
for x in even_nums:
  squares.append(x**2)
print(squares)

# List Comprehension equivalent for calculating squares
squares = [x**2 for x in even_nums]
print(squares)
```

![](https://cdn-images-1.medium.com/max/800/1*e1_Wlgexfiwgr4oEDLSrwg.png)
Creates a list of squares of first 10 even numbers

**The syntax of list comprehension with an if condition:**
 **[** expression ***for* **item ***in* **iterable ***if*** condition**]**

Where:

* **expression:** is the operation or value to be computed for each element.
* **item:** is the variable representing each element in the iterable.
* **iterable:** is any Python iterable object like a list, tuple, string, etc.
* **condition:** This is an optional expression that can be used to filter items.

```python
# Code using loop to generate list of numbers divisible by 3
num_lst = list(range(1, 31))
div_by_3 = []
for x in num_lst:
  if x%3 == 0:
    div_by_3.append(x)
print(div_by_3)

# List Comprehension equivalent to generating list of numbers divisible by 3
div_by_3 = [x for x in num_lst if x%3==0]
print(div_by_3)
```

![](https://cdn-images-1.medium.com/max/800/1*2dkh90NV9HFgFGyqjzmlvw.png)
List of numbers between 1 and 30, divisible by 3

**The syntax of list comprehension with an if else condition:**
 **[** expression ***if*** condition ***else*** alt_value ***for* **item ***in* **iterable**]**

Where:

* **expression:** is the operation or value to be computed for each element.
* **item:** is the variable representing each element in the iterable.
* **iterable:** any Python iterable object like a list, tuple, string, etc.
* **condition:** This is an optional expression that can be used to provide a value when the condition is satisfied.
* **else:** This is an optional expression that can be used to provide a value when the condition is not satisfied.

```python
# Code using loop to generate list of dictionaries odd & even numbers
num_lst = list(range(1, 14))
odd_even = []
for x in num_lst:
  if x%2 == 0:
    odd_even.append({x:'even'})
  else:
    odd_even.append({x:'odd'})
print(odd_even)

# Comprehension equivalent to generating list of dictionaries of odd & even numbers
odd_even = [{x:'even'} if x%2==0 else {x:'odd'} for x in num_lst]
print(odd_even)
```

![](https://cdn-images-1.medium.com/max/800/1*yIS5JsxFS7Dq_q7YlNTFCg.png)
List of Dictionaries with number and its classification as Odd or Even

Bonus code to generate [Fizz Buzz](https://en.wikipedia.org/wiki/Fizz_buzz) which is “a very simple programming task often used in software developer job interviews.” The code in the comprehension equivalent is so much more readable, which is enhanced even further by breaking the code into multiple lines.

```python
# Code using loop to generate list for Fizz Buzz Challenge
num_lst = range(1, 16)
fizz_buzz = []
for x in num_lst:
  if x%3 == 0 and x%5 == 0:
    fizz_buzz.append('Fizz-Buzz')
  elif x%3 == 0:
    fizz_buzz.append('Fizz')
  elif x%5 == 0:
    fizz_buzz.append('Buzz')
  else:
    fizz_buzz.append(x)
print(fizz_buzz)

# List Comprehension equivalent to generate list for Fizz Buzz Challenge
fizz_buzz = ['Fizz-Buzz' if (x%3==0 and x%5==0)
              else 'Fizz' if x%3==0
              else 'Buzz' if x%5==0
              else x
              for x in num_lst
            ]
print(fizz_buzz)
```

![](https://cdn-images-1.medium.com/max/800/1*ZWeciy9yJ4FvZ-W4_OMu4g.png)
Output of Fizz Buzz Code

Comprehensions are useful for transforming data, filtering data, or creating combinations of data in a concise and readable way. They can also improve the performance of your code compared to using loops. While they can make code more concise, overly complex comprehensions can sometimes reduce readability and should not be overused or nested too deeply, as it’s essential to balance the use of comprehensions with readability. It’s important to strike a balance between readability and conciseness when using comprehensions in Python code.

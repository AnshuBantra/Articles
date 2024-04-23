# A Detailed Guide to Python Formatted Strings Literals (f-strings)


Python is known for its simplicity and readability of code. Formatted Strings Literals (f-strings) were introduced in Python 3.6., to provide an elegant and efficient way to format strings by embedding expressions and variables directly into the string literals. In this article, we explore f-strings in depth, demonstrating their usage and explaining their advanced features.

# What Are f-strings?

Formatted String Literals, often referred to as f-strings, are string literals prefixed with the letter ‘f’ or ‘F’. This prefix allows you to embed expressions and variables inside the string using curly braces ‘{}’. The part / expression inside the curly braces is evaluated at runtime and is replaced with their corresponding value.

Here’s a simple example:

```
name = "Somename"
age = 45
greeting = f"Hello, my name is {name} and I am {age} years old."
print(greeting)
```

In this example, the variables ‘name’ and ‘age’ are embedded in the string using, curly braces ‘{}’. Expressions within ‘{}’ will be evaluated and substituted into the string. The output of the code will be:

![](https://miro.medium.com/v2/resize:fit:570/1*F5pEmQ5jemqxRt7jp_5GgA.png)

# Benefits of Formatted String Literals (f-strings)

F-strings offer several advantages over other string formatting methods in Python:

1. **Readability:** F-strings make your code more readable by directly embedding expressions and variables into the string, which clearly shows how the final string is constructed.
2. **Performance:** F-strings are faster than older string formatting methods such as ‘%’ formatting and ‘str.format()’.
3. **Expression Evaluation:** You can use any valid Python expression inside the curly braces of an f-string, including arithmetic operations, function calls, and string methods.
4. **Flexibility:** F-strings allow for advanced formatting options such as controlling precision, alignment, padding, and other string formatting features.

# Advanced Usage of f-strings

Let’s explore some advanced usage scenarios of f-strings:

## 1. Arithmetic Operations and Functions

You can perform arithmetic operations and call functions directly in an f-string:

```
length = 5
width = 3
area = f"The area of the rectangle is {length * width} square units."
print(area)
```

This code calculates the area of a rectangle and embeds the result in the f-string. The output will be:

![](https://miro.medium.com/v2/resize:fit:516/1*AKSE87A1oZfNpiZzkqWUSg.png)

## 2. Formatting Options

F-strings provide a range of formatting options similar to those available with the ‘str.format()’ method. You can control precision, padding, alignment, and more:

a. **Precision:** Control the number of decimal places in a floating-point number using ‘.xf’, where ‘x’ is the desired number of decimal places and ‘f’ indicates float formatting:

```
val = 123456789.45678
print(f"Rounded to 2 decimal places: {val:.2f}")
```

Which would result in a formatted number with precision of 2 decimal places.

![](https://miro.medium.com/v2/resize:fit:483/1*YeexdZIldkiq70vd3qL8tw.png)

We can further control the formatting by introducing placeholder symbols ‘,’ or ‘_’ for 1000’s separator. In the example below, we use the f-string to format two different numbers.

```
val1 = 123456789.45678
val2 = 123.456

print("Values rounded to 2 decimal places with ',' as 1000's separator")
print(f"Val1 :{val1:,.2f}")
print(f"Val2 :{val2:,.2f}")
```

Output:

![](https://miro.medium.com/v2/resize:fit:700/1*0c-_k7jFCz_DC6-xTVraIQ.png)

b. **Padding and Alignment: **Specify the total width of the formatted output and align the text. You would notice further use of ‘{}’ inside one set of curly brackets to introduce variables to control width and precision. This defaults to Left Padding

```
val1 = 123456789.45678
val2 = 123.456

width = 15
precision = 2
print("Values rounded to 2 decimal places with ',' as 1000's separator and total width of 15")
print(f"Val1 :{val1:{width},.{precision}f}")
print(f"Val2 :{val2:{width},.{precision}f}")
```

Output of the above code snippet will look as below:

![](https://miro.medium.com/v2/resize:fit:700/1*My-yOH31qAcMFTwVINWq4A.png)

To control what style of padding is applied, we can use symbols i.e. left (‘<’), right (‘>’), or center (‘^’) :

```
val1 = 123456789.45678
val2 = 123.456
width = 15
precision = 2

print(f"Padded to 20 characters (Defaults to Left Padding): {val1:{width},.{precision}f}")
print(f"Left-aligned: {val1:<{width},.{precision}f}")
print(f"Left-aligned: {val2:<{width},.{precision}f}")
print(f"Right-aligned: {val1:>{width},.{precision}f}")
print(f"Right-aligned: {val2:>{width},.{precision}f}")
print(f"Center-aligned: {val1:^{width},.{precision}f}")
print(f"Center-aligned: {val2:^{width},.{precision}f}")
```

These measures allows us to align out output precisely, like this:

![](https://miro.medium.com/v2/resize:fit:700/1*7nRrdIpVc_pi9_-RzY5dBQ.png)

If there is a need to highlight / show the padding, it can be achieved by specifying a placeholder (in this case ‘.’), to fill up the padded space.

```
val1 = 123456789.45678
val2 = 123.456
width = 15
precision = 2

print(f"Padded to 20 characters (Defaults to Left Padding): {val1:{width},.{precision}f}")
print(f"Left-aligned: {val1:.<{width},.{precision}f}")
print(f"Left-aligned: {val2:.<{width},.{precision}f}")
print(f"Right-aligned: {val1:.>{width},.{precision}f}")
print(f"Right-aligned: {val2:.>{width},.{precision}f}")
print(f"Center-aligned: {val1:.^{width},.{precision}f}")
print(f"Center-aligned: {val2:.^{width},.{precision}f}")
```

Output:

![](https://miro.medium.com/v2/resize:fit:700/1*TpMJsH3JRwXmS50NRnxUoQ.png)

c. **Formatting Types:** f-strings also give us the possibility to specify the type of formatting inside the curly braces. For example, you can use ‘d’ for integers, ‘f’ for floating-point numbers, ‘b’ for binary and ‘%’ for percentage:

```
number = 42
print(f"As a decimal: {number:d}")
print(f"As a float: {number:f}")
print(f"As a binary: {number:b}")
print(f"As a hexadecimal: {number:x}")

number = 0.235
print(f"As a percentage: {number:.2%}")
```

Output:

![](https://miro.medium.com/v2/resize:fit:315/1*06How_9oTWC520fbEz_pAA.png)

## 3. Using String Methods

String methods can be used directly within the curly braces of an f-string. This is useful for manipulating string data as you format it:

```
text = "python"
print(f"Capitalized string: {text.capitalize()}")
```

In this example, the ‘capitalize()’ method is called directly inside the curly braces, capitalizing the first letter.

![](https://miro.medium.com/v2/resize:fit:369/1*k-T2qdN5gav9gTMIsZ_zPg.png)

## 4. Using Complex Expressions

F-strings can handle more complex expressions as well, such as list comprehensions, lambda functions, and conditional statements:

```
numbers = [1, 2, 3, 4, 5]
sum_numbers = sum(numbers)
print(f"The sum of {numbers} is {sum_numbers}")

# Using a conditional expression
number = 3
msg = f"The number {number} is {'even' if number % 2 == 0 else 'odd'}."
print(msg)

# Using a list comprehension
msg = f'List of {list(numbers)} becomes {[num**2 for num in numbers]} after squaring each number'
print(msg)
```

Output:

![](https://miro.medium.com/v2/resize:fit:700/1*xwRFReQ98piHc6BsnQYdAA.png)

# Best Practices

With great power comes great responsibility. When working with f-strings, keep the following best practices in mind:

* **Keep expressions concise:** While f-strings support complex expressions, keep them simple for better readability.
* **Be careful with side effects:** If an expression inside an f-string has side effects (e.g., modifying a global variable), consider separating it from the f-string.
* **Be consistent with formatting:** When formatting expressions, use consistent formatting rules to maintain readability and make the code easier to understand.
* **Use comments:** If the f-string contains complex expressions, consider adding comments to explain what the expression is doing.

# Conclusion

Formatted String Literals (f-strings), are a powerful and flexible way to work with strings in Python. They simplify the process of string formatting and allow you to embed variables and expressions directly into your strings, making your code more readable and efficient. Whether you’re new to Python or an experienced developer, using f-strings can help you write cleaner, more concise code.

Experiment with f-strings in your Python projects to see how they can enhance your code. Happy coding!

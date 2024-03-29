# SEND + MORE = MONEY

2022 Erwin Lau

SEND+MORE=MONEY in Stanza

Wiki or Google "send more money math problem" you will find a bunch of results
  

# Usage

Execute sendmoremoney with 3 more arguments. For example...

./sendmoremoney send more money

OR

./sendmoremoney.exe crack hack error

in Windows
  

# Background

"Send More Money" is a Math problem. It can be depicted like this...


| |S|E|N|D| 
|-|-|-|-|-|
|+|M|O|R|E|
|-|-|-|-|-|
|M|O|N|E|Y|

# How to solve this type of problem

First, we try to write down the mathematical formula

For ones digit
```
D + E = Y --- (1)
```
But there is also an alternative if D + E is greater than 9. In this case, an overthrow is generated.
```
D + E = 10 + Y ---(2)
```
For the tens digit, there are 4 possible situations:

If there is carry from the previous digit addition, we will have
```
N + R + 1 = E -------- (3)
N + R + 1 = 10 + E --- (4)
```
Also, note that (2) and (3) are related. They always go together because carry must be generated from previous digit calculation in order to generate that '+ 1' on the left-hand side of (3) and (4).
Therefore, we have...
```
[((2) and (3)) or (not(2) and not(3))] --- (7)
[((2) and (4)) or (not(2) and not(4))] --- (8)
```
On the other hand, if no carry from previous digit
```
N + R = E ------------ (5)
N + R = 10 + E --------(6)
```
Again,
```
[((1) and (5)) or (not(1) and not(5))] --- (9)
[((1) and (6)) or (not(1) and not(6))] --- (10)
```
Now we write everything again starting from (3)
```
N + R + 1 = E -------- (3)
N + R + 1 = 10 + E --- (4)
N + R = E ------------ (5)
N + R = 10 + E --------(6)
(2) xnor (3) --------(7)
(2) xnor (4) --------(8)
(1) xnor (5) --------(9)
(1) xnor (6) --------(10)
```
From (3) to (6), We only need to satisfy either one of them.

Therefore, we will have
```
(3) or (4) or (5) or (6) --- (11)
```
For ones digit, note that (3) and (4) are not possible since there is no previous digit addition to give it a carry.
Thus, only (5) and (6) could be true.


For the Most Significant Digit (MSD), there is one more rule
```
S != 0 ---- (12)
M != 0 -----(13)
```
And for the fifth digit. MSD of the answer, we can use the above (3) ~ (11) rules and observe that...
```
0 + 0 = M
0 + 0 = 10 + M
0 + 0 + 1 = M
0 + 0 + 1 = 10 + M
```
Here we iterate M = 0 through 9.

When M = 0, conflict to (13), so M cannot be 0

when M = 1, we can try other, pick S = 0 (conflict with (12)), then S = 1, no conflict, try O = 0, and so on...

Now, when we say, try M = ?, we are assigning an integer to a variable, S or M or E.

We can make a structure like this:
```
defstruct sample
   s : Int|False
   e : Int|False
   n : Int|False
   d : Int|False
   m : Int|False
   o : Int|False
   r : Int|False
   y : Int|False
```

We need to also map these variables to the X and Y inputs and Z output, like...
```
x = [s e n d]
y = [m o r e]
z = [m o n e y]
```
then (1) ~ (2) becomes

```
x[3] + y[3] = z[3] -------- (1)
x[3] + y[3] = z[3] + 10 --- (2)
```

(3) ~ (11) becomes

```
x[2] + y[2] + 1 = z[2] -------- (3)
x[2] + y[2] + 1 = 10 + z[2] --- (4)
x[2] + y[2] = z[2] ------------ (5)
x[2] + y[2] = 10 + z[2] --------(6)
(2) xnor (3) --------(7)
(2) xnor (4) --------(8)
(1) xnor (5) --------(9)
(1) xnor (6) --------(10)
(3) or (4) or (5) or (6) ---- (11)
```

and only (7) ~ (11) needs to be satisfied


This is only an overall description of the problem.

There are quite a few subtleties buried inside the code.
 

# Coding

Now that we know the math aspect, we can write some code to find the solution.

First, we will try a brute-force tree traversal method.
  

The algorithm is like:

Let's say we have a sample X with [S E N D M O R Y] 8 variables. Initialize them to false

Evaluate the sample one time, if there is no conflict (evaluated True), see if there is any unassigned variable; if so, recursively assign variables.

If there is conflict (evaluated False), get the current working variable and assign the next higher value. If no higher value to assign, backtrack to the previous variable (pop from recursive call).

Do this repeatedly until a solution is found or the whole tree is traversed.

# Finer Points in the code

1. function as variables.

In the later incarnations, defstruct Sample is changed to accommodate all 26 letters. There are i0, i1 and o0 Tuples to carry the functions like [s e n d].
Note that s is a getter function. s(Sample) is the variable. These functions can be passed around and act like variable until it is called with (sample).

2. Recursive Crawl.

Like every tree crawling algorithms, the function `traverse` uses recursive function and determines the returns to decide the next action. Besides the Tuple and the current location variables, `done : True|False` is also returned to provide a quick graceful rollup nomatter the operation is successful or not. 

3. Tuple<Int|False|True>

To generalize all 26 letters, `True` is added to signify a particular letter is not used in the current problem. `False` means that letter is used but not yet assigned to an `Int`

4. Priority Table

In the first incarnation, variables are guessed/visited in alphabetical order. The result is that there are 6339 evaluations needed to reach a solution for SEND+MORE=MONEY case.
It is observed that M should be guessed first because it is easy to fix. Then the other MSD (S in `send`), then the ones digits (D, E and Y), then tens digit and so on.
Thus the priority table is set up with MSDs first and output before inputs. Then go from ones digits to tens digits and so on. 
Using Priority Table, 5778 evaluations to reach a solution is achieved.

5. More Contraints Refinements

* Ones digit cannot have carry? from previous digit. Set the rules so that `add-func` must have `false` in the `carry?`.
* Overall MSD cannot have overthrow. Set the rules so that `add-func` must have `false` in `overthrow?`

# Todo

* Speed Optimization (DPLL?). Need a one-clause solver. Assign value calculated from the one-clause solver instead of using `get-next`. Mark the recursive level and location for quick rewind.

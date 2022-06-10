2022 Erwin Lau
SEND+MORE=MONEY in Stanza

This is an attempt to try to solve this problem

# Usage
./sendmoremoney send more money
OR
./sendmoremoney.exe crack hack error
in Windows
There must be 3 arguments

# Background
"Send More Money" is a Math problem. It can be depicted like this...
    S E N D
+   M O R E
-----------
  M O N E Y

Just wiki "send more money math problem" you will find a bunch of results

# How to solve this type of problem
First, we try to write down the mathemathical formula about this problem
Note that 
D + E = Y --- (1)
But there is also an alternative if D + E is greater than 9 and created an overthrow.
D + E = 10 + Y ---(2)

For the tens digit, there are 4 possible formula:
If there is carry from the previous digit addition, we will have
N + R + 1 = E -------- (3)
N + R + 1 = 10 + E --- (4)
Also (2) -> (3) and (2) -> (4) because carry must be generated from previous digit
Therefore, if (3) or (4) are true, (2) must be true. We say (3) implies (2). Logically, it can be rewritten as 'not (3) or (2)' or '(2) or not (3) and (2) or not (4)'
On the other hand, if no carry from previous digit
N + R = E ------------ (5)
N + R = 10 + E --------(6)
(5) -> (1) and (6) -> (1)
Now we write again starting from (3)
N + R + 1 = E -------- (3)
N + R + 1 = 10 + E --- (4)
N + R = E ------------ (5)
N + R = 10 + E --------(6)
(2) or not (3) --------(7)
(2) or not (4) --------(8) 
(1) or not (5) --------(9)
(1) or not (6) --------(10)
From (3) to (6), We only need to satisfy either one of them. 
Therefore, we will have (3) or (4) or (5) or (6) --- (11)

This is the only rule we need to satisfy for one digit
All other digits follow the same (3)~(11) rules
For the Most Significant Digit (MSD), there is one more rule 
S != 0 ---- (12)
M != 0 -----(13)
And for the fifth digit. MSD of the answer, we can use the above (3) ~ (11) rules to observe...
0 + 0 = M
0 + 0 = 10 + M
0 + 0 + 1 = M
0 + 0 + 1 = 10 + M
Here we iterate M = 0 through 9. 
When M = 0, conflict to (13), so M cannot be 0
when M = 1, we can try other, pick S = 0 (conflict with (12)), then S = 1, no conflict, try O = 0, and so on...

Now, when we say, try M = ?, we are assigning an integer to a variable, S or M or E.
We can make a structure like this:
defstruct sample
   s : Int|False
   e : Int|False
   n : Int|False
   d : Int|False
   m : Int|False
   o : Int|False
   r : Int|False
   y : Int|False

We need to also map these variables to the X and Y inputs and Z output, like...
 x = [s e n d]
 y = [m o r e]
 z = [m o n e y]

then (1) ~ (2) becomes
 x[3] + y[3] = z[3] -------- (1)
 x[3] + y[3] = z[3] + 10 --- (2)
 (3) ~ (11) becomes
 x[2] + y[2] + 1 = z[2] -------- (3)
 x[2] + y[2] + 1 = 10 + z[2] --- (4)
 x[2] + y[2] = z[2] ------------ (5)
 x[2] + y[2] = 10 + z[2] --------(6)
 (2) or not (3) --------(7)
 (2) or not (4) --------(8) 
 (1) or not (5) --------(9)
 (1) or not (6) --------(10)
 (3) or (4) or (5) or (6) ---- (11)
 and only (7) ~ (11) needs to be satisifed

This is only an overall desription of the problem.
There are quite a few subtleties buried inside the code.

# Coding

Now that we know the math aspect, we can write some code to find the solution.
First, we will try a brute-force tree traversal method.

The algorithm is like:
let's say we have a sample X with [S E N D M O R Y] 8 variables. Initialize them to false 
Evaluate the sample, if there is no conflict (or contradict),
see if there is any un-assigned variable, if so, recusively assign variables.
If there is conflict, get the current working variable and assign the next higher value.
If no higher value to assign, backtrack to the previous variable (pop from recursive call).
Do this repeatedly until the whole tree is traversed.

# Todo

Generalize to all such problem. Allow all possible 26 letters
Speed Optimization

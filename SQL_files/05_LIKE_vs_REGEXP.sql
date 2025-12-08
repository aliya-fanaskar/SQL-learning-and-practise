/*
---------------------------------------------------------------------------------------------------------------------------
Filename         : 05_LIKE_vs_REGEXP.sql
Level            : Intermediate
Concepts covered :
  1. Wildcards with LIKE operator
  2. REGEXP operator
---------------------------------------------------------------------------------------------------------------------------
*/

-- ------------------------------------------------------------------------------------------------------------------
--  String Pattern Matching
-- -------------------------
/* 
MySQL offers two primary methods for pattern matching in string comparisons:
→ Wildcards used with LIKE operators
→ REGEXP (or RLIKE) operator

WHile both enable pattern-based searches, they differ significantly in their capabilities and complexity.
*/

USE company;


-- ------------------------------------------------------------------------------------------------------------------
-- Wildcards (with LIKE)
-- -----------------------
/* LIKE operator uses simple wildcard characters. 
By default, LIKE performs matching against the entire string
SQL wildcards are special characters used with the LIKE operator in the WHERE clause to search for 
specific patterns within string data in a database. They primarily use two special characters:
→ %  : Matches any sequence with zero or more characters.
→ _  : Matches any single character.

They provide a straightforward and intuitive way to perform basic pattern matching with simple searches
like "starts with", "ends with", or "contains" a specific substring
*/
SELECT * FROM employee WHERE first_name LIKE 'Kunal';   -- Basic use of LIKE operator to get record(s) with employee name 'Kunal'

-- using Wildcards
SELECT * FROM employee WHERE last_name LIKE 'S%';        -- employees whose last name starts with 'S' 

SELECT * FROM employee WHERE first_name LIKE '%a';       -- whose first name ends with 'a' 

SELECT * FROM employee WHERE first_name LIKE '%e%';      -- whose first name contains 'e' 

SELECT * FROM employee WHERE first_name LIKE 'V%n';      -- whose first name starts with 'V' and ends with 'n' 

SELECT * FROM employee WHERE first_name LIKE '_a%';      -- whose first name's second letter is 'a' 

SELECT * FROM employee WHERE first_name LIKE '_e%a';     -- whose first name's second letter is 'e' and ends with 'a'

SELECT * FROM employee WHERE first_name LIKE '____l';   -- whose first name have 5 letters and ends with 'l' (4 underscores)

SELECT * FROM employee WHERE first_name LIKE '____';     -- whose first name contains 4 characers (4 underscores) 

SELECT * FROM employee WHERE last_name LIKE '_____';     -- whose last name contains 5 characers (5 underscores) 

SELECT * FROM employee WHERE first_name LIKE 'A%' AND last_name LIKE 'S%';  -- f_name starts with 'A' and l_name starts with 'S'


-- ------------------------------------------------------------------------------------------------------------------
-- REGEXP (Regular Expressions)
-- -----------------------------
/* `REGEXP` (or `RLIKE` operator) is used in MySQL to match text patterns using `regular expressions`
which are more powerful and flexible than `LIKE`.
If the pattern matches any part of the column's value, the row is returned.

Syntax: SELECT col_name FROM table_name WHERE col_name REGEXP 'pattern';

Anchors ----------------------------------------------------------------------------------------------
→ ^  : Starting with
→ $  : Ending with
→ .  : single charater
→ |  : OR operator */

SELECT * FROM employee WHERE first_name REGEXP '^R';    -- starts with 'R'

SELECT * FROM employee WHERE first_name REGEXP 'a$';    -- ends with 'a'

SELECT * FROM employee WHERE first_name REGEXP 'V...l';    -- contains a pattern sequence of 'V' and 'l' with 3 chars in between

SELECT * FROM employee WHERE first_name REGEXP 'a.a';    -- contains a pattern of two 'a's with one char in between

SELECT * FROM employee WHERE first_name REGEXP 'roh|man';    -- containing pattern 'raj' or 'mon'

SELECT * FROM employee_info WHERE city REGEXP 'Mum|Pun';    -- containing pattern 'mum' or 'pun'

/* 
Character Classes ------------------------------------------------------------------------------------
→ '[abc]'  : Matches a, b or c
→ '[^abc]' : Matches any character except a, b or c    ------- doubt...
→ '[A-Z]'  : Matches any uppercase letter
→ '[a-z]'  : Matches any lowercase letter
→ '[0-9]'  : Matches any digit */

SELECT * FROM employee WHERE first_name REGEXP '[mrs]';    -- contains at least one character that is 'm', 'r' or 's'

SELECT * FROM employee WHERE first_name REGEXP '[^mrs]';   -- contains at least one character that is NOT 'm', 'r' or 's' (basically everything)

SELECT * FROM employee_info WHERE city REGEXP '[^Pune]';   
-- contains at least one character that is NOT 'P', 'u', 'n' or 'e'
-- this means that if all these chars are present, then it will be excluded

/*
Basic Pattern Matching Examples ----------------------------------------------------------------------
→ 'abc'    : Matches if "abc" appears anywhere
→ '^abc'   : Matches strings starting with "abc"
→ 'abc$'   : Matches strings ending with "abc"
→ '^abc$'  : Matches exactly "abc"
→ 'a.b'    : Matches "b" + any character + "b"
→ 'ab|cd'  : Matches strings that contain "ab" or "cd" */

SELECT * FROM employee WHERE first_name REGEXP 'an';  -- contains 'an' anywhwre

SELECT * FROM employee WHERE first_name REGEXP '^Vi';  -- names beginning with 'Vi'

SELECT * FROM employee WHERE first_name REGEXP '^.i';  -- second character 'i'

SELECT * FROM employee WHERE first_name REGEXP 'an$';  -- name ending with 'an'

SELECT * FROM employee WHERE first_name REGEXP '^aditi$';  -- exact match

SELECT * FROM employee WHERE first_name REGEXP 'i.a';  -- contains 'i' + any char + 'a' anywhere 

SELECT * FROM employee WHERE first_name REGEXP 'an|ha';  -- contains 'an' or 'ha' anywhwre

/*
Repetition Quantifiers -------------------------------------------------------------------------------
→ 'a+'       : One or more a's
→ 'a*'       : Zero or more a's
→ 'a?'       : Zero or one a's
→ 'a{3}'     : Exactly 3 a's
→ 'a{2, 4}'  : Between 2 and 4 a's  */

SELECT * FROM employee WHERE first_name REGEXP 'n+';  -- contains one or more 'n'

SELECT * FROM employee WHERE first_name NOT REGEXP 'n+';  -- doesn't contain 'n'

SELECT * FROM employee WHERE first_name REGEXP 'n?';
-- contains zero or one 'n' (will basically fetch all rows. why?
/*
'n?' is useful only inside larger patterns, not by itself.
On its own, it matches “n” or “nothing,” which means it matches everything.
But inside real patterns, it lets you mark a part as optional. For example:
- colou?r  → matches “color” and “colour”
- https?   → matches “http” and “https”
- a?b      → matches “b” and “ab”
- Mr?s?    → matches “Mr”, “Mrs”, “Ms”
So the point of 'n?' is: to make a character optional inside a bigger regex pattern. */

/*
- Escaping Special Characters --------------------------------------------------------------------------
Some characters ike ., ?, *, +, | have special meanings in regex. If you want to match them literally, you need to escape them with two backslashes '\\'
For eg:
→ 'C\\+\\+' matches 'C++'
→ '\\.com$' matches strings ending with '.com'

- Case Sensitivity -------------------------------------------------------------------------------------
By default, MySQL's REGEXP is case-insensitive for non-binary strings. To make is case-sensitive, use the BINARY keyword:
Syntax: SELECT * FROM table_name WHERE BINARY col_name REGEXP 'pattern';
*/


-- some more examples
SELECT * FROM employee WHERE first_name REGEXP '^N';     -- first name starting with 'N'

SELECT * FROM employee WHERE first_name REGEXP 'a$';     -- first name ending with 'a'

SELECT * FROM employee WHERE last_name REGEXP 'ha';    -- employees whose last names contain 'ha'

SELECT * FROM employee WHERE first_name REGEXP '[as]';     -- employees whose first name contain 'a' or 's'

SELECT * FROM employee WHERE first_name REGEXP '^vi';   -- employees whose first name begin with 'vi'

SELECT * FROM employee WHERE first_name REGEXP '^[mns]';   -- employees whose first name begin with 'm', 'n' or 's'

SELECT * FROM employee WHERE first_name REGEXP 'an$';   -- employees whose first name ends with 'an'

SELECT * FROM employee WHERE first_name REGEXP '[an]$';   -- employees whose first name ends with 'a' or 'n'

SELECT * FROM employee WHERE first_name REGEXP '(a|n)$';   -- employees whose first name ends with 'a' or 'n'

SELECT * FROM employee WHERE first_name REGEXP '^[a-z]{4}$';    -- employees whose first name has 4 characters

SELECT * FROM employee WHERE first_name NOT REGEXP 'a';    -- employees whose first name does not contain 'a'

SELECT * FROM employee_info WHERE city REGEXP 'Pune|Mumbai';      -- Matches if city is either “Pune” or “Mumbai”.

SELECT * FROM employee_info WHERE phone REGEXP '[0-9]';    -- employees whose phone column contain a number

SELECT * FROM employee_info WHERE city REGEXP '[Mum|Ban]';   -- employees from cities starting with 'Mum' or 'Ban' 

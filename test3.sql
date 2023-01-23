     --1)

select sum(int_quantity*int_price) as total_cost from tbl_stock;

-- output     


 total_cost
------------
    214015.5
(1 row)

       --2)

select sum(int_quantity) as total_no_product from tbl_stock;

    --  output   

 total_no_product
------------
         177
(1 row)

        ---3)

SELECT upper(vchr_name) from tbl_stock;
SELECT round() from tbl_stock;

-- output     

test=# select * from tbl_stock;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               1 | Mouse     |           10 |     501.5 |               1
               2 | Keyboard  |            5 |     451.5 |               3
               3 | modem     |           10 |    1201.5 |               2
               5 | Headphone |           50 |     751.5 |               4
               6 | memory    |            2 |    3501.5 |               4
               7 | Memory    |          100 |      1500 |               5
(6 rows)

  ---    4)

select count(vchr_name) as items from tbl_stock;

-- output  

 items
-------
     6
(1 row)

----    5)
SELECT vchr_name,int_price from tbl_stock where int_price = (select max(int_price) from tbl_stock);

-- output  

vchr_name | int_price
-----------+-----------
 memory    |    3501.5
(1 row)

----    6)

select sum(int_count) as total_enrollment from tbl_enrollment;

-- output  

 total_enrollment
------------------
              351
(1 row)

----    7)

select count(vchr_classes_name) as no_of_classes from tbl_classes;

-- output 

 no_of_classes
---------------
             7
(1 row)

----    8)

delete from tbl_stock where fk_int_supplier = 5;

-- output

 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
               1 | Mouse     |           10 |     501.5 |               1
               2 | Keyboard  |            5 |     451.5 |               3
               3 | modem     |           10 |    1201.5 |               2
               5 | Headphone |           50 |     751.5 |               4
               6 | memory    |            2 |    3501.5 |               4
(5 rows)

----    9)

select concat(vchr_name,int_price) as Product_price from tbl_stock;

-- output  

product_price
----------------
 Mouse501.5
 Keyboard451.5
 modem1201.5
 Headphone751.5
 memory3501.5
(5 rows)

----    10)

select tbl_student.name,tbl_grade.course 
from tbl_student inner join tbl_grade 
on tbl_student.roll_no = tbl_grade.roll_no WHERE tbl_grade.grade = 'A';

-- output

 name   | course
---------+--------
 paul    | java
 Akhil   | C
 Maya    | java
 Maya    | php
 Sandeep | php
(5 rows)

----    11)

select tbl_student.enrollment_no,tbl_student.roll_no,tbl_student.name,tbl_student.city,tbl_student.mobile,tbl_student.dob,tbl_grade.course,tbl_grade.grade
from tbl_student inner join tbl_grade
on tbl_student.roll_no = tbl_grade.roll_no WHERE tbl_grade.grade = 'B';

-- output 

enrollment_no | roll_no | name  |   city   |  mobile   |    dob     | course | grade
---------------+---------+-------+----------+-----------+------------+--------+-------
             3 |       1 | paul  | Cochin   | 96754555  | 1991-03-13 | C      | B
            11 |       2 | Akhil | Delhi    | 96456555  | 1986-01-12 | java   | B
             6 |       4 | Maya  | Banglore | 945678555 | 1987-11-12 | C      | B
             1 |       8 | Anoop | Banglore | 96876585  | 1990-12-22 | java   | B

----    12)

select tbl_student.name,tbl_grade.roll_no,count(tbl_grade.roll_no) as course_count
from tbl_student inner join tbl_grade
on tbl_student.roll_no = tbl_grade.roll_no GROUP by tbl_grade.roll_no,tbl_student.roll_no;

-- output  

  name   | roll_no | course_count
---------+---------+--------------
 paul    |       1 |            2
 Akhil   |       2 |            2
 Anoop   |       8 |            1
 Sandeep |       5 |            2
 Maya    |       4 |            3
(5 rows)

----    13)

select tbl_student.name
from tbl_student inner join tbl_grade 
on tbl_student.roll_no = tbl_grade.roll_no WHERE tbl_grade.course = 'java' and tbl_student.city ='Banglore';

-- output  

name
-------
 Maya
 Anoop
(2 rows)

----    14)

select tbl_student.name,tbl_grade.course
from tbl_student inner join tbl_grade 
on tbl_student.roll_no = tbl_grade.roll_no WHERE tbl_student.name  LIKE 'A%'; 

-- output  

 name  | course
-------+--------
 Anoop | java
 Akhil | C
 Akhil | java
(3 rows)

----    15)

SELECT name ,date_part('year',age(dob))as age from tbl_student;

-- output  

SELECT name ,date_part('year',age(dob))as age from tbl_student;
  name   | age
---------+-----
 paul    |  31
 Akhil   |  37
 Maya    |  35
 Sandeep |  29
 Anoop   |  32

----    16)

select name,to_char("dob",'DD-Mon-YYYY') from tbl_student;

-- output  

 name   |   to_char
---------+-------------
 paul    | 13-Mar-1991
 Akhil   | 12-Jan-1986
 Maya    | 12-Nov-1987
 Sandeep | 14-Jun-1993
 Anoop   | 22-Dec-1990
(5 rows)
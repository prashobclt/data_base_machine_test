-- 1)
CREATE TABLE tbl_stock(
    pk_int_stock_Id SERIAL PRIMARY KEY,
    vchr_name VARCHAR(20),
    int_quantity INT,
    int_price INT
);
test=# \d tbl_stock;
                                              Table "public.tbl_stock"
     Column      |         Type          | Collation | Nullable |                      Default
-----------------+-----------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer               |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(20) |           |          |
 int_quantity    | integer               |           |          |
 int_price       | integer               |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)

-- 2)
ALTER TABLE tbl_stock ALTER COLUMN int_price TYPE float;

test=# \d tbl_stock;
                                              Table "public.tbl_stock"
     Column      |         Type          | Collation | Nullable |                      Default
-----------------+-----------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer               |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(20) |           |          |
 int_quantity    | integer               |           |          |
 int_price       | double precision      |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)

-- 3) 
CREATE TABLE tbl_supplier(
    pk_int_supplier_Id SERIAL PRIMARY KEY,
    vchr_supplier_name VARCHAR(25)
);
test=# \d tbl_supplier;
                                                 Table "public.tbl_supplier"
       Column       |         Type          | Collation | Nullable |                         Default                          --------------------+-----------------------+-----------+----------+---------------------------------------------------------- pk_int_supplier_id | integer               |           | not null | nextval('tbl_supplier_pk_int_supplier_id_seq'::regclass)
 vchr_supplier_name | character varying(25) |           |          |
Indexes:
    "tbl_supplier_pkey" PRIMARY KEY, btree (pk_int_supplier_id)

--  4)
 test=# ALTER TABLE tbl_stock ADD COLUMN fk_int_supplier INT;


test=# select * from tbl_stock;
 pk_int_stock_id | vchr_name | int_quantity | int_price | fk_int_supplier
-----------------+-----------+--------------+-----------+-----------------
(0 rows)

--   5) 

ALTER TABLE tbl_stock ADD CONSTRAINT fk_int_supplier FOREIGN KEY(fk_int_supplier) REFERENCES tbl_supplier(pk_int_supplier_id);

test=# \d tbl_stock;
                                              Table "public.tbl_stock"
     Column      |         Type          | Collation | Nullable |                      Default
-----------------+-----------------------+-----------+----------+----------------------------------------------------
 pk_int_stock_id | integer               |           | not null | nextval('tbl_stock_pk_int_stock_id_seq'::regclass)
 vchr_name       | character varying(20) |           |          |
 int_quantity    | integer               |           |          |
 int_price       | double precision      |           |          |
 fk_int_supplier | integer               |           |          |
Indexes:
    "tbl_stock_pkey" PRIMARY KEY, btree (pk_int_stock_id)
Foreign-key constraints:
    "fk_int_supplier" FOREIGN KEY (fk_int_supplier) REFERENCES tbl_supplier(pk_int_supplier_id)

-- 6) 
CREATE TABLE tbl_dept(
    pk_int_dept_Id SERIAL PRIMARY KEY,
    vchr_dept_name VARCHAR(25)
);

test=# \d tbl_dept;
                                             Table "public.tbl_dept"
     Column     |         Type          | Collation | Nullable |                     Default
----------------+-----------------------+-----------+----------+--------------------------------------------------
 pk_int_dept_id | integer               |           | not null | nextval('tbl_dept_pk_int_dept_id_seq'::regclass)
 vchr_dept_name | character varying(25) |           |          |
Indexes:
    "tbl_dept_pkey" PRIMARY KEY, btree (pk_int_dept_id)


-- 7) 
CREATE TABLE tbl_classes(
    pk_int_classes_Id SERIAL PRIMARY KEY,
    fk_int_dept_id INT,
    vchr_classes_name VARCHAR(25),
    FOREIGN KEY (fk_int_dept_id)REFERENCES tbl_dept(pk_int_dept_id) ON DELETE CASCADE ON UPDATE CASCADE 
);

test=# \d tbl_classes;
                                                Table "public.tbl_classes"
      Column       |         Type          | Collation | Nullable |                        Default
-------------------+-----------------------+-----------+----------+--------------------------------------------------------
 pk_int_classes_id | integer               |           | not null | nextval('tbl_classes_pk_int_classes_id_seq'::regclass)
 fk_int_dept_id    | integer               |           |          |
 vchr_classes_name | character varying(25) |           |          |
Indexes:
    "tbl_classes_pkey" PRIMARY KEY, btree (pk_int_classes_id)
Foreign-key constraints:
    "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dept_id) ON UPDATE CASCADE ON DELETE CASCADE

-- 8) 
CREATE TABLE tbl_enrollment(
    pk_int_enrollment_Id SERIAL PRIMARY KEY,
    fk_int_class_id INT,
    int_count INT,
    FOREIGN KEY (fk_int_class_id)REFERENCES tbl_classes(pk_int_classes_id) ON DELETE CASCADE ON UPDATE CASCADE 
);

test=# \d tbl_enrollment;
                                            Table "public.tbl_enrollment"
        Column        |  Type   | Collation | Nullable |                           Default
----------------------+---------+-----------+----------+--------------------------------------------------------------
 pk_int_enrollment_id | integer |           | not null | nextval('tbl_enrollment_pk_int_enrollment_id_seq'::regclass)
 fk_int_class_id      | integer |           |          |
 int_count            | integer |           |          |
Indexes:
    "tbl_enrollment_pkey" PRIMARY KEY, btree (pk_int_enrollment_id)
Foreign-key constraints:
    "tbl_enrollment_fk_int_class_id_fkey" FOREIGN KEY (fk_int_class_id) REFERENCES tbl_classes(pk_int_classes_id) ON UPDATE CASCADE ON DELETE CASCADE

--   9) 

ALTER TABLE tbl_classes ADD CONSTRAINT unique_constrain UNIQUE (vchr_classes_name);

test=# \d tbl_classes;
                                                Table "public.tbl_classes"
      Column       |         Type          | Collation | Nullable |                        Default
-------------------+-----------------------+-----------+----------+--------------------------------------------------------
 pk_int_classes_id | integer               |           | not null | nextval('tbl_classes_pk_int_classes_id_seq'::regclass)
 fk_int_dept_id    | integer               |           |          |
 vchr_classes_name | character varying(25) |           |          |
Indexes:
    "tbl_classes_pkey" PRIMARY KEY, btree (pk_int_classes_id)
    "unique_constrain" UNIQUE CONSTRAINT, btree (vchr_classes_name)
Foreign-key constraints:
    "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dept_id) ON UPDATE CASCADE ON DELETE CASCADE
Referenced by:
    TABLE "tbl_enrollment" CONSTRAINT "tbl_enrollment_fk_int_class_id_fkey" FOREIGN KEY (fk_int_class_id) REFERENCES tbl_classes(pk_int_classes_id) ON UPDATE CASCADE ON DELETE CASCADE


--   10) 

ALTER TABLE tbl_dept ADD COLUMN vchr_dept_description VARCHAR(20);

test=# \d tbl_dept;
                                                 Table "public.tbl_dept"
        Column         |         Type          | Collation | Nullable |                     Default
-----------------------+-----------------------+-----------+----------+--------------------------------------------------
 pk_int_dept_id        | integer               |           | not null | nextval('tbl_dept_pk_int_dept_id_seq'::regclass)
 vchr_dept_name        | character varying(25) |           |          |
 vchr_dept_description | character varying(20) |           |          |
Indexes:
    "tbl_dept_pkey" PRIMARY KEY, btree (pk_int_dept_id)
Referenced by:
    TABLE "tbl_classes" CONSTRAINT "tbl_classes_fk_int_dept_id_fkey" FOREIGN KEY (fk_int_dept_id) REFERENCES tbl_dept(pk_int_dept_id) ON UPDATE CASCADE ON DELETE CASCADE

--    11)

INSERT INTO tbl_supplier(pk_int_supplier_id,vchr_supplier_name) VALUES(1,'logitech'),(2,'Samsung'),(3,'Iball'),(4,'LG'),(5,'Creative');

test=# select * from tbl_supplier;
 pk_int_supplier_id | vchr_supplier_name
--------------------+--------------------
                  1 | logitech
                  2 | Samsung
                  3 | Iball
                  4 | LG
                  5 | Creative
(5 rows)


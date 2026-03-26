

--===================================================
--creating gold.dim_customer table
--===================================================
IF OBJECT_ID('gold.dim_customer','V') IS NOT NULL
	DROP VIEW gold.dim_customer;
GO
CREATE VIEW gold.dim_customer AS
SELECT
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	lo.cntry AS country,
	ci.cst_marital_status AS marital_status,
	CASE WHEN ci.cst_gender !='n\a' THEN ci.cst_gender
		ELSE COALESCE(ca.gen,'n\a')
	END AS gender,
	ca.bdate AS birthdate,
	ci.cst_create_date AS created_date
	
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_loc_a101 AS lo
ON ci.cst_key=lo.cid
LEFT JOIN silver.erp_cust_az12 AS ca
ON ca.cid=ci.cst_key;
GO



--===================================================
--creating gold.dim_product table
--===================================================
IF OBJECT_ID('gold.dim_products','V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO
CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key, -- Surrogate key
    pn.prd_id       AS product_id,
    pn.prd_key      AS product_number,
    pn.prd_nm       AS product_name,
    pn.cat_id       AS category_id,
    pc.cat          AS category,
    pc.subcat       AS subcategory,
    pc.maintenance  AS maintenance,
    pn.prd_cost     AS cost,
    pn.prd_line     AS product_line,
    pn.prd_start_dt AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL;
GO

--===================================================
--creating gold.fact_sales table
--===================================================
IF OBJECT_ID('gold.fact_sales','V') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS
SELECT 
	sl.sls_ord_num AS sales_order_number,
	gp.product_key AS product_key,
	gc.customer_key AS customer_key,
	sl.sls_order_dt AS order_date,
	sl.sls_ship_dt AS ship_date,
	sl.sls_due_dt AS due_date,
	sl.sls_sales AS sales_amount,
	sl.sls_quantity AS quantity,
	sl.sls_price AS price
FROM silver.crm_sales_details as sl
LEFT JOIN gold.dim_products as gp
ON sl.sls_prd_key=gp.product_number
LEFT JOIN gold.dim_customer as gc
ON sl.sls_cust_id= gc.customer_id;
GO



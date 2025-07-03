-- Query retrieves aggregated data of sales reasons only for reasons assigned --

WITH sales_per_reason AS (
   SELECT
     DATE_TRUNC(OrderDate, MONTH) AS year_month,
     sales_reason.SalesReasonID AS sales_reason_id,
     SUM(sales.TotalDue) AS sales_amount
   FROM
     `tc-da-1.adwentureworks_db.salesorderheader` AS sales
   INNER JOIN
     `tc-da-1.adwentureworks_db.salesorderheadersalesreason` AS sales_reason
   ON
     sales.SalesOrderID = sales_reason.salesOrderID
   GROUP BY
    year_month,
    sales_reason_id
)

SELECT
    sales_per_reason.year_month,
    reason.Name AS sales_reason,
    sales_per_reason.sales_amount
FROM
    sales_per_reason
LEFT JOIN -- Only having sales reason assigned
    `tc-da-1.adwentureworks_db.salesreason` AS reason
ON
    sales_per_reason.SalesReasonID = reason.SalesReasonID
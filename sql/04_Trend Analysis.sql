#Sales Trend
select cast(TransactionDate as date) as DATETRANS, 
    count(*) as Transaction_count,
    sum(QuantityPurchased) as TotalUnitsSold,
    round(sum(QuantityPurchased*Price),2) as TotalSales
    from sales_transaction
    group by cast(TransactionDate as date) order by DATETRANS desc;
    
#Growth Rate of Sales
SELECT EXTRACT(MONTH FROM TransactionDate) AS month,
	ROUND(SUM(QuantityPurchased * Price), 2) AS total_sales,
	LAG(ROUND(SUM(QuantityPurchased * Price), 2), 1)
    OVER (ORDER BY EXTRACT(MONTH FROM TransactionDate)) 
    AS previous_month_sales,
ROUND((ROUND(SUM(QuantityPurchased * Price), 2)
            - LAG(ROUND(SUM(QuantityPurchased * Price), 2), 1)
            OVER (ORDER BY EXTRACT(MONTH FROM TransactionDate)))
        / LAG(ROUND(SUM(QuantityPurchased * Price), 2), 1)
        OVER (ORDER BY EXTRACT(MONTH FROM TransactionDate))* 100,
    2) AS mom_growth_percentage FROM sales_transaction GROUP BY EXTRACT(MONTH FROM TransactionDate);

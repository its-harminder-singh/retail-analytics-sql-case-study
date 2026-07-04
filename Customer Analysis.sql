#Customer Purchase Frequency 
select CustomerID, count(*) as NumberofTransactions from Sales_transaction
    group by CustomerID
    order by NumberofTransactions desc;
    
# Repeat Purchases
select CustomerID,
    ProductID,
    count(*) as TimesPurchased
    from Sales_transaction
    group by CustomerID ,ProductID having count(*)>1
    order by TimesPurchased desc;

#Loyalty Indicators
select CustomerID,
    min(cast(TransactionDate as Date)) as FirstPurchase,
    max(cast(TransactionDate as Date))  as LastPurchase,
    datediff(max(cast(TransactionDate as Date)),min(cast(TransactionDate as Date))) as DaysBetweenPurchases
    from Sales_transaction
    group by CustomerID having max(cast(TransactionDate as Date))-min(cast(TransactionDate as Date))>0
    order by DaysBetweenPurchases desc;
    
#High Purchase Frequency 
SELECT 
    CustomerID,
    COUNT(TransactionID) AS NumberOfTransactions,
    SUM(QuantityPurchased * Price) AS TotalSpent
FROM sales_transaction
GROUP BY CustomerID
HAVING COUNT(TransactionID) > 10
   AND SUM(QuantityPurchased * Price) > 1000
ORDER BY TotalSpent DESC;
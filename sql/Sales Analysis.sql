#Total Sales Summary
select ProductID, sum(QuantityPurchased) as TotalUnitsSold,
    sum(QuantityPurchased*Price) as TotalSales
        from Sales_transaction
        group by ProductID order by TotalSales desc;
        
#High Sale Products
select ProductID,
    sum(QuantityPurchased*Price) as TotalRevenue
    from Sales_transaction
    group by ProductID order by TotalRevenue desc limit 10;
    
#Low Sale Products
select ProductID,
    sum(QuantityPurchased) as TotalUnitsSold
    from Sales_transaction 
    group by ProductID  HAVING SUM(QuantityPurchased) > 0  order by TotalUnitsSold asc limit 10;

#Product Categories Performance
select p.Category, 
    sum(s.QuantityPurchased) as TotalUnitsSold,
    sum(s.QuantityPurchased*s.Price) as TotalSales
    from product_inventory p 
    join Sales_transaction s
    on p.ProductID=s.ProductID
    group by p.Category order by TotalSales desc;

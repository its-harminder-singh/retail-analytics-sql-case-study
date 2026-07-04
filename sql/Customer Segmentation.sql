#Customer Segmentation
CREATE TABLE customer_segment (
    CustomerSegment VARCHAR(100));
INSERT INTO customer_segment (CustomerSegment)
VALUES 
('Low'),
('Med'),
('High');
SELECT cs.CustomerSegment, COUNT(*) FROM customer_segment cs
JOIN (SELECT CustomerID, CASE WHEN SUM(QuantityPurchased) BETWEEN 1 AND 10 THEN 'Low'
            WHEN SUM(QuantityPurchased) BETWEEN 11 AND 30 THEN 'Med'
            ELSE 'High'
        END AS CustomerSegment
    FROM sales_transaction
    GROUP BY CustomerID
) cust ON cs.CustomerSegment = cust.CustomerSegment
GROUP BY cs.CustomerSegment
ORDER BY 2 DESC;

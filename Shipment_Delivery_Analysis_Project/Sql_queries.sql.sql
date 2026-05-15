create database shipment;
show databases;
use shipment;
show tables from shipment;
select * from shipment_data;
describe shipment_data;
ALTER TABLE shipment_data
CHANGE `Reached.on.Time_Y.N` Reached_on_Time int;

-- Step: Data Understanding – Analyze Target Variable
SELECT Reached_on_Time, COUNT(*) 
FROM shipment_data group by Reached_on_Time;
-- INSIGHT: A significant portion of shipments (~40%) are delayed

-- Step: Analysis – Shipment Mode Performance
SELECT Mode_of_Shipment,
       AVG(Reached_on_Time) AS success_rate
FROM shipment_data
GROUP BY Mode_of_Shipment;
-- INSIGHT: Flight has slightly better delivery performance

-- Step: Analysis – Warehouse Performance
SELECT Warehouse_block,
       AVG(Reached_on_Time) AS performance
FROM shipment_data
GROUP BY Warehouse_block
ORDER BY performance DESC;
-- INSIGHT: Warehouse B performs best,shows highest efficiency.

-- Step: Analysis – Customer Care Calls Impact
SELECT Customer_care_calls,
       AVG(Reached_on_Time) AS success_rate
FROM shipment_data
GROUP BY Customer_care_calls
ORDER BY Customer_care_calls;
/* Insight – Customer Care Calls
Increase in customer care calls leads to decrease in on-time delivery, showing strong negative impact.*/

-- Step: Analysis – Discount Impact
SELECT Discount_offered,
       AVG(Reached_on_Time) AS success_rate
FROM shipment_data
GROUP BY Discount_offered
ORDER BY Discount_offered;

-- Step: Analysis – Discount Impact (Filtered)
SELECT Discount_offered,
       COUNT(*) AS total_orders,
       AVG(Reached_on_Time) AS success_rate
FROM shipment_data
GROUP BY Discount_offered
HAVING COUNT(*) > 50
ORDER BY Discount_offered;

-- Step: Analysis – Product Importance Impact
SELECT Product_importance,
       AVG(Reached_on_Time) AS success_rate
FROM shipment_data
GROUP BY Product_importance;

-- Step: Analysis – Weight Impact
SELECT 
    CASE 
        WHEN Weight_in_gms < 2000 THEN 'Light'
        WHEN Weight_in_gms BETWEEN 2000 AND 4000 THEN 'Medium'
        ELSE 'Heavy'
    END AS weight_category,
    AVG(Reached_on_Time) AS success_rate
FROM shipment_data
GROUP BY weight_category;

-- Step: Analysis – Weight Category Distribution
SELECT 
    CASE 
        WHEN Weight_in_gms < 2000 THEN 'Light'
        WHEN Weight_in_gms BETWEEN 2000 AND 4000 THEN 'Medium'
        ELSE 'Heavy'
    END AS weight_category,
    COUNT(*) AS total_orders
FROM shipment_data
GROUP BY weight_category;
-- Insight – Weight Impact Heavy shipments are more likely to be delayed, showing weight significantly affects delivery efficiency.

-- Step: Final Check – Customer Rating Impact
SELECT Customer_rating,
       AVG(Reached_on_Time) AS success_rate
FROM shipment_data
GROUP BY Customer_rating
ORDER BY Customer_rating;

/*Conclusion
Around 40% shipments are delayed.
Customer care calls and weight affect delivery the most.
High priority products are delivered faster.
Shipment mode and warehouse have small impact.
Discount and customer rating have almost no effect.*/
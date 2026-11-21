Query 1: headline KPIs
SELECT
    ROUND(SUM(Revenue), 2) AS total_revenue,
    COUNT(DISTINCT Invoice) AS total_orders,
    COUNT(DISTINCT "Customer ID") AS total_customers,
    ROUND(SUM(Revenue) * 1.0 / COUNT(DISTINCT Invoice), 2) AS avg_order_value
FROM clean_data;

Query 2: monthly revenue
SELECT YearMonth, ROUND(SUM(Revenue), 0) AS revenue
FROM clean_data
GROUP BY YearMonth
ORDER BY YearMonth;

Query 3: top 10 products
SELECT Description, ROUND(SUM(Revenue), 0) AS revenue
FROM clean_data
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;

Query 4: top 10 countries
SELECT Country, ROUND(SUM(Revenue), 0) AS revenue
FROM clean_data
GROUP BY Country
ORDER BY revenue DESC
LIMIT 10;

Query 5: repeat purchase rate
SELECT ROUND(100.0 * SUM(CASE WHEN orders > 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS repeat_rate_pct
FROM (
    -- first, count how many orders each customer made
    SELECT "Customer ID", COUNT(DISTINCT Invoice) AS orders
    FROM clean_data
    WHERE "Customer ID" IS NOT NULL
    GROUP BY "Customer ID"
);

Query 6: revenue by RFM segment (uses a JOIN)
SELECT
    r.Segment,
    COUNT(DISTINCT c."Customer ID") AS customers,
    ROUND(SUM(c.Revenue), 0) AS revenue
FROM clean_data c
JOIN rfm_customers r ON c."Customer ID" = r."Customer ID"
GROUP BY r.Segment
ORDER BY revenue DESC;
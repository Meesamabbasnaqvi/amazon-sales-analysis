USE amazon_data;

-- Total Rows
SELECT COUNT(*) AS total_rows
FROM amazon_data;

-- Total Revenue
SELECT FLOOR(SUM(amount)) AS total_revenue
FROM amazon_data;

-- Overall Cancellation Rate
SELECT 
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN LOWER(status) = 'cancelled' THEN order_id END)
        / COUNT(DISTINCT order_id),
        2
    ) AS cancellation_rate
FROM amazon_data;

-- Highest Cancellation Rate by Category
SELECT 
    category,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN LOWER(status) = 'cancelled' THEN order_id END)
        / COUNT(DISTINCT order_id),
        2
    ) AS cancellation_rate
FROM amazon_data
GROUP BY category
ORDER BY cancellation_rate DESC
LIMIT 5;

-- Revenue by Category and State
SELECT 
    category,
    ship_state,
    FLOOR(SUM(amount)) AS revenue
FROM amazon_data
GROUP BY category, ship_state
ORDER BY revenue DESC
LIMIT 5;

-- States with Revenue and Cancellation Rate
SELECT
    ship_state,
    ROUND(SUM(amount), 2) AS revenue,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN LOWER(status) = 'cancelled' THEN order_id END)
        / COUNT(DISTINCT order_id),
        2
    ) AS cancellation_rate,
    COUNT(DISTINCT order_id) AS total_orders
FROM amazon_data
GROUP BY ship_state
ORDER BY revenue DESC
LIMIT 5;

-- Amazon vs Merchant Fulfilment
SELECT
    fulfilment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(amount), 2) AS revenue,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN LOWER(status) = 'cancelled' THEN order_id END)
        / COUNT(DISTINCT order_id),
        2
    ) AS cancellation_rate
FROM amazon_data
GROUP BY fulfilment
ORDER BY revenue DESC;

-- Top SKU / Style by Revenue
SELECT 
    sku,
    style,
    FLOOR(SUM(amount)) AS revenue
FROM amazon_data 
GROUP BY sku, style 
ORDER BY revenue DESC
LIMIT 5;

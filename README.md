# Retail Sales & Customer Analytics

Python data cleaning, RFM segmentation, cohort retention analysis, and a 2-page Power BI dashboard
built on 1M+ online retail transactions.

## Business Problem
An online gift retailer wants to know where its revenue comes from, which customers matter most,
and how well it keeps them. This project cleans the raw transaction data, answers those questions,
and turns the results into recommendations.

## Tools Used
Python (pandas, NumPy, Matplotlib, Seaborn), SQL (SQLite), Power BI, Jupyter, Git

## Dataset
[Online Retail II (UCI)](https://archive.ics.uci.edu/dataset/502/online+retail+ii): UK-based online
retailer transactions from Dec 2009 to Dec 2011 (1,067,371 rows, 8 columns).

## Data Cleaning
| Issue | Before | After |
|---|---|---|
| Total rows | 1,067,371 | 1,001,809 |
| Missing Description | 4,382 | 0 |
| Exact duplicate rows | 34,335 | 0 |
| Quantity <= 0 | 22,950 | 0 |
| Price <= 0 | 6,207 | 0 |
| Cancelled invoices | 19,494 | 0 (kept in a separate table) |

**Key decisions**
- Removed exact duplicates, invalid quantities and prices, and non-product codes (POST, DOT, M, etc.).
- Kept rows with no Customer ID (about 22%) for revenue analysis, and excluded them only from
  customer-level analysis (RFM and cohorts).
- Spotted that a few giant orders (like 80,995 units of one product) were data-entry mistakes cancelled
  within minutes. I removed any sale cancelled within 24 hours by the same customer for the same
  product and quantity, which took out about 404K of inflated revenue.
- Overall, 65,562 rows (6.14%) were removed.

## Key Findings
- Total revenue is about 19.24M from 39,374 orders and 5,850 identified customers.
  Average order value is 488.61.
- The UK accounts for about 85% of revenue.
- Revenue peaks every October to November.
- 72.29% of customers placed more than one order.
- The cancellation rate is 17.40%.
- **25% of customers (Champions) generate about 70% of revenue.**
- About 1 in 5 customers return the month after their first purchase (20.9% on average).
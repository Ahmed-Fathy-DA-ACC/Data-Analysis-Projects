# Olist E-Commerce Data Analysis using SQL & Python

## Overview

This project presents a complete Exploratory Data Analysis (EDA) of the Brazilian Olist E-Commerce dataset using **SQL** and **Python**. The project demonstrates data extraction, preprocessing, SQL analysis, statistical exploration, feature engineering, and data visualization to generate meaningful business insights.

---

## Project Objectives

- Explore the dataset structure.
- Clean and preprocess the data.
- Analyze customer purchasing behavior.
- Analyze payment methods.
- Analyze product characteristics.
- Perform statistical analysis.
- Generate business insights using SQL and Python.
- Visualize findings with charts.

---

## Technologies Used

- Python
- SQL
- Pandas
- NumPy
- Matplotlib
- Plotly
- Jupyter Notebook
- Visual Studio Code

---

## Dataset

The project uses the **Olist Brazilian E-Commerce Public Dataset**.

The dataset contains:

- Customers
- Orders
- Order Items
- Products
- Sellers
- Payments
- Reviews
- Geolocation
- Product Categories

---

# Import Libraries

```python
import plotly.graph_objs as go
from plotly.offline import iplot
import pandas as pd
import matplotlib.pyplot as plt
import plotly.express as px
import json
import requests

url = 'https://raw.githubusercontent.com/codeforamerica/click_that_hood/master/public/data/brazil-states.geojson'
geojson_data = requests.get(url).json()
```

---

# Early Statistics

```python
numeric_columns = df.select_dtypes(include=['float64', 'int64']).columns
categorical_columns = df.select_dtypes(include=['object']).columns
date_time_columns = df.select_dtypes(include=['datetime64[ns]']).columns

df[numeric_columns].describe()
```

The descriptive statistics provided insights into the numerical features of the dataset, including count, mean, standard deviation, minimum, maximum, and quartiles. This helped identify data distribution, detect outliers, and better understand product and payment-related variables.

---

# SQL Analysis

## Payment Types

```sql
SELECT
    payment_type,
    COUNT(payment_type) AS Payment_Types_count
FROM order_payments
GROUP BY payment_type
ORDER BY Payment_Types_count DESC;
```

---

## Order Status

```sql
SELECT
    order_status,
    COUNT(order_status) AS Payment_Status_count
FROM orders
GROUP BY order_status
ORDER BY Payment_Status_count DESC;
```

---

## Product Weight & Product Volume

```sql
SELECT TOP 10
    c.product_category_name_english,
    p.product_weight_g,
    (p.product_length_cm * p.product_height_cm * p.product_width_cm) AS product_volume_cm3
FROM products p
JOIN category_name c
    ON c.product_category_name = p.product_category_name
WHERE p.product_category_name IS NOT NULL
ORDER BY p.product_weight_g DESC;
```

---

# Data Visualization

## Top 10 Ordered Product Categories

```python
category_ordered = df.groupby('product_category_name_english')['order_id'].count().sort_values(ascending=False).head(10)

x = category_ordered.index
y = category_ordered.values

plt.figure(figsize=(14, 6))
bars = plt.bar(x, y, color="#8f285b", label="Total Orders", width=0.4)

plt.title(
    "Top 10 Ordered Product Categories",
    fontdict={'fontname': 'Comic Sans MS', 'fontsize': 18}
)

plt.xlabel("Product Category", fontsize=12)
plt.ylabel("Total Orders", fontsize=12)
plt.xticks(rotation=45, ha='right')

plt.legend(loc="upper right", ncol=2, title="Legend")
plt.tight_layout()

for bar in bars:
    height = bar.get_height()
    plt.annotate(
        f'{height:,}',
        xy=(bar.get_x() + bar.get_width() / 2, height),
        xytext=(0, 3),
        textcoords="offset points",
        ha='center',
        va='bottom',
        fontsize=10
    )

plt.show()
```

---

# Analysis Workflow

1. Import required Python libraries.
2. Load and inspect the dataset.
3. Generate descriptive statistics.
4. Clean and preprocess the data.
5. Perform SQL analysis on payment methods and order status.
6. Engineer new features such as product volume.
7. Aggregate product category information.
8. Visualize the top ordered product categories.
9. Extract business insights from the results.

---

# Key Insights

- Identified the most frequently used payment methods.
- Analyzed the distribution of order status.
- Calculated product volume using product dimensions.
- Compared products based on weight.
- Determined the most ordered product categories.
- Generated statistical summaries for numerical variables.
- Built clear visualizations to support business decisions.

---

# Project Structure

```text
Olist-Ecommerce/
│
├── Data/
│
├── SQL/
│   └── Queries.sql
│
├── Notebook/
│   └── olist-e-commerce.ipynb
│
├── README.md
│
└── requirements.txt
```

---

# Skills Demonstrated

- SQL Query Writing
- Python Programming
- Pandas
- NumPy
- Data Cleaning
- Exploratory Data Analysis (EDA)
- Statistical Analysis
- Feature Engineering
- Data Visualization
- Business Intelligence
- Data Aggregation

---

# Future Improvements

- Develop an interactive Power BI dashboard.
- Perform customer segmentation.
- Build machine learning models.
- Predict future sales.
- Analyze customer reviews using NLP.

---

# Contact

**Ahmed Fathy**

**GitHub**

https://github.com/Ahmed-Fathy-DA-ACC

**LinkedIn**

https://www.linkedin.com/in/ahmed-fathy-da-acc

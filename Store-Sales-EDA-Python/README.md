#                                                                           project description
# Sales Analytics and Exploratory Data Analysis (EDA)

## Business Problem

* **A 2,323-row transactional sales dataset** landed in a raw state — no profiling, no KPIs, no view of which products or price bands actually drive revenue and which ones bleed profit.
* **Stakeholders needed to know:** what does a normal customer/order look like, where do the loss cases hide (max loss = -3,701), and how do Quantity, Unit_Price and Total_Sale actually relate to each other?
* **Beyond profiling,** the analysis had to answer visual questions — product performance over time, regional quarterly sales, demographic distributions and correlations — in a language non-technical stakeholders could read at a glance.

---

## Analysis & Approach

> [!NOTE]
> **Core Framework**
> * **Ran full exploratory data analysis (EDA)** in Python with Pandas: `df.describe()` to profile 2,323 records, checked min/max/std to detect outliers (Sales max 17,499, Profit min -3,701) and used quantiles (25/50/75%) to understand distribution shape.
> * **Built a correlation matrix** with Seaborn heatmap on Quantity, Unit_Price and Total_Sale — quantified relationships (Qty↔Total 0.71, Price↔Total 0.64, Qty↔Price 0.03) to guide feature selection.

> [!TIP]
> **Visualization & Dashboarding**
> * **Designed a full Matplotlib visual library:** line plots (single & multi-series with markers), bar charts (vertical, horizontal, grouped, coloured with value labels), scatter plots, histograms (single, overlaid, normalized density), pie & donut charts (with explode/shadow), and a 2×2 subplot grid for mathematical functions.
> * **Consolidated the story** into a Sales Analytics Dashboard — Q1 & Q2 2024 figure combining Revenue vs Expenses trend, monthly profit and product-mix in one multi-panel Matplotlib layout using `plt.subplots(figsize=(16,10))`.

---

## Final Insights & Results

> [!IMPORTANT]
> **Executive Summary & Key Takeaways**
> 
> * **Volume beats price:** Quantity correlates 0.71 with Total_Sale vs Unit_Price at 0.64 — selling more units moves revenue more than raising prices, and Qty & Price are independent (0.03) so they can be optimised separately.
> * **Loss detection:** minimum Profit of -3,701 exposed a segment of loss-making transactions hidden inside a healthy 17.09 average profit — flagged for discount/return policy review.
> * **Product mix:** Product A grew from 50 to 70 units (+40% over 6 months) leading the portfolio, Product B stabilised at 55-60, and Product C recovered from a March dip — informing Q3 stock allocation.
> * **Regional performance:** East region wins every quarter and peaks at 62K in Q4, while North is the weakest — clear signal to reinforce East and diagnose North's underperformance.
> * **Distribution shape:** exam-score histogram on 1,000 samples returned mean 75.2 with a near-normal, slightly right-skewed distribution — confirming the assumption needed for downstream statistical tests.

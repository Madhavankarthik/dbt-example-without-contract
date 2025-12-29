# DBT Example Project

This project demonstrates a simple data transformation pipeline using dbt (data build tool). It includes models for orders, customers, and daily order metrics.

## Project Structure

- `models/`: Contains SQL models and their YAML definitions
  - `orders.sql` & `orders.yml`: Basic order data transformation
  - `customers.sql` & `customers.yml`: Customer information
  - `daily_order_metrics.sql` & `daily_order_metrics.yml`: Aggregated daily metrics for business analytics
- `seeds/`: Contains CSV files used as data sources
  - `raw_orders.csv`: Sample order data
  - `raw_customers.csv`: Sample customer data

## Models

### Orders

The orders model transforms raw order data, including:
- order_id
- customer_id
- order_date
- status
- amount

### Customers

The customers model provides customer information:
- customer_id
- first_name
- last_name
- email
- registration_date
- customer_segment
- region

### Daily Order Metrics

This model aggregates order data by date with metrics like:
- total_orders
- unique_customers
- total_revenue
- average_order_value
- completed vs. processing orders
- metrics by customer segment

## Getting Started

1. Install dbt: `pip install -r requirements.txt`
2. Configure your profile in `profiles.yml`
3. Run `dbt seed` to load the seed data
4. Run `dbt run` to build the models

## CI/CD Pipeline

This project includes a GitHub Actions workflow that automatically runs dbt tests when:
- Code is pushed to the main branch
- A pull request is opened against the main branch

The workflow is triggered when changes are made to:
- Models (`models/**`)
- Seeds (`seeds/**`)
- Project configuration (`dbt_project.yml`)

The workflow runs `dbt build` to ensure all models build correctly and pass their tests.

# 🥔 Potato Trader 🎰

A Rails API service that helps potato traders analyze price fluctuations and calculate maximum potential daily profits.

## 📝 Overview

This API provides endpoints to:
- Fetch potato prices for a specific date
- Calculate the maximum potential profit for potato trading on a given date

The system works with a fixed trading capacity of 100 tonnes of potatoes per day.

## ⚙️ Technical Stack

- Ruby 3.3.0
- Rails 7.1.5
- PostgreSQL
- RSpec

## 🕵️ Setup

1. Install dependencies:

```sh
bundle install
```

2. Set up the database:

```sh
rails db:create
rails db:migrate
rails db:seed
```

3. Start the server:

```sh
rails s
```

## 📚 API Documentation

### Get Daily Prices

```http
GET /api/v1/daily_prices/:date
```
Returns potato prices for the specified date.

**Parameters:**
- `date`: Date in YYYY-MM-DD format

### Calculate Maximum Profit

```http
GET /api/v1/max_potential_profit/:date
```
Calculates maximum potential profit for the specified date.

**Parameters:**
- `date`: Date in YYYY-MM-DD format

## 🔔 Error Handling

The API returns appropriate error responses:
- `400 Bad Request`: Invalid date format or future date
- `404 Not Found`: No data available for the date


## ✅ Tests
To run the test suite using RSpec

```sh
bundle exec rspec
```
The project includes tests for:
- Models (`spec/models/`)
- Controllers (`spec/controllers/`)
- Services (`spec/services/`)

## 📌 Business Rules

- Maximum trading volume: 100 tonnes per day
- Trading restrictions:
  - Cannot trade on future dates
  - Must buy and sell on the same day
  - Prices must be positive values
- Profit calculation: `(selling_price - buying_price) * volume`
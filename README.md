# Salon Appointment Scheduler

## What did I build?

I built a simple salon appointment booking system using Bash and PostgreSQL.

The script lets users:
- View available services
- Select a service
- Enter their phone number
- Register as a new customer if needed
- Book an appointment time

All customer and appointment data is stored in a PostgreSQL database.

---

## What skills used?

- Bash scripting
- PostgreSQL
- SQL queries
- Table relationships & foreign keys
- Reading user input with `read`
- Conditional statements and functions in Bash
- Database design

---

## How to run it?

### 1. Create the database
psql --username=freecodecamp --dbname=postgres
CREATE DATABASE salon;

### 2. Import the database dump
psql -U postgres < salon.sql

### Give executable permission
chmod +x salon.sh

### Run the project
./salon.sh

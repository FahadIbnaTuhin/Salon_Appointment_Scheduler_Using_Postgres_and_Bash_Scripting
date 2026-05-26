#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n" 

GET_SERVICES_ID() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  
  LIST_SERVICES=$($PSQL "SELECT service_id, name FROM services")
  echo "$LIST_SERVICES" | while read SERVICE_ID BAR NAME; do
    echo "$SERVICE_ID) $NAME" 
  done
  echo -e "\nSelect a Service Id:"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    [1-3]) NEXT ;;
        *) GET_SERVICES_ID "I could not find that service. What would you like today?" ;;
  esac
}

NEXT() {
  echo -e "\nEnter your phone number: "
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")
  if [[ -z $CUSTOMER_NAME ]]; then 
    echo -e "\nEnter your name: "
    read CUSTOMER_NAME
    SAVE_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")

    echo -e "\nHow many services do you want? "
    read SERVICE_TIME

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name='$CUSTOMER_NAME';")
    ADD_NEW_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")
  else 
    echo -e "\nHow many services do you want? "
    read SERVICE_TIME
  fi

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED';")
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

}

GET_SERVICES_ID
*** Settings ***
Documentation    Layer responsible for manage Sql Scripts

Library    DatabaseLibrary

Variables    Env.py

*** Keywords ***
Connect To Zombie Database
    Connect To Database    psycopg2    
    ...    dbName=${DB_NAME}
    ...    dbUsername=${DB_USER}
    ...    dbPassword=${DB_PASS}
    ...    dbHost=${DB_HOST}
    ...    dbPort=${DB_PORT}

Delete All From Leads
    Execute Sql String    DELETE FROM leads;

Delete All From Movies
    Execute Sql String    DELETE FROM movies;

Delete All From Series
    Execute Sql String    DELETE FROM tvshows;


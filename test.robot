*** Settings ***
Documentation  A test suite (6 test cases) for Data Quality testing of the tables from the database TRN

Library  DatabaseLibrary
Library  OperatingSystem
Library  Collections
# add your parameters here to connect to the DB
Suite Setup  Connect To Database Using Custom Params  pymssql  database='TRN', user='username', password='password', host="hostname", server="servername", port=1433
Suite Teardown  Disconnect From Database

*** Test Cases ***

Employees: the table should have at least 1 employee with empty manager_id
    [Tags]  AUTOTEST-001
    [Documentation]
    ...  |Steps:
    ...  |0. Connect to the database TRN
    ...  |1. Execute the query: select records from table Employees where manager is NULL
    ...  |Expected result: 0 records are displayed, status: pass
    Check If Exists In Database  select * from hr.employees where manager_id is NULL


Dependents: the table should present in the database
    [Tags]  AUTOTEST-002
    [Documentation]
    ...  |Steps:
    ...  |0. Connect to the database TRN
    ...  |1. Execute the query: select records from system info table where table name is 'dependents'
    ...  |Expected result: dependents table is present, status: pass
    Table Must Exist  dependents


Regions: 4 records are expected to be in the table
    [Tags]  AUTOTEST-003
    [Documentation]
    ...  |Steps:
    ...  |0. Connect to the database TRN
    ...  |1. Execute the query: select records from table Regions
    ...  |Expected result: 4 records are displayed, status: pass
    Row Count Is Equal To X    select * from hr.regions  4


Locations: US postal code should consist of 5 or 9(5-4) digits
    [Tags]  AUTOTEST-004
    [Documentation]
    ...  |Steps:
    ...  |0. Connect to the database TRN
    ...  |1. Execute the query: select records from table Locations where postal code doesn't meet formats: 5 digits or 9 digits(5-4)
    ...  |Expected result: 0 records are displayed, status: pass
    Row Count Is 0  select * from hr.locations except (select * from hr.locations where postal_code like '[0-9][0-9][0-9][0-9][0-9]%' union select * from hr.locations where postal_code like '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]%')


Countries: country_id should contain only from 2 letters
    [Tags]  AUTOTEST-005
    [Documentation]
    ...  |Steps:
    ...  |0. Connect to the database TRN
    ...  |1. Execute the query: select records from table Countries where country_id doesn't consist of 2 letters
    ...  |Expected result: 0 records are displayed, status: pass
    Row Count Is 0  select * from hr.countries where country_id not like '[A-Z][A-Z]'
    Log To Console    all country_id have the valid format

Dependents: the only values in relationship column is 'Child'
    [Tags]  AUTOTEST-006
    [Documentation]
    ...  |Steps:
    ...  |0. Connect to the database TRN
    ...  |1. Execute the query: select distinct values from table Dependents except 'Child'
    ...  |Expected result: 0 records are displayed, status: pass

    ${output}=  Execute SQL String  select distinct relationship from hr.dependents where relationship not in ('Child')
    Log  ${output}
    Should Be Equal As Strings  ${output}  None

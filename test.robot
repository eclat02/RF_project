*** Settings ***
Documentation  A test suite (6 test cases) for Data Quality testing of the tables from the database TRN

Library  DatabaseLibrary
Library  pyodbc
Library  OperatingSystem
Library  Collections
Suite Setup       Connect To Database Using Custom Params  pyodbc  ${string}
Suite Teardown    Disconnect From Database

*** Variables ***
# insert your parameters here (server name, user ID and password)
${string} =  "Driver={SQL Server Native Client 11.0};Server={EPBYMINW1762\\SQLEXPRESS};UID=username;PWD=password;DATABASE=TRN"

*** Test Cases ***
Jobs: job_id cannot be NULL
#    AUTOTEST-001. Jobs: job_id cannot be NULL
#    Steps:
#    0. Connect to the database TRN
#    1. Execute the query: select records from table Jobs where job_id is NULL
#    Expected result: 0 records are displayed, status: pass
    Row Count Is 0  select * from hr.jobs where job_id is NULL


Employees: email length cannot exceed 50 symbols
#    AUTOTEST-002. Employees: email length cannot exceed 50 symbols
#    Steps:
#    0. Connect to the database TRN
#    1. Execute the query: select records from table Employees where
#    the length of email field is more than 50 symbols
#    Expected result: 0 records are displayed, status: pass
    Row Count Is 0  select * from hr.employees where len(email) > 50


Regions: 4 records are expected to be in the table
#    AUTOTEST-003. Regions: 4 records are expected to be in the table
#    Steps:
#    0. Connect to the database TRN
#    1. Execute the query: select records from table Regions
#    Expected result: 4 records are displayed, status: pass
    Row Count Is Equal To X    select * from hr.regions  4


Locations: US postal code should consist of 5 or 9(5-4) digits
#    AUTOTEST-004. Locations: US postal code should consist of 5 or 9(5-4) digits
#    Steps:
#    0. Connect to the database TRN
#    1. Execute the query: select records from table Locations
#    where postal code doesn't meet formats: 5 digits or 9 digits(5-4)
#    Expected result: 0 records are displayed, status: pass
    Row Count Is 0  select * from hr.locations except (select * from hr.locations where postal_code like '[0-9][0-9][0-9][0-9][0-9]%' union select * from hr.locations where postal_code like '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]%')


Countries: country_id should contain only from 2 letters
#    AUTOTEST-005. Countries: country_id should contain only from 2 letters
#    Steps:
#    0. Connect to the database TRN
#    1. Execute the query: select records from table Countries
#    where country_id doesn't consist of 2 letters
#    Expected result: 0 records are displayed, status: pass
    Row Count Is 0  select * from hr.countries where country_id not like '[A-Z][A-Z]'


Dependents: the only values in relationship column is 'Child'
#    AUTOTEST-006. Dependents: the only values in relationship column is 'Child'
#    Steps:
#    0. Connect to the database TRN
#    1. Execute the query: select distinct values from table Dependents
#    except 'Child'
#    Expected result: 0 records are displayed, status: pass
    Row Count Is 0  select distinct relationship from hr.dependents where relationship not in ('Child')

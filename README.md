## Table of contents
* [General info](#general-info)
* [Preconditions](#preconditions)
* [Create a virtual environment for test cases execution](#create-a-virtual-environment-for-test-cases-execution)
* [Steps to run test cases and check results](#steps-to-run-test-cases-and-check-results)

## General info
RF_project contains the set of test cases for data quality checks in tables:
- Countries
- Locations
- Employees
- Regions
- Jobs
- Dependents
  

```test.robot``` is the main file which stores the set of test cases using Robot Framework. 
```Reports``` folder stores the results of test cases execution. Reports are generated and can be reviewed in ```report.html``` file.

## Preconditions
- PyCharm should be installed

## Create a virtual environment for test cases execution
1. In command line clone the project from the repo ```git clone https://github.com/dmaldavanau/RF_project```.
2. Go to the project directory using the command ```cd``` and the path to the cloned project.
3. In command line run ```pip install -r requirements.txt```.


## Steps to run test cases and check results
1. Open the command line from the project folder and run ```robot --outputdir ./Reports test.robot``` to start test cases execution.
2. Once test cases execution is done, the brief information about test cases execution results will be displayed.
3. To check Test Results report, in Reports folder open file ```report.html```.





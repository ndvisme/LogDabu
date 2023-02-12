# Integrations Loger

A brief description of what this project does and who it's for

## Deployment

To deploy this project run

```bash

```

## Salesforce Admin
1. Create Controller RecordType:
    (each intagraton must have his own unique RecordType!)
    ![Alt text](./Images/ReadMe/Admin/recordType.png "Create RecordType")
2. Create Controller
    - ![Alt text](./Images/ReadMe/Admin/ChooseRecordType.png "Choose Record Type")

    - ![Alt text](./Images/ReadMe/Admin/CreateController.png "Configure Controller")

3. Ask developer in insert needed code to start logging.


## Developer
1. Query/Create wanted 'Controller':
![Alt text](./Images/ReadMe/Dev/queryController.png "Query")

2. Call the 'Logger Wrapper' constructor.
    - Be sure to give it the apropriate:
        - HTTPRequest
        - HTTPResponse
        - 'Logger Controller'
![Alt text](./Images/ReadMe/Dev/LoggerWrapper.png "Constructor")

3. Call the 'create' function (this will insert the 'log' record to the DB).
![Alt text](./Images/ReadMe/Dev/createFunc.png "Insert function")
*** Settings ***
Documentation   Data entry robot which extract data from 
...             excel file and upload in the app
Library         RPA.Browser
Library         RPA.HTTP
Library         RPA.Excel.Files


*** Variables ***
${dataEntryButton}  //button[normalize-space()='Start']
${firstName}     //body[1]/app-root[1]/div[2]/app-rpa1[1]/div[1]/div[2]/form[1]/div[1]/div[1]/rpa1-field[1]/div[1]/input[1]
${lastName}      //body[1]/app-root[1]/div[2]/app-rpa1[1]/div[1]/div[2]/form[1]/div[1]/div[7]/rpa1-field[1]/div[1]/input[1]
${companyName}   //body[1]/app-root[1]/div[2]/app-rpa1[1]/div[1]/div[2]/form[1]/div[1]/div[5]/rpa1-field[1]/div[1]/input[1]
${email}   //body[1]/app-root[1]/div[2]/app-rpa1[1]/div[1]/div[2]/form[1]/div[1]/div[4]/rpa1-field[1]/div[1]/input[1]
${designation}  //body[1]/app-root[1]/div[2]/app-rpa1[1]/div[1]/div[2]/form[1]/div[1]/div[6]/rpa1-field[1]/div[1]/input[1]
${phoneNumber}  //body[1]/app-root[1]/div[2]/app-rpa1[1]/div[1]/div[2]/form[1]/div[1]/div[2]/rpa1-field[1]/div[1]/input[1]
${address}  //body[1]/app-root[1]/div[2]/app-rpa1[1]/div[1]/div[2]/form[1]/div[1]/div[3]/rpa1-field[1]/div[1]/input[1]
${submit}   //input[@value='Submit']


*** Keywords *** 
 Open the app
    Open Available Browser    http://rpachallenge.com/
    Maximize Browser Window

*** Keywords ***
 Download the excel file
   Download    http://rpachallenge.com/assets/downloadFiles/challenge.xlsx  ${CURDIR}${/}employee.xlsx  overwrite=True 


*** Keywords ***
Enter one employee information
    [Arguments]  ${data}
    Input Text    ${firstName}      ${data}[First Name]
    Input Text    ${lastName}       ${data}[Last Name]
    Input Text    ${companyName}    ${data}[Company Name]
    Input Text    ${email}          ${data}[Email]
    Input Text    ${designation}    ${data}[Role in Company]
    Input Text    ${phoneNumber}    ${data}[Phone Number]
    Input Text    ${address}        ${data}[Address]
    Click Button    ${submit}

*** Keywords ***
Fill the employees information
   Open Workbook  ${CURDIR}${/}employee.xlsx
   ${employee}=  Read Worksheet As Table  Sheet1  header=True
   Close Workbook
   Click Button    ${dataEntryButton} 
   FOR  ${data}  IN  @{employee}
     Enter one employee information  ${data}
   END


*** Keywords ***
Close the browser
  Close Browser

*** Tasks ***
 Download excel file
    Open the app
    Download the excel file
    Fill the employees information


# Description
"The Local Stage" is a conceptual theatre company idea created by my groupmate and I for CS340 course project. The idea was designed to demonstrate **datebase functionality** with meaningful sample data while keeping the project manageable. The database includes **dive tables:** four entities and one intersection table, with **four relationships**, including **one many-to-many (M:N) relationship** using an intersection table. 

The web application demonstrates full **CRUD operations** using MySQL and PL/SQL:

- Select / Read / Display - all tables
- Create / Insert - one table, using PL/SQL
- Update - one table, using PL/SQL
- Update M:N relationship - one M:N relationship
- Delete - one table, using PL/SQL
- Delete M:N relationship - one M:N relationship
- Reset Database - using PL/SQL

# Technologies Used 
- MySQL
- RDBMS concepts (Schema, ERD, Relationships)
- Node.js / Express
- HTML, CSS, JavaScript
- PL/SQL for stored procedures

# Database Design 
**Entity Relationship Diagram (ERD)**   
![ERD Diagram](https://github.com/PersimMonMon/CS340-RDBMS-MySQL-CRUD-WebApp/blob/main/images/ERD.PNG)

**Database Schema**      
![Database Schema](https://github.com/PersimMonMon/CS340-RDBMS-MySQL-CRUD-WebApp/blob/main/images/schema.PNG)

  
  
# Sample Data   
    
**Directors**
|directorID|firstName|lastName|email                                   |
|----------|---------|--------|----------------------------------------|
|1         |Mary     |Smith   |marysmith@localstage.com                |
|2         |Daniel   |Craig   |notthatdanielcraig@localstage.com       |
|3         |John     |Doe     |johndoe@localstage.com                  |
   
   
**Shows** 
|showID|showDate  |directorID|
|------|-----------|----------|
|1     |1/15/2025  |1         |
|2     |2/20/2025  |2         |
|3     |3/18/2025  |1         |
|4     |4/10/2025  |1         |
   
   
**Actors** 
|actorID|firstName|lastName|email                     |
|-------|---------|--------|--------------------------|
|1      |Chris    |Lowe    |chrislowe@gmail.com       |
|2      |Steve    |Rogers  |thecap@aol.com            |
|3      |Beau     |Regard  |beauregard1234@live.com   |
|4      |May      |Bee     |maybee@gmail.com          |
|5      |Sue      |Mary    |MarySue@hotmail.com       |
   
    
**Skits** 
|skitID|title               |description                                                 |showID|authorID|
|------|--------------------|------------------------------------------------------------|------|--------|
|1     |Morning Monster     |A comedy about not having my morning coffee                 |1     |1       |
|2     |Love at First Swipe |A romance about dating apps                                 |1     |1       |
|3     |Office Apocalypse   |A skit about being stuck in the office even after the apocalypse|2 |2       |
|4     |Line!               |A skit about actors forgetting their lines                  |3     |3       |
|5     |Waxing Poetic       |NULL                                                        |4     |5       |
   
   
**SkitActors** 
|skitID|actorID|role                        |
|------|-------|----------------------------|
|1     |1      |NULL                        |
|1     |2      |Angry Coffee Hulk           |
|2     |2      |male lead                   |
|2     |3      |robot                       |
|3     |1      |dating app office worker    |
|3     |2      |intern                      |
|3     |4      |manager                     |
|4     |1      |actor                       |
|4     |3      |forgetful actor             |
|5     |2      |solo performance            |





# Citations for Group 72 Final Project CS340 Online
Project on fictional business "The Local Stage"

app.js citations
//Citation for the following file, all except the .post and reset functions
//Date: 11/02/2025
//Copied from Exploration - Web Application Technology Module 6 CS340
//https://canvas.oregonstate.edu/courses/2017561/pages/exploration-web-application-technology-2?module_item_id=25645131

// Format the date line 74
// Citation for use of AI Tools:
// Date: 11/02/2025
// Prompts used: in this how do I format the date so it's just day month year?    
//ChatGPT

main.hbs citation
{{!Citation for the following file except for the reset button
Date: 11/02/2025
Copied from Exploration - Web Application Technology Module 6 CS340
https://canvas.oregonstate.edu/courses/2017561/pages/exploration-web-application-technology-2?module_item_id=25645131}}

directors.hbs citation
{{!Citation for the following file
Date: 11/02/2025
Adapted from Exploration - Web Application Technology Module 6 CS340
https://canvas.oregonstate.edu/courses/2017561/pages/exploration-web-application-technology-2?module_item_id=25645131}}

home.hbs citation
{{!Citation for the following file
Date: 11/02/2025
Copied from Exploration - Web Application Technology Module 6 CS340
https://canvas.oregonstate.edu/courses/2017561/pages/exploration-web-application-technology-2?module_item_id=25645131}}

shows.hbs citation
{{!Citation for the following file
Date: 11/02/2025
Copied from Exploration - Web Application Technology Module 6 CS340
https://canvas.oregonstate.edu/courses/2017561/pages/exploration-web-application-technology-2?module_item_id=25645131}}

actors.hbs citation
{{!Citation for the following file
Date: 11/02/2025
Adapted from Exploration - Web Application Technology Module 6 CS340
https://canvas.oregonstate.edu/courses/2017561/pages/exploration-web-application-technology-2?module_item_id=25645131}}

skits.hbs citation
{{!Citation for the following file
Date: 11/02/2025
Adapted from Exploration - Web Application Technology Module 6 CS340
https://canvas.oregonstate.edu/courses/2017561/pages/exploration-web-application-technology-2?module_item_id=25645131}}

skit-actors.hbs citation
{{!Citation for the following file
Date: 11/02/2025
Based on Exploration - Web Application Technology Module 6 CS340
https://canvas.oregonstate.edu/courses/2017561/pages/exploration-web-application-technology-2?module_item_id=25645131}}

 Scroll to form line 155
// Citation for use of AI Tools:
// Date: 12/05/2025
// Prompts used: How can I make this button scroll to the update form when clicked in this code?
//ChatGPT

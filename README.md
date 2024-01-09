## CreatureDB
A database for referencing information of creatures in Dungeons and Dragons 5th edition.

I designed this database to be used in a future project that can be used by Dungeon Masters ( the person running the game ) to improve their ability to run an encounter.

### Requirements to Run and Test the Database
Microsoft SQL Server Managment Studio 18 ( preferred )

### Instructions
1. Run the script - CreatureDB.sql
   
   This will create the database as well as insert test data.
2. Run the test queries after selecting the CreatureDB - CreatureDB_SelectQueries.sql

   This will run 7 test queries against the database.  The file also includes comments describing what each query represents as a test case.


### Database Diagram

A full resolution image of the database is contained in this repository - ScriptingNotesCreatureFinal.jpg

Notes made to the diagram were done in this fashion as the diagram was constructed in free software that would not allow saving a file with more than 10 tables.
After its initial creation I eliminated what I found to be a redundant table and drew an arrow indicating the new connection and foreign key.

![ScriptingNotesCreatureFinal](https://github.com/JohnnyBee86/CreatureDB/assets/130700641/8886a467-d43e-457b-8bef-d38328b5c561)

# Free Code Camp: Relational Database Project 2

## World Cup Database

The aim of this project was to write Bash scripts to

1. Create a World Cup PostgreSQL database from a csv file of World Cup game information.
2. Query the generated database for desired information.

### Project Requirements:

- **User Story #1:** You should create a database named `worldcup`

- **User Story #2:** You should **connect to your worldcup database** and then create `teams` and `games` tables

- **User Story #3:** Your `teams` table should have a `team_id` column that is a type of `SERIAL` and is the primary key, and a `name` column that has to be `UNIQUE`

- **User Story #4:** Your `games` table should have a `game_id` column that is a type of `SERIAL` and is the primary key, a `year` column of type `INT`, and a `round` column of type `VARCHAR`

- **User Story #5:** Your `games` table should have `winner_id` and `opponent_id` foreign key columns that each reference `team_id` from the `teams` table

- **User Story #6:** Your `games` table should have `winner_goals` and `opponent_goals` columns that are type `INT`

- **User Story #7:** All of your columns should have the `NOT NULL` constraint

- **User Story #8:** Your two script (`.sh`) files should have executable permissions. Other tests involving these two files will fail until permissions are correct. When these permissions are enabled, the tests will take significantly longer to run

- **User Story #9:** When you run your `insert_data.sh` script, it should add each unique team to the `teams` table. There should be 24 rows

- **User Story #10:** When you run your `insert_data.sh` script, it should insert a row for each line in the `games.csv` file (other than the top line of the file). There should be 32 rows. Each row should have every column filled in with the appropriate info. Make sure to add the correct ID's from the teams table (you cannot hard-code the values)

- **User Story #11:** You should correctly complete the queries in the `queries.sh` file. Fill in each empty `echo` command to get the output of what is suggested with the command above it. Only use a single line like the first query. The output should match what is in the `expected_output.txt` file

### Project Writeup:

The second Free Code Camp: Relational Database project are two small bash scripts:

- `insert_data.sh` can be run to generate a PostgreSQL database of world cup game information.
- `queries.sh` can then be run against the created database to output answers to the required questions regarding the world cup.

### Usage

The database can be interacted with using `psql` in linux. First start up a PostgreSQL server using:

`$sudo service postgresql start`

The world cup database can be loaded directly from the `worldcup.sql` file using:

`$psql --dbname=postgres < worldcup.sql`

Log into the database using:

`$psql --dbname=postgres`

To use the insert_data.sh script, first empty all tables in the database, using the postgres prompt:

```
$\c worldcup;
$TRUNCATE games, teams;
```

Now in the bash terminal, the script can be run to insert the data from csv file into the database. (Note that you will have to change the `--username=freecodecamp` option on line 7 to your linux username or remove this entirely):

`$./insert_data.sh`

Similarly in the bash terminal, the script to query the database can be run (again updating the `--username` option inside the script appropriately):

`$./queries.sh`

Save a dump of the database using:

`$pg_dump -cC --inserts worldcup > worldcup.sql`

Instructions for building the project can be found at https://www.freecodecamp.org/learn/relational-database/build-a-world-cup-database-project/build-a-world-cup-database

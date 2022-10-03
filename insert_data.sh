#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Empty Tables Before Trying to Fill them
echo "$($PSQL "TRUNCATE teams, games;")"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # Skip column title row
  if [[ $YEAR != 'year' ]]
  then
    TEAM_IDS=('' '')
    TEAM_NAMES=("$WINNER" "$OPPONENT")

    # Get IDS for both teams
    for i in ${!TEAM_NAMES[@]};
    do
      TEAM_IDS[$i]="$($PSQL "SELECT team_id FROM teams WHERE name='${TEAM_NAMES[$i]}';")"

      # If team not in DB, add team to DB
      if [[ -z ${TEAM_IDS[$i]} ]]
      then
        TEAM_INSERT_RESULT="$($PSQL "INSERT INTO teams(name) VALUES('${TEAM_NAMES[$i]}');")"

        if [[ $TEAM_INSERT_RESULT = 'INSERT 0 1' ]]
        then
          echo INSERTED INTO TEAMS ${TEAM_NAMES[$i]}
        fi

        # Get inserted Team ID
        TEAM_IDS[$i]="$($PSQL "SELECT team_id FROM teams WHERE name='${TEAM_NAMES[$i]}';")"
      fi
    done

    # Now insert game into games table:
    GAME_INSERT_RESULT="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', ${TEAM_IDS[0]}, ${TEAM_IDS[1]}, $WINNER_GOALS, $OPPONENT_GOALS);")"

    if [[ $GAME_INSERT_RESULT = 'INSERT 0 1' ]]
    then
      echo INSERTED INTO GAMES $YEAR, $ROUND, $WINNER:$WINNER_GOALS - $OPPONENT:$OPPONENT_GOALS
    fi
  fi
done

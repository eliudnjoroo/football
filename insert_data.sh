#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
# Do not change code above this line. Use the PSQL variable above to query your database.
 echo -e "\n$($PSQL "truncate table teams, games")\n"
 cat games.csv | 
 while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS 
 do
  if [[ $WINNER != winner && $OPPONENT != opponent ]]
  then
    SUCCED="$($PSQL "insert into teams (name) values('$WINNER')";)"
    SUCCED2="$($PSQL "insert into teams (name) values('$OPPONENT')";)" 
    echo $SUCCED $SUCCED2
  fi
 done

cat games.csv | 
 while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS 
 do
  if [[ $WINNER != winner && $OPPONENT != opponent ]]
  then
    OPP_ID="$($PSQL "SELECT team_id from teams where name='$OPPONENT'")"
    WIN_ID="$($PSQL "SELECT team_id from teams where name='$WINNER'")"
    SUCCEDDED="$($PSQL "insert into games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
                                 values('$YEAR', '$ROUND', '$WIN_ID', '$OPP_ID', '$W_GOALS', '$O_GOALS')";)"
    echo $SUCCEDDED
  fi
 done

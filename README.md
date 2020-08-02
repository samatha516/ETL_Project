# ETL_Project

In our ETL_Project, we intent to use the NFL game and score information from Kaggle (see link below) to create a database with key Superbowl statistics – including games, stadium, winning/losing teams, mvp player, key highlights, etc.  We will use Pandas to extract and clean up the data, load the data into SQL databases, and use SQL to extract information from different datasets or tables.  

# Data Extract:
- Player Position: http://stats.washingtonpost.com/fb/glossary.asp   
- Superbowl Winner teams with scores: https://www.topendsports.com/events/super-bowl/winners-list.htm
- Most Valuable Players: http://www.espn.com/nfl/superbowl/history/mvps
- Superbowl Winning Quarterbacks: https://en.wikipedia.org/wiki/List_of_Super_Bowl_starting_quarterbacks
- Downloaded scores, teams, and stadiums data as csv files https://www.kaggle.com/tobycrabtree/nfl-scores-and-betting-data

# Data Transformation:
- Cleaning up data: Removing special character using regular expressions 
- Dropped columns that are not needed and renamed the columns for consistency
- Stripping data into multiple columns based on coditions
# Data Load:
- Loaded the data from pandas dataframes to Postgres Database.
- Created tables by joining the tables and converted them to pandas dataframe

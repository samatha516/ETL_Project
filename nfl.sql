-- Create Two Tables
CREATE TABLE teams (
  team_name char(60) PRIMARY KEY,
  team_name_short char(40),
  team_id char(3),
  team_conference char(3),
  team_division	char(15),
  team_conference_pre2002 char(3),
  team_division_pre2002 char(15)
);

CREATE TABLE stadiums (
  stadium_name char(60) PRIMARY KEY,
  city char(60),
  state char(60)
);

create table scores(
	id int primary key,
	schedule_season int,
	schedule_week char(20),
	schedule_playoff char(6),
	team_home char(60),
	score_home int,
	score_away int,
	team_away  char(60),
	stadium  char(60),
	winner char(60)
);

create table player_position(
	abbreviation char(5) primary key,
	position char(20)
);

create table sb_winners(
	sb_no char(10) primary key,
	year char(4),
	winner_team char(60), 
	winner_score int,
	loser_team  char(60), 
	loser_score int
);

create table sb_quarterbacks(
	sb_no char(10) primary key,
	year char(4),
	winner_team	char(60),
	loser_team	char(60), 
	winner_qb char(60),
	loser_qb char(60)
);

create table most_valuable_player(
	sb_no char(10) primary key,
	player char(60),
	position_abbr char(5),
	team char(60),
	highlights text
);

create table mvp_position as(
select mvp.sb_no, mvp.player, mvp.position_abbr, pp.position, mvp.team, mvp.highlights
from most_valuable_player mvp,
     player_position pp
where trim(mvp.position_abbr) = trim(pp.abbreviation));
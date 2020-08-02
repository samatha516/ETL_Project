-- drop table mvp_position;
-- create table to add player position to most_valuable_player
create table mvp_position as(
select trim(mvp.team) as team, mvp.sb_no, trim(mvp.player) as player, mvp.position_abbr, pp.position, mvp.highlights
  from most_valuable_player mvp,
       player_position pp
 where trim(mvp.position_abbr) = trim(pp.abbreviation)
  );
  
select * from mvp_position;

-- drop table sb_scores;
-- create table to add scores to superbowl winners
create table sb_scores as (
select sb.sb_no, sb.year, qb.winner_conf, trim(qb.winner_team) as winner_team, 
       sb.winner_score, trim(qb.winner_qb) as winner_qb, qb.also_mvp,
       qb.loser_conf, trim(qb.loser_team) as loser_team, sb.loser_score, trim(qb.loser_qb) as loser_qb, sb.city
  from sb_winners sb, sb_quarterbacks qb
 where trim(sb.sb_no) = trim(qb.sb_no))
   ;

select * from sb_scores;

-- create table to add winner division 
create table winner_div as(
select qb.sb_no, trim(qb.winner_team) as winner_team,  trim(t.team_division) as winner_div
 from sb_quarterbacks qb, teams t
where lower(trim(qb.winner_team)) = lower(trim(t.team_name))); 

-- create table to add loser division
create table loser_div as(
select qb.sb_no, trim(qb.loser_team) as loser_team, trim(t.team_division) as loser_div
from sb_quarterbacks qb, teams t
  where lower(trim(qb.loser_team)) = lower(trim(t.team_name)));

-- combine scores and divisions
drop table sb_divisions;
create table sb_divisions as(
select sb.sb_no, sb.year, qb.winner_conf, wd.winner_div, trim(qb.winner_team) as winner_team, 
       sb.winner_score, trim(qb.winner_qb) as winner_qb, qb.also_mvp, trim(sb.city) city,
       qb.loser_conf, ld.loser_div, trim(qb.loser_team) as loser_team, sb.loser_score
  from sb_winners sb, sb_quarterbacks qb, winner_div as wd, loser_div as ld
 where trim(sb.sb_no) = trim(qb.sb_no)
   and trim(qb.sb_no) = trim(wd.sb_no)
   and trim(qb.sb_no) = trim(ld.sb_no)
   and lower(trim(qb.winner_team)) = lower(trim(wd.winner_team))
   and lower(trim(qb.loser_team)) = lower(trim(ld.loser_team)));

select * from sb_divistions;

select sb.sb_no, sb.year, qb.winner_conf, wd.winner_div, trim(qb.winner_team) as winner_team, 
       sb.winner_score, trim(qb.winner_qb) as winner_qb, qb.also_mvp, trim(s.stadium) as stadium, 
	   trim(sb.city) as city,
       qb.loser_conf, ld.loser_div, trim(qb.loser_team) as loser_team, sb.loser_score,  s.stadium
  from sb_winners sb, sb_quarterbacks qb, winner_div as wd, loser_div as ld, scores as s
  where trim(sb.sb_no) = trim(qb.sb_no)
   and trim(qb.sb_no) = trim(wd.sb_no)
   and trim(qb.sb_no) = trim(ld.sb_no)
   and lower(trim(qb.winner_team)) = lower(trim(wd.winner_team))
   and lower(trim(qb.loser_team)) = lower(trim(ld.loser_team))
   and (sb.year - 1) = s.schedule_season
   and lower(trim(s.schedule_week)) = 'superbowl'
   ;
update scores
   set stadium = 'Mercedes-Benz Superdome'
 where stadium = 'Mercedes-Benz Stadium';

 -- drop table superbowl;
create table superbowl as(  
select sb.sb_no, sb.year, qb.winner_conf, wd.winner_div, trim(qb.winner_team) as winner_team, 
       sb.winner_score, trim(qb.winner_qb) as winner_qb, qb.also_mvp, trim(s.stadium) as stadium, 
	   trim(sb.city) as city, trim(st.state) as state,
       qb.loser_conf, ld.loser_div, trim(qb.loser_team) as loser_team, sb.loser_score
  from sb_winners sb, sb_quarterbacks qb, winner_div as wd, loser_div as ld, scores as s, stadiums as st
 where trim(sb.sb_no) = trim(qb.sb_no)
   and trim(qb.sb_no) = trim(wd.sb_no)
   and trim(qb.sb_no) = trim(ld.sb_no)
   and lower(trim(qb.winner_team)) = lower(trim(wd.winner_team))
   and lower(trim(qb.loser_team)) = lower(trim(ld.loser_team))
   and (sb.year - 1) = s.schedule_season
   and lower(trim(s.schedule_week)) = 'superbowl'
   and lower(trim(s.stadium)) = lower(trim(st.stadium_name)));
   


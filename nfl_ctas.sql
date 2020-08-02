-- drop table mvp_position;

create table mvp_position as(
select trim(mvp.team) as team, mvp.sb_no, trim(mvp.player) as player, mvp.position_abbr, pp.position, mvp.highlights
  from most_valuable_player mvp,
       player_position pp
 where trim(mvp.position_abbr) = trim(pp.abbreviation)
  );
  
select * from mvp_position;

-- drop table sb_scores;
create table sb_scores as (
select sb.sb_no, sb.year, qb.winner_conf, trim(qb.winner_team) as winner_team, 
       sb.winner_score, trim(qb.winner_qb) as winner_qb, qb.also_mvp,
       qb.loser_conf, trim(qb.loser_team) as loser_team, sb.loser_score, trim(qb.loser_qb) as loser_qb
  from sb_winners sb, sb_quarterbacks qb
 where trim(sb.sb_no) = trim(qb.sb_no))
   ;

select * from sb_scores;
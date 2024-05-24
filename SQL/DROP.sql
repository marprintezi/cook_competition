--drop indexes




--drop views




--drop tables
drop table recipe;
drop table cuisine;
drop table meal_type;
drop table recipe_meal_type;
drop table label;
drop table recipe_label;
drop table equipment;
drop table recipe_equipment;
drop table step;
drop table recipe_step;
drop table ingredient;
drop table recipe_ingredinet;
drop table food_group;
drop table unit;
drop table topic;
drop table topic_recipe;
drop table cook;
drop table grade;
drop table cook_specialisation;
drop table episode;
drop table episode_cook;
drop table episode_judge;
drop table score;

--drop procedures
drop procedure InsertEpisodeCooks;
drop procedure InsertEpisodeJudges;
drop procedure Create_Score;
drop procedure Get_Episode_Winner;
drop procedure Create_Cook_Random_Scores;

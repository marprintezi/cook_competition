--drop indexes
DROP INDEX idx_cuisine ON recipe;
DROP INDEX idx_unit ON recipe;
DROP INDEX idx_recipe_label ON recipe_label;
DROP INDEX idx_recipe_equipment ON recipe_equipment;
DROP INDEX idx_recipe_step ON recipe_step;
DROP INDEX idx_fg ON ingredient;
DROP INDEX idx_recipe_ingredient ON recipe_ingredient;
DROP INDEX idx_topic_recipe ON topic_recipe;
DROP INDEX idx_grade ON cook;
DROP INDEX idx_cook_specialisation ON cook_specialisation;
DROP INDEX idx_episode_cook ON episode_cook;
DROP INDEX idx_episode_judge ON episode_judge;
DROP INDEX idx_score ON score;
DROP INDEX idx_recipe_equipment_recipe ON recipe_equipment;
DROP INDEX idx_episode_date ON episode;
DROP INDEX idx_episode_cook_episode ON episode_cook;
DROP INDEX idx_judge_cook ON score;
DROP INDEX idx_difficulty ON recipe;




--drop views
DROP VIEW IF EXISTS average_scores_combined
DROP VIEW IF EXISTS YoungCooksRecipeCount;
DROP VIEW IF EXISTS 3topFood_groups;
DROP VIEW IF EXISTS CooksWithLessParticipation;
DROP VIEW IF EXISTS EpisodeWithMostEquipment;
DROP VIEW IF EXISTS AvgCarbohydratesPerYear;
DROP VIEW IF EXISTS Top5JudgeCookScores;
DROP VIEW IF EXISTS MaxRecipeDifficultyPerYear;
DROP VIEW IF EXISTS EpisodeExperience;
DROP VIEW IF EXISTS MostAppearedTopic;
DROP VIEW IF EXISTS NeverAppearedFood_Group;



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

--DDL
--Notes:
--must first create table that contains referenced value and then the table with the foreign key
--dropping tables must be in correct order: bottom up


drop database if exists cook_competition;
create database cook_competition;
use cook_competition;

CREATE TABLE cuisine (
           cuisine_id INT NOT NULL AUTO_INCREMENT,
           name VARCHAR(100) NOT NULL,
           PRIMARY KEY (cuisine_id)
);

CREATE TABLE unit (
            unit_id INT NOT NULL AUTO_INCREMENT,
            name VARCHAR(100) NOT NULL,
            PRIMARY KEY (unit_id)
);

CREATE TABLE  recipe (
              recipe_id INT NOT NULL AUTO_INCREMENT,
              name VARCHAR(100) NOT NULL,
              difficulty VARCHAR(100) NOT NULL,
              description TEXT,
              tips TEXT,
              is_cooking boolean default TRUE,
              portions INT NOT NULL ,
              basic_ingredient VARCHAR(100) NOT NULL,
              cuisine_id INT NOT NULL ,
              unit_id INT NOT NULL ,
              PRIMARY KEY (recipe_id),
             constraint recipe_ibfk_1 foreign key (cuisine_id) references cuisine(cuisine_id) on delete restrict on update cascade,
            constraint recipe_ibfk_2 foreign key (unit_id) references unit(unit_id) on delete cascade on update cascade

);



CREATE TABLE meal_type (
             meal_type_id INT NOT NULL AUTO_INCREMENT,
             name VARCHAR(100) NOT NULL,
             PRIMARY KEY (meal_type_id)
);

CREATE TABLE recipe_meal_type (
                recipe_id INT NOT NULL ,
                meal_type_id INT NOT NULL ,
                PRIMARY KEY (recipe_id,meal_type_id),
                constraint recipe_meal_type_ibfk_1 foreign key (recipe_id) references recipe (recipe_id) on delete cascade on update cascade,
                constraint recipe_meal_type_ibfk_2 foreign key (meal_type_id) references meal_type (meal_type_id) on delete cascade on update cascade
);

CREATE TABLE label (
           label_id INT NOT NULL AUTO_INCREMENT,
           name VARCHAR(100) NOT NULL,
           PRIMARY KEY (label_id)
);

CREATE TABLE recipe_label (
           recipe_id INT NOT NULL ,
           label_id INT NOT NULL ,
           PRIMARY KEY (recipe_id,label_id),
           constraint recipe_label_ibfk_1 foreign key (recipe_id) references recipe (recipe_id) on delete cascade on update cascade,
           constraint recipee_label_ibfk_2 foreign key (label_id) references label (label_id) on delete cascade on update cascade
);

CREATE TABLE equipment (
             equipment_id INT NOT NULL AUTO_INCREMENT,
             name VARCHAR(100) NOT NULL,
             description TEXT,
             PRIMARY KEY (equipment_id)
);

CREATE TABLE recipe_equipment (
            recipe_id INT NOT NULL ,
            equipment_id INT NOT NULL ,
            PRIMARY KEY (recipe_id,equipment_id),
            constraint recipe_equipment_ibfk_1 foreign key (recipe_id) references recipe (recipe_id) on delete cascade on update cascade,
            constraint recipe_equipment_ibfk_2 foreign key (equipment_id) references equipment (equipment_id) on delete cascade on update cascade
);


CREATE TABLE step (
            step_id INT NOT NULL AUTO_INCREMENT,
            description VARCHAR(200),
            time INT NOT NULL,
            PRIMARY KEY (step_id)
);

UPDATE step
SET time = SEC_TO_TIME(FLOOR(RAND() * 3600));


CREATE TABLE recipe_step (
               is_prep BOOLEAN DEFAULT FALSE,
               recipe_step_order INT NOT NULL,
               recipe_id INT NOT NULL ,
               step_id INT NOT NULL ,
               PRIMARY KEY (recipe_id,step_id),
               constraint recipe_step_ibfk_1 foreign key (recipe_id) references recipe (recipe_id) on delete cascade on update cascade,
               constraint recipe_step_ibfk_2 foreign key (step_id) references step (step_id) on delete cascade on update cascade
);

CREATE TABLE food_group (
              fg_id INT NOT NULL AUTO_INCREMENT,
              name VARCHAR(100) NOT NULL,
              description VARCHAR(300),
              PRIMARY KEY (fg_id)
);

CREATE TABLE ingredient (
              ingredient_id INT NOT NULL AUTO_INCREMENT,
              name VARCHAR(100) NOT NULL,
              caloriesper100gr DECIMAL(6,2) NOT NULL ,
              fg_id INT NOT NULL ,
              PRIMARY KEY (ingredient_id),
              constraint ingredient_ibfk_1 foreign key (fg_id) references food_group (fg_id) on delete cascade on update cascade
);


CREATE TABLE recipe_ingredient (
                 quantity DECIMAL(6,2) NOT NULL ,
                 carbon_hydrates DECIMAL(6,2) NOT NULL,
                 protein DECIMAL(6,2) NOT NULL ,
                 fat DECIMAL(6,2) NOT NULL ,
                 recipe_id INT NOT NULL ,
                 ingredient_id INT NOT NULL ,
                 PRIMARY KEY (recipe_id,ingredient_id),
                 constraint recipe_ingredient_ibfk_1 foreign key (recipe_id) references recipe (recipe_id) on delete cascade on update cascade,
                 constraint recipe_ingredient_ibfk_2 foreign key (ingredient_id) references ingredient (ingredient_id) on delete cascade on update cascade
                );




CREATE TABLE topic (
              topic_id INT NOT NULL AUTO_INCREMENT,
              name VARCHAR(100) NOT NULL,
              description VARCHAR(300),
              PRIMARY KEY (topic_id)
);

CREATE TABLE topic_recipe (
             recipe_id INT NOT NULL ,
             topic_id INT NOT NULL ,
             PRIMARY KEY (recipe_id,topic_id),
             constraint topic_recipe_ibfk_1 foreign key (recipe_id) references recipe (recipe_id) on delete cascade on update cascade,
             constraint topic_recipe_ibfk_2 foreign key (topic_id) references topic (topic_id) on delete cascade on update cascade
);

CREATE TABLE grade (
             grade_id INT NOT NULL AUTO_INCREMENT,
             name VARCHAR(100) NOT NULL,
             PRIMARY KEY (grade_id)
);

CREATE TABLE cook (
                cook_id INT NOT NULL AUTO_INCREMENT,
                first_name VARCHAR(100) NOT NULL,
                last_name VARCHAR(100) NOT NULL,
                phone_number VARCHAR(15),
                birth_date DATE NOT NULL ,
                age INT NOT NULL,
                grade_id INT NOT NULL ,
                PRIMARY KEY (cook_id),
                constraint cook_ibfk_1 foreign key (grade_id) references grade (grade_id) on delete cascade on update cascade
);

update cook   set age=DATEDIFF(CURRENT_DATE(),birth_date)/365;



CREATE TABLE cook_specialisation (
               yrs_of_exp INT,
               cuisine_id INT NOT NULL ,
               cook_id INT NOT NULL ,
               PRIMARY KEY (cuisine_id,cook_id),
               constraint cook_specialisation_ibfk_1 foreign key (cuisine_id) references cuisine (cuisine_id) on delete cascade on update cascade,
               constraint cook_specialisation_ibfk_2 foreign key (cook_id) references cook (cook_id) on delete cascade on update cascade
);

CREATE TABLE episode (
               episode_id INT NOT NULL AUTO_INCREMENT,
               calendar_year INT NOT NULL,
               number INT NOT NULL ,
               PRIMARY KEY (episode_id)
);

CREATE TABLE episode_cook (
             episode_id INT NOT NULL ,
             cook_id INT NOT NULL ,
             recipe_id INT NOT NULL ,
             cuisine_id INT NOT NULL,
             PRIMARY KEY (episode_id,cook_id,recipe_id,cuisine_id),
             constraint episode_cook_ibfk_1 foreign key (episode_id) references episode (episode_id) on delete cascade on update cascade,
             constraint episode_cook_ibfk_2 foreign key (cook_id) references cook (cook_id) on delete cascade on update cascade,
             constraint episode_cook_ibfk_3 foreign key (recipe_id) references recipe(recipe_id) on delete cascade on update cascade,
             constraint episode_cook_ibfk_4 foreign key (cuisine_id) references cuisine(cuisine_id) on delete cascade on update cascade
);

CREATE TABLE episode_judge (
             episode_id INT NOT NULL ,
             judge_id INT NOT NULL ,
             PRIMARY KEY (episode_id,judge_id),
             constraint episode_judge_ibfk_1 foreign key (episode_id) references episode (episode_id) on delete cascade on update cascade,
             constraint episode_judge_ibfk_2 foreign key (judge_id) references cook (cook_id) on delete cascade on update cascade
);
            


CREATE TABLE score (
             score_id INT NOT NULL AUTO_INCREMENT,
             points INT,
             episode_id INT NOT NULL ,
             cook_id INT NOT NULL,
             judge_id INT NOT NULL ,
             PRIMARY KEY (score_id),
             constraint score_ibfk_1 foreign key (episode_id) references episode (episode_id) on delete cascade on update cascade,
             constraint score_ibfk_2 foreign key (cook_id) references cook(cook_id) on delete cascade on update cascade,
             constraint score_ibfk_3 foreign key (judge_id) references cook(cook_id) on delete cascade on update cascade
             );

--
--
--PROCEDURES
--
--


DELIMETER //

CREATE PROCEDURE InsertEpisodeCooks(episode_number int, cal_year int)
BEGIN
    if (not exists(Select * from episode where calendar_year=cal_year and number = episode_number)) then
        signal SQLSTATE '45000'
        set message_text = 'There is no such episode - year combination';
    end if;

    if (exists(select * from episode_cook ec inner join episode e on ec.episode_id = e.id
                        where number = episode_number and calendar_year=cal_year)) then
        signal SQLSTATE '45000'
            set message_text = 'There are already cooks selected for this episode';
    end if;

    insert into episode_cook (recipe_id, cook_id, episode_id)
    select  max(recipe_id) as random_recipe_id,
            cook_id as random_cook_id,
            (Select episode.id from episode where calendar_year=cal_year and number = episode_number) as episode_id
    from (select r.id as recipe_id,
                -- Select a random cooks with specialization in each recipe cuisine
                (select cook.id from cook k inner join cook_specialisation cs on k.id = cs.cook_id
                 where r.cuisine_id = cs.cuisine_id
                   -- Each cook should not participate in more than 3 consecutive episodes of the same year
                   and (episode_number < 4  or k.id not in (select cook_id from episode_cook
                                                            inner join episode on episode_cook.episode_id = episode.id
                                                            where number = episode_number-1 and calendar_year = cal_year)
                                            or k.id not in (select cook_id from episode_cook
                                                            inner join episode on episode_cook.episode_id = episode.id
                                                            where number = episode_number-2 and calendar_year = cal_year)
                                            or k.id not in (select cook_id from episode_cook
                                                            inner join episode on episode_cook.episode_id = episode.id
                                                            where number = episode_number-3 and calendar_year = cal_year)
                     )
                 order by rand() limit 1
                ) as cook_id
        -- select 10 random recipes from 10 random cuisines
         from  (select
                -- Select a random recipe for each selected cuisine
                (select recipe_id from recipe where cuisine_id = c1.id order by rand() limit 1) as recipe_id
                from cuisine c1
                -- Each cuisine should not be selected in e consecutive years
                where episode_number < 4
                or id not in (select cuisine_id from recipe
                              inner join episode_cook on recipe.id = episode_cook.recipe_id
                              inner join episode on episode_cook.episode_id = episode.id
                              where number = episode_number-1 and calendar_year = cal_year)
                or id not in (select cuisine_id from recipe
                              inner join episode_cook on recipe.id = episode_cook.recipe_id
                              inner join episode on episode_cook.episode_id = episode.id
                              where number = episode_number-2 and calendar_year = cal_year)
                or id not in (select cuisine_id from recipe
                              inner join episode_cook on recipe.id = episode_cook.recipe_id
                              inner join episode on episode_cook.episode_id = episode.id
                              where number = episode_number-3 and calendar_year = cal_year)
                order by rand() -- randomize the selection by ordering by a random number
               ) rcp inner join recipe r on r.id = rcp.recipe_id
        ) cr
        group by cr.cook_id
        limit 10;
END //

DELIMETER ;







DELIMITER //

CREATE PROCEDURE InsertEpisodeJudges(episode_number INT, cal_year INT)
BEGIN
    DECLARE episodeCount INT;

    -- Check if the episode exists
    SELECT COUNT(*) INTO episodeCount FROM episode WHERE calendar_year = cal_year AND number = episode_number;
    IF episodeCount = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There is no such episode - year combination';
    END IF;

    -- Check if judges are already selected for this episode
    SELECT COUNT(*) INTO episodeCount FROM episode_judge ej INNER JOIN episode e ON ej.episode_id = e.episode_id
    WHERE e.number = episode_number AND e.calendar_year = cal_year;
    IF episodeCount > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There are already judges selected for this episode';
    END IF;

    -- Insert judges for the episode
    INSERT INTO episode_judge (judge_id, episode_id)
    SELECT k.cook_id,
           (SELECT episode_id FROM episode WHERE calendar_year = cal_year AND number = episode_number) AS episode_id
    FROM cook k
    -- Each judge should not participate in more than 3 consecutive episodes of the same year
    WHERE (episode_number < 4 OR k.cook_id NOT IN (
             SELECT judge_id FROM episode_judge ej
             INNER JOIN episode ep ON ej.episode_id = ep.episode_id
             WHERE ep.number IN (episode_number - 1, episode_number - 2, episode_number - 3)
             AND ep.calendar_year = cal_year
         ))
         AND (k.cook_id NOT IN (
             SELECT judge_id FROM episode_judge ej
             INNER JOIN episode ep ON ej.episode_id = ep.episode_id
             WHERE ep.number = episode_number AND ep.calendar_year = cal_year
         ))
    ORDER BY RAND() LIMIT 3;
END //
DELIMITER ;



DELIMITER //

CREATE PROCEDURE Create_Score(IN cook_id INT, IN judge_id INT, IN episode_id INT, IN points INT)
BEGIN
    -- Check if the episode exists
    IF NOT EXISTS (SELECT 1 FROM episode e WHERE e.episode_id = episode_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'There is no such episode';
    END IF;

    -- Check if the cook exists and is assigned to the episode
    IF NOT EXISTS (SELECT 1 FROM episode_cook ec WHERE ec.cook_id = cook_id AND ec.episode_id = episode_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'There is no such cook in this episode';
    END IF;

    -- Check if the judge exists and is assigned to the episode
    IF NOT EXISTS (SELECT 1 FROM episode_judge ej WHERE ej.judge_id = judge_id AND ej.episode_id = episode_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'There is no such judge in this episode';
    END IF;

    -- Check if there is already a score for this cook by this judge for this episode
    IF EXISTS (
        SELECT 1 
        FROM score sc
        WHERE sc.episode_id = episode_id 
          AND sc.cook_id = cook_id 
          AND sc.judge_id = judge_id
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'There is already a score for this cook by this judge for this episode';
    END IF;

    -- Insert the score into the score table
    INSERT INTO score (points, episode_id, cook_id, judge_id)
    VALUES (points, episode_id, cook_id, judge_id);

END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE Get_Episode_Winner(IN episode_id_val INT)
BEGIN
    DECLARE max_points INT;
    DECLARE highest_grade INT;

    -- Step 1: Find the maximum points received by any cook in the given episode
    SELECT MAX(total_points) INTO max_points
    FROM (
        SELECT SUM(points) AS total_points
        FROM score
        WHERE episode_id = episode_id_val
        GROUP BY cook_id
    ) AS cook_totals;

    -- Step 2: Identify cooks with the maximum points
    CREATE TEMPORARY TABLE Temp_Max_Points_Cooks AS
    SELECT c.cook_id, c.first_name, c.last_name, c.grade_id, SUM(s.points) AS total_points
    FROM cook c
    JOIN score s ON c.cook_id = s.cook_id
    WHERE s.episode_id = episode_id_val
    GROUP BY c.cook_id;

    -- Step 3: If more than one cook has the maximum points, find the highest grade among them
    SELECT MAX(grade_id) INTO highest_grade
    FROM Temp_Max_Points_Cooks;

    -- Step 4: Identify cooks with the highest grade among those with maximum points
    CREATE TEMPORARY TABLE Temp_Highest_Grade_Cooks AS
    SELECT * 
    FROM Temp_Max_Points_Cooks
    WHERE total_points = max_points;

    -- Step 5: If more than one cook has the highest grade, select a random cook among them
    IF (SELECT COUNT(*) FROM Temp_Highest_Grade_Cooks) > 1 THEN
        SELECT cook_id, first_name, last_name, total_points, grade_id
        FROM Temp_Highest_Grade_Cooks
        ORDER BY RAND()
        LIMIT 1;
    ELSE
        -- If there is only one cook with the highest grade, that cook is the winner
        SELECT cook_id, first_name, last_name, total_points, grade_id
        FROM Temp_Highest_Grade_Cooks;
    END IF;

    -- Clean up temporary tables
    DROP TEMPORARY TABLE IF EXISTS Temp_Max_Points_Cooks;
    DROP TEMPORARY TABLE IF EXISTS Temp_Highest_Grade_Cooks;

END //

DELIMITER ;


DELIMITER //
CREATE PROCEDURE Create_Cook_Random_Scores()
BEGIN
    INSERT INTO score (points, episode_id, cook_id, judge_id)
    SELECT FLOOR(RAND() * 5) + 1, ec.episode_id, ec.cook_id, ej.judge_id
    FROM episode_cook ec
    INNER JOIN episode_judge ej ON ec.episode_id = ej.episode_id;
END //

DELIMITER ;



--
--
--VIEWS
--
--


--3.1
CREATE VIEW average_scores_combined AS
SELECT 
    'Cook' AS entity_type,
    c.first_name,
    c.last_name,
    AVG(s.points) AS average_score
FROM 
    cook c
JOIN 
    score s ON c.cook_id = s.cook_id
GROUP BY 
    c.cook_id, c.first_name, c.last_name

UNION ALL

SELECT 
    'Cuisine' AS entity_type,
    c.name AS entity_name,
    NULL AS last_name,
    AVG(s.points) AS average_score
FROM 
    score s
JOIN 
    episode_cook ec ON s.episode_id = ec.episode_id AND s.cook_id = ec.cook_id
JOIN 
    recipe r ON ec.recipe_id = r.recipe_id
JOIN 
    cuisine c ON r.cuisine_id = c.cuisine_id
GROUP BY 
    c.name
ORDER BY 
    average_score DESC;

SELECT * FROM average_scores_combined;



--3.3
CREATE VIEW YoungCooksRecipeCount AS
SELECT 
    c.cook_id,
    c.first_name,
    c.last_name,
    c.birth_date,
    COUNT(r.recipe_id) AS total_recipes
FROM 
    cook c
JOIN 
    episode_cook ec ON c.cook_id = ec.cook_id
JOIN 
    recipe r ON ec.recipe_id = r.recipe_id
WHERE 
    TIMESTAMPDIFF(YEAR, c.birth_date, CURDATE()) < 30
GROUP BY 
    c.cook_id
ORDER BY 
    total_recipes DESC;

SELECT * FROM CooksWithLessParticipation;


--3.6
AREATE VIEW 3topFood_groups AS
SELECT r1.label_id AS label1_id, r2.label_id AS label2_id, COUNT(*) AS pair_count
FROM recipe_label r1
JOIN recipe_label r2 ON r1.recipe_id = r2.recipe_id AND r1.label_id < r2.label_id
JOIN episode_cook ec ON r1.recipe_id = ec.recipe_id
GROUP BY r1.label_id, r2.label_id
ORDER BY pair_count DESC
LIMIT 3;

SELECT * FROM 3topFood_groups;

--3.7
CREATE VIEW YoungCooksRecipeCount AS
SELECT 
    c.cook_id, 
    c.first_name, 
    c.last_name
FROM 
    cook c
JOIN 
    episode_cook ec ON c.cook_id = ec.cook_id
GROUP BY 
    c.cook_id
HAVING 
    COUNT(*) <= (
        SELECT COUNT(*)
        FROM episode_cook
        GROUP BY cook_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) - 5;

SELECT * FROM CooksWithLessParticipation;



--3.8
CREATE VIEW EpisodeWithMostEquipment AS
SELECT ec.episode_id, COUNT(*) AS equipment_count
FROM episode_cook ec
JOIN recipe_equipment re ON ec.recipe_id = re.recipe_id
GROUP BY ec.episode_id
ORDER BY equipment_count DESC
LIMIT 1;
SELECT * FROM EpisodeWithMostEquipment;


--3.9
CREATE VIEW AvgCarbohydratesPerYear AS
SELECT 
    e.calendar_year AS competition_year, 
    AVG(ri.carbon_hydrates) AS avg_carbohydrates_per_recipe
FROM 
    episode e
JOIN 
    episode_cook ec ON e.episode_id = ec.episode_id
JOIN 
    recipe r ON ec.recipe_id = r.recipe_id
JOIN 
    recipe_ingredient ri ON r.recipe_id = ri.recipe_id
GROUP BY 
    e.calendar_year
ORDER BY 
    e.calendar_year;
SELECT * FROM AvgCarbohydratesPerYear;



--3.11
CREATE VIEW Top5JudgeCookScores AS
SELECT 
    c.first_name AS episode_judge_first_name,
    c.last_name AS episode_judge_last_name,
    c2.first_name AS episode_cook_first_name,
    c2.last_name AS episode_cook_last_name,
    SUM(s.points) AS total_score
FROM 
    episode_judge ej
JOIN 
    score s ON ej.judge_id = s.judge_id
JOIN 
    episode_cook ec ON s.cook_id = ec.cook_id
JOIN 
    cook c2 ON ec.cook_id = c2.cook_id
JOIN 
    cook c ON ej.judge_id = c.cook_id
GROUP BY 
    ej.judge_id, ec.cook_id
ORDER BY 
    total_score DESC
LIMIT 5;
SELECT * FROM Top5JudgeCookScores;



--3.12
CREATE VIEW MaxRecipeDifficultyPerYear AS
SELECT
        e.calendar_year AS competition_year,
        e.episode_id,
         e.number,
        MAX(r.difficulty) AS max_difficulty
     FROM
         episode e
     JOIN
         episode_cook ec ON e.episode_id = ec.episode_id
     JOIN
         recipe r ON ec.recipe_id = r.recipe_id
     GROUP BY
         competition_year;
 SELECT * FROM MaxRecipeDifficultyPerYear;



--3.13
CREATE VIEW EpisodeExperience AS
SELECT 
    episode_id,
    avg_cook_experience,
    avg_judge_experience,
    (avg_cook_experience + avg_judge_experience) AS total_experience
FROM (
    SELECT 
        ec.episode_id,
        AVG(coalesce(DATEDIFF(CURRENT_DATE(), c.birth_date), 0) / 365) AS avg_cook_experience,
        AVG(coalesce(DATEDIFF(CURRENT_DATE(), j.birth_date), 0) / 365) AS avg_judge_experience
    FROM 
        episode_cook ec
    JOIN 
        cook c ON ec.cook_id = c.cook_id
    JOIN 
        episode_judge ej ON ec.episode_id = ej.episode_id
    JOIN 
        cook j ON ej.judge_id = j.cook_id
    GROUP BY 
        ec.episode_id
) AS avg_experience_per_episode
ORDER BY 
    total_experience ASC
LIMIT 1;
SELECT * FROM EpisodeExperience;




--3.14
CREATE VIEW MostAppearedTopic AS
SELECT
    t.name AS topic_name,
    COUNT(tr.topic_id) AS appearance_count
FROM
    topic_recipe tr
JOIN
    topic t ON tr.topic_id = t.topic_id
GROUP BY
    tr.topic_id
ORDER BY
    appearance_count DESC
LIMIT 1;
SELECT * FROM MostAppearedTopic;


--3.15
CREATE VIEW NeverAppearedFood_Group AS
SELECT food_group.fg_id, food_group.name
FROM food_group
LEFT JOIN ingredient ON food_group.fg_id = ingredient.fg_id
WHERE ingredient.ingredient_id IS NULL;

SELECT * FROM NeverAppearedFood_Group;



--
--
--INDEXES
--
--

CREATE INDEX idx_cuisine ON recipe (cuisine_id);
CREATE INDEX idx_unit ON recipe (unit_id);
ALTER TABLE recipe_meal_type
ADD CONSTRAINT uk_recipe_meal_type UNIQUE (recipe_id, meal_type_id);

-- για το ερωτημα 3.6
--Ένας τρόπος για να βελτιώσουμε την απόδοση είναι με τη χρήση εθρετητιων.
-- Μπορούμε να δημιουργήσουμε έναν σύνθετο εθρετηριο στον πίνακα recipe_label για τα πεδία recipe_id και label_id. 
--Αυτός το σύνθετο ευρετηριο θα βοηθήσει τον ερωτηθείς να βρει γρηγορότερα τις συνταγές που έχουν τις ίδιες ετικέτες.

CREATE INDEX idx_recipe_label
ON recipe_label (recipe_id, label_id);

ALTER TABLE recipe_label
ADD CONSTRAINT uk_recipe_label UNIQUE (recipe_id, label_id);

CREATE INDEX idx_recipe_equipment
ON recipe_equipment (recipe_id, equipment_id);

ALTER TABLE recipe_equipment
ADD CONSTRAINT uk_recipe_equipment UNIQUE (recipe_id, equipment_id);

CREATE INDEX idx_recipe_step
ON recipe_step (recipe_id, step_id);

ALTER TABLE recipe_step
ADD CONSTRAINT uk_recipe_step UNIQUE (recipe_id, step_id);

CREATE INDEX idx_fg
ON ingredient (fg_id);

CREATE INDEX idx_recipe_ingredient
ON recipe_ingredient (recipe_id, ingredient_id);

ALTER TABLE recipe_ingredient
ADD CONSTRAINT uk_recipe_ingredient UNIQUE (recipe_id, ingredient_id);

CREATE INDEX idx_topic_recipe
ON topic_recipe (recipe_id, topic_id);

ALTER TABLE topic_recipe
ADD CONSTRAINT uk_topic_recipe UNIQUE (recipe_id, topic_id);

CREATE INDEX idx_grade
ON cook (grade_id);

CREATE INDEX idx_cook_specialisation
ON cook_specialisation (cuisine_id, cook_id);

ALTER TABLE cook_specialisation
ADD CONSTRAINT uk_cook_specialisation UNIQUE (cuisine_id, cook_id);

CREATE INDEX idx_episode_cook
ON episode_cook (episode_id, cook_id, recipe_id);

ALTER TABLE episode_cook
ADD CONSTRAINT uk_episode_cook UNIQUE (episode_id, cook_id, recipe_id);

CREATE INDEX idx_episode_judge
ON episode_judge (episode_id, judge_id);

ALTER TABLE episode_judge
ADD CONSTRAINT uk_episode_judge UNIQUE (episode_id, judge_id);

CREATE INDEX idx_score
ON score (episode_id, cook_id,judge_id);

ALTER TABLE score
ADD CONSTRAINT uk_score UNIQUE (episode_id, cook_id,judge_id);


--για το ερωτημα 3.8
--Εάν θέλουμε να βελτιστοποιήσουμε το ερώτημα χρησιμοποιώντας έναν εναλλακτικό Query Plan με τη χρήση force index,
-- μπορούμε να εφαρμόσουμε τον δείκτη idx_recipe_equipment_recipe_id στον πίνακα recipe_equipment για να επιταχύνουμε την αναζήτηση των εξαρτημάτων σύμφωνα με τη συγκεκριμένη συνταγή.

CREATE INDEX idx_recipe_equipment_recipe ON recipe_equipment (recipe_id);



-- για το ερωτημα 3.9 μεσο ορο υδατανθρακων ανα ετος
--Ένα σύνθετο ευρετήριο στον πίνακα των επεισοδίων (episode) με το πεδίο episode_date για γρήγορη πρόσβαση στα επεισόδια με βάση την ημερομηνία.


CREATE INDEX idx_episode_date ON episode (calendar_year);



--για το ερωτημα 3.10
--ευρετήριο στο πεδίο "episode_id" του πίνακα "episode_cook"και ευρετήριο στο πεδίο "cuisine_id" του πίνακα "episode_cook", 
-- Αυτό θα βοηθήσει στην επιτάχυνση της αναζήτησης και του φιλτραρίσματος των επεισοδίων ανά εθνική κουζίνα και έτος.


CREATE INDEX idx_episode_cook_episode ON episode_cook (episode_id);


--για το ερωτημα 3.11
--Ένα ευρετήριο στον πίνακα των βαθμολογιών (score) για τα πεδία judge_id και cook_id για γρήγορη πρόσβαση στις βαθμολογίες ανά κριτή και μάγειρα.
CREATE INDEX idx_judge_cook ON score (judge_id, cook_id);




--για το ερωτημα 3.12 
--Ένα ευρετήριο στον πίνακα των συνταγών (recipe) για το πεδίο difficulty για γρήγορη πρόσβαση στις συνταγές ανά επίπεδο δυσκολίας.
CREATE INDEX idx_difficulty ON recipe (difficulty);






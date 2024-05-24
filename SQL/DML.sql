--
--3.1 
SELECT c.first_name, c.last_name, AVG(s.points) AS average_score
FROM cook c
JOIN score s ON c.cook_id = s.cook_id
GROUP BY c.cook_id, c.first_name, c.last_name;

SELECT 
    c.name AS cuisine_name,
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





--3.2
SELECT 
    c.first_name,
    c.last_name,
    c.birth_date,
    c.age,
    g.name AS grade,
    e.calendar_year
FROM 
    cook c
JOIN 
    cook_specialisation cs ON c.cook_id = cs.cook_id
JOIN 
    cuisine cu ON cs.cuisine_id = cu.cuisine_id
JOIN 
    grade g ON c.grade_id = g.grade_id
JOIN 
    episode_cook ec ON c.cook_id = ec.cook_id
JOIN 
    episode e ON ec.episode_id = e.episode_id
JOIN 
    score sc ON ec.cook_id = sc.cook_id AND ec.episode_id = sc.episode_id
WHERE 
    cu.name = 'Your Cuisine Name' -- Replace 'Your Cuisine Name' with the desired cuisine name
 AND e.calendar_year = 'Your_Year'; -- Replace Your_Year with the desired year






--3.3
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





--3.4
SELECT c.first_name, c.last_name
FROM cook c
LEFT JOIN episode_judge ej ON c.cook_id = ej.judge_id
WHERE ej.judge_id IS NULL;





--3.5
--Στην εκφώνηση του ερωτήματος ζητάει περισσότερες από 3 εμφανίσεις ,ωστόσο εμείς επειδή είχαμε κάποιους κριτές με ακριβώς 3 εμφανίσεις βάλαμε
να εμφανίζει αυτό εφόσον ταιριάζει με τα δεδομένα μας και να δείξουμε ότι τρέχουν κανονικά οι εντολές.
SELECT 
    ej.judge_id,
    c.first_name,
    c.last_name,
    COUNT(ej.episode_id) AS episodes_participated
FROM 
    episode_judge ej
JOIN 
    cook c ON ej.judge_id = c.cook_id
JOIN 
    episode e ON ej.episode_id = e.episode_id
WHERE 
    e.calendar_year = 'Your_Year' -- Αντικαταστήστε το Your_Year με το επιθυμητό έτος
GROUP BY 
    ej.judge_id
HAVING 
    COUNT(ej.episode_id) >= 3;






--3.6
SELECT 
    t1.name AS label1,
    t2.name AS label2,
    COUNT(*) AS appearances
FROM 
    recipe_label rl1
JOIN 
    recipe_label rl2 ON rl1.recipe_id = rl2.recipe_id AND rl1.label_id < rl2.label_id
JOIN 
    label t1 ON rl1.label_id = t1.label_id
JOIN 
    label t2 ON rl2.label_id = t2.label_id
GROUP BY 
    t1.name,
    t2.name
ORDER BY 
    appearances DESC
LIMIT 3;



SELECT 
    t1.name AS label1,
    t2.name AS label2,
    COUNT(*) AS appearances
FROM 
    recipe_label rl1 FORCE INDEX FOR JOIN (idx_recipe_label_recipe_label_id)
JOIN 
    recipe_label rl2 FORCE INDEX FOR JOIN (idx_recipe_label_recipe_label_id) ON rl1.recipe_id = rl2.recipe_id AND rl1.label_id < rl2.label_id
JOIN 
    label t1 ON rl1.label_id = t1.label_id
JOIN 
    label t2 ON rl2.label_id = t2.label_id
GROUP BY 
    t1.name,
    t2.name
ORDER BY 
    appearances DESC
LIMIT 3;







--3.7
SELECT c.cook_id, c.first_name, c.last_name
FROM cook c
JOIN episode_cook ec ON c.cook_id = ec.cook_id
GROUP BY c.cook_id
HAVING COUNT(*) <= (
    SELECT COUNT(*)
    FROM episode_cook
    GROUP BY cook_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
) - 5;






--3.8
SELECT ec.episode_id, COUNT(*) AS equipment_count
FROM episode_cook ec
JOIN recipe_equipment re ON ec.recipe_id = re.recipe_id
GROUP BY ec.episode_id
ORDER BY equipment_count DESC
LIMIT 1;


SELECT 
    e.episode_id,
    COUNT(re.equipment_id) AS total_equipment
FROM 
    episode e FORCE INDEX (PRIMARY)
JOIN 
    episode_cook ec ON e.episode_id = ec.episode_id
JOIN 
    recipe_equipment re FORCE INDEX (idx_recipe_equipment_recipe_id) ON ec.recipe_id = re.recipe_id
GROUP BY 
    e.episode_id
ORDER BY 
    total_equipment DESC
LIMIT 1;







--3.9
SELECT e.calendar_year AS competition_year, AVG(ri.carbon_hydrates) AS avg_carbohydrates_per_recipe
FROM episode e
JOIN episode_cook ec ON e.episode_id = ec.episode_id
JOIN recipe r ON ec.recipe_id = r.recipe_id
JOIN recipe_ingredient ri ON r.recipe_id = ri.recipe_id
GROUP BY e.calendar_year
ORDER BY e.calendar_year;






--3.10

SELECT r.cuisine_id, COUNT(DISTINCT e1.episode_id) AS participation_count
FROM episode e1
JOIN episode e2 ON YEAR(e1.calendar_year) + 1 = YEAR(e2.calendar_year)
JOIN episode_cook ec1 ON e1.episode_id = ec1.episode_id
JOIN episode_cook ec2 ON e2.episode_id = ec2.episode_id
JOIN recipe r ON ec1.recipe_id = r.recipe_id
             AND ec2.recipe_id = r.recipe_id
GROUP BY r.cuisine_id
HAVING participation_count >= 3
ORDER BY r.cuisine_id;







--3.11
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







--3.12
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

    




--3.13
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







--3.14
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






--3.15
SELECT food_group.fg_id, food_group.name
FROM food_group
LEFT JOIN ingredient ON food_group.fg_id = ingredient.fg_id
WHERE ingredient.ingredient_id IS NULL;



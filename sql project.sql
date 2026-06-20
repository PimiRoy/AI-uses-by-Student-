use ai_student;
select * from ai;

---- Dataset Overview -----
---- Total students ----- 
select count(Student_ID) as Total_students from ai;

---- Students per Major_and  Students per Major -----
select Major_Category,count(Student_ID) as Students_per_Major
from ai
group by 1
order by 2;

---- Total Study Years_and Students_by_Year-----
select distinct Year_of_Study, count(Year_of_Study) as Total_years
from ai 
group by 1
order by 2;

---- Total Primary_Use Categories -----
select distinct Primary_Use_Case, count(*)
from ai
group by 1;

---- Paid vs Free Users -----
select distinct Paid_Subscription,count(*)
from ai
group by 1;

---- Total prompt engrineering skill_and users -----
select distinct Prompt_Engineering_Skill, count(*) as Skill_level
from ai 
group by 1
order by 2;

---- Institutional policy_and total students -----
select distinct Institutional_Policy, count(*)
from ai 
group by 1
order by 2;

---- Burnout risk level_and total students -----
select distinct Burnout_Risk_Level, count(*)
from ai 
group by 1
order by 2;

---- EDA (Exploratory Data_Analysis) -----
---- EDA - 1: Data_Quality_Check ------

---- Total Records -----
select count(*) as total_students
from ai;

---- Missing Values_Check -----
SELECT
COUNT(*) - COUNT(Student_ID) AS missing_student_id,
COUNT(*) - COUNT(Pre_Semester_GPA) AS missing_pre_gpa,
COUNT(*) - COUNT(Post_Semester_GPA) AS missing_post_gpa,
COUNT(*) - COUNT(Weekly_GenAI_Hours) AS missing_ai_usage
FROM ai;

---- Duplicate_Students -----
SELECT Student_ID, COUNT(*)
FROM ai
GROUP BY Student_ID
HAVING COUNT(*) > 1;

---- EDA - 2: AI_Usage Analysis -----
---- Average AI_Usage ----- 
select round(avg(Weekly_GenAI_Hours),2) as avg_ai_usage
from ai;

---- Maximum & Minimum_Usage -----
select 
 min(Weekly_GenAI_Hours) as min_usage,
 max(Weekly_GenAI_Hours) as max_usage
 from ai;

---- EDA - 3: Primary_Use Analysis -----
select Primary_Use_Case,count(*) as total_students
 from ai
 group by 1
 order by 2;

---- EDA - 4: GPA Analysis -----
---- Average Pre GPA and_Post GPA -----
select round(avg(Pre_Semester_GPA),2) AS avg_pre_gpa,
	   round(avg(Post_Semester_GPA),2) AS avg_post_gpa
  from ai;
  
---- Average GPA Improvement -----
SELECT ROUND(
AVG(Post_Semester_GPA - Pre_Semester_GPA),2
) AS avg_gpa_improvement
FROM ai;

---- EDA - 5: Paid Subscription Analysis -----
select Paid_Subscription,
       count(*) AS total_students,
       round(count(*)*100.0/(select count(*) from ai),2) 
       AS Percentage
 from ai 
 group by 1;
 
---- EDA - 6: Anxiety Analysis -----
select round(avg(Anxiety_Level_During_Exams),2) AS avg_anxiety
from ai;

---- EDA - 7: Burnout Risk Distribution -----
select Burnout_Risk_Level,
 count(*) as total_students
from ai
group by 1
order by 2;

---- Business Questions / Insights Analysis -----
---- Does higher AI usage_lead_to greater GPA improvement? -----
select 
case
    when Weekly_GenAI_Hours < 5 then 'low_Usage'
    when Weekly_GenAI_Hours < 10 then 'Medium_Usage'
    else 'High_Usage'
end as Usage_group,
round(avg(Post_Semester_GPA - Pre_Semester_GPA),2) AS GPA_Improvement
from ai 
group by 1;

----- Do students with paid AI subscriptions perform better than free users? -----
SELECT
Paid_Subscription,
ROUND(AVG(Post_Semester_GPA - Pre_Semester_GPA),2) AS GPA_Improvement
FROM ai
GROUP BY 1;

---- Which major category has the highest AI adoption rate? -----
SELECT
Major_Category,
ROUND(AVG(Weekly_GenAI_Hours),2) AS Avg_AI_Usage
FROM ai
GROUP BY 1
ORDER BY 2 DESC;

---- Is_there a relationship_between AI usage_and student anxiety levels? -----
SELECT
CASE
    WHEN Weekly_GenAI_Hours < 5 THEN 'Low'
    WHEN Weekly_GenAI_Hours < 10 THEN 'Medium'
    ELSE 'High'
END AS Usage_Group,
ROUND(AVG(Anxiety_Level_During_Exams),2) AS Avg_Anxiety
FROM ai
GROUP BY 1;

---- Does using_multiple AI tools improve academic performance? -----
SELECT
Tool_Diversity,
ROUND(AVG(Post_Semester_GPA - Pre_Semester_GPA),2) AS GPA_Improvement
FROM ai
GROUP BY 1
ORDER BY 2 DESC;

---- Year_wise AI_Usage -----
SELECT
Year_of_Study,
ROUND(AVG(Weekly_GenAI_Hours),2) AS Avg_AI_Usage
FROM ai
GROUP BY 1
ORDER BY 1 desc;

---- What is_the relationship between_traditional study time_and GPA improvement? -----
SELECT
CASE
    WHEN Traditional_Study_Hours <= 10 THEN 'Low Study Time'
    WHEN Traditional_Study_Hours <= 20 THEN 'Moderate Study Time'
    ELSE 'High Study Time'
END as study_group,
ROUND(AVG(Post_Semester_GPA - Pre_Semester_GPA),2) AS GPA_Improvement
FROM ai
GROUP BY 1
ORDER BY 1;




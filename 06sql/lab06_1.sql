-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Lab 06

-- 6.2
-- a

SELECT T.name, T.mandate, (CASE WHEN PT.role = 'chair' THEN PT.personID ELSE NULL END) AS ID FROM Team T
LEFT OUTER JOIN PersonTeam PT ON T.name = PT.teamName;
drop table GradeMap;
create table GradeMap (
       Grade    VARCHAR(3),
       GradeNum  INTEGER
);

insert into GradeMap  values ( '6A', 0);
insert into GradeMap  values ( '6A+', 0);
insert into GradeMap  values ( '6B', 1);
insert into GradeMap  values ( '6B+', 2);
insert into GradeMap  values ( '6C', 3);
insert into GradeMap  values ( '6C+', 4);
insert into GradeMap  values ( '7A', 5);
insert into GradeMap  values ( '7A+', 6);
insert into GradeMap  values ( '7B', 7);
insert into GradeMap  values ( '7B+', 8);
insert into GradeMap  values ( '7C', 9);
insert into GradeMap  values ( '7C+', 10);
insert into GradeMap  values ( '8A', 11);
insert into GradeMap  values ( '8A+', 12);
insert into GradeMap  values ( '8B', 13);
insert into GradeMap  values ( '8B+', 14);
insert into GradeMap  values ( '8C', 15);
insert into GradeMap  values ( '8C+', 16);

alter table Setter
drop column sId;

alter table MoonboardConfig
drop column Holdsetup;

alter table MoonboardConfig
change MoonboardConfiguration Angle VARCHAR(13);

DELIMITER //
DROP PROCEDURE IF EXISTS FilterBySetter//
CREATE PROCEDURE FilterBySetter(FName VARCHAR(100), LName VARCHAR(100), City VARCHAR(100), Country VARCHAR(100))
BEGIN
SET @query = '';
IF (FName is not Null) THEN
	SET @query = CONCAT(@query, ' AND s.FirstName LIKE \'', FName, '\'');
END IF;
IF (LName is not Null) THEN
	SET @query = CONCAT(@query, ' AND s.LastName LIKE \'', LName, '\'');
END IF;
IF (City is not Null) THEN
	SET @query = CONCAT(@query, ' AND s.City LIKE \'', City, '\'');
END IF;
IF (Country is not Null) THEN
	SET @query = CONCAT(@query, ' AND s.Country LIKE \'', Country, '\'');
END IF;

SET @holdResult=CONCAT('SELECT Id FROM Setter AS s WHERE Id = Id', @query, ';');
PREPARE st FROM @holdResult;
EXECUTE st;
DEALLOCATE PREPARE st;
END //
//

DROP PROCEDURE IF EXISTS FilterProblems//
CREATE PROCEDURE FilterProblems(gMin VARCHAR(3), gMax VARCHAR(3),
dMin VARCHAR(10), dmax VARCHAR(10),
bench BOOLEAN,
rMin INTEGER, rMax INTEGER,
name VARCHAR(100),
mb INTEGER,
FName VARCHAR(100), LName VARCHAR(100), City VARCHAR(100), Country VARCHAR(100)
)
BEGIN
SET @query = '';
IF (gMin is not Null) THEN
	SET @startNum = (SELECT GradeNum FROM GradeMap WHERE Grade = gMin);
	SET @endNum = (SELECT GradeNum FROM GradeMap WHERE Grade = gMax);
	SET @query = CONCAT(@query, ' AND p.Grade = g.Grade AND g.GradeNum >= ', @startNum, ' AND g.GradeNum <= ', @endNum);
END IF;
IF (dMin is not Null) THEN
	SET @query = CONCAT(@query, ' AND STR_TO_DATE(p.DateTimeString, "%e %b %Y %H:%i") >= STR_TO_DATE(\'', dMin, '\', "%Y-%m-%d") AND STR_TO_DATE(p.DateTimeString, "%e %b %Y %H:%i") <= DATE_ADD(STR_TO_DATE(\'', dMax, '\', "%Y-%m-%d"), INTERVAL 1 DAY)');
END IF;
IF (bench is not Null) THEN
	SET @query = CONCAT(@query, ' AND p.IsBenchmark = ', bench);
END IF;
IF (rMin is not Null) THEN
	SET @query = CONCAT(@query, ' AND p.Repeats >= ', rMin, ' AND p.Repeats <= ', rMax);
END IF;
IF (name is not Null) THEN
	SET @query = CONCAT(@query, ' AND p.Name LIKE \'%', name, '%\'');
END IF;
IF (mb is not Null) THEN
	SET @query = CONCAT(@query, ' AND p.MoonboardConfiguration = m.cId AND m.cId = ', mb);
END IF;
IF (FName is not Null) THEN
	SET @query = CONCAT(@query, ' AND p.Setter = s.Id AND s.FirstName LIKE \'', FName, '\'');
END IF;
IF (LName is not Null) THEN
	SET @query = CONCAT(@query, ' AND p.Setter = s.Id AND s.LastName LIKE \'', LName, '\'');
END IF;
IF (City is not Null) THEN
	SET @query = CONCAT(@query, ' AND p.Setter = s.Id AND s.City LIKE \'', City, '\'');
END IF;
IF (Country is not Null) THEN
	SET @query = CONCAT(@query, ' AND p.Setter = s.Id AND s.Country LIKE \'', Country, '\'');
END IF;

SET @holdResult=CONCAT('SELECT DISTINCT p.* FROM Problem AS p, GradeMap AS g, MoonboardConfig AS m, Setter AS s, Moves AS mo WHERE p.pId = p.pId', @query, ';');
PREPARE st FROM @holdResult;
EXECUTE st;
DEALLOCATE PREPARE st;
END //

DROP PROCEDURE IF EXISTS FilterByHold//
CREATE PROCEDURE FilterByHold(des VARCHAR(2))
BEGIN
	SELECT p.* FROM Problem AS p, Moves As m WHERE p.pId = m.pId AND m.Description = des;
END//


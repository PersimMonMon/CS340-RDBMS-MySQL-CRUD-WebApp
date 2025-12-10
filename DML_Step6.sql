-- Group 72 
-- Kyle Norris and Thomas Bui
-- DML for Portfolio Project

-- SELECT QUERIES

-- Select all Directors
SELECT directorID, firstName, lastName, email
FROM Directors
ORDER BY lastName;

-- Select all Shows
SELECT Shows.showID, Shows.date, Directors.firstName, Directors.lastName
FROM Shows
LEFT JOIN Directors ON Shows.directorID = Directors.directorID
ORDER BY Shows.date;

-- Select all Actors
SELECT actorID, firstName, lastName, email
FROM Actors
ORDER BY lastName;

-- SELECT all Skits
SELECT Skits.skitID, Skits.title, Skits.description, Shows.date AS show_date, 
CONCAT(Actors.firstName, ' ', Actors.lastName) AS author
FROM Skits
LEFT JOIN Shows ON Skits.showID = Shows.showID
LEFT JOIN Actors ON Skits.authorID = Actors.actorID
ORDER BY Skits.title;

-- SELECT all SkitActors
SELECT SkitActors.skitID, SkitActors.actorID, SkitActors.role, Skits.title, Actors.firstName, Actors.lastName
FROM SkitActors
JOIN Skits ON SkitActors.skitID = Skits.skitID
JOIN Actors ON SkitActors.actorID = Actors.actorID
ORDER BY Skits.title;



-- CREATE UPDATE and DELETE Queries for SkitActors
-- @ character being used to 
-- denote the variables that will have data from the backend programming language


-- And a new actor to a skit
INSERT INTO SkitActors (skitID, actorID, role)
VALUES (@skitID, @actorID, @role);

-- UPDATE by changing actor role or reassign actor/skit
UPDATE SkitActors
SET role = @newRole, actorID = @newActorID
WHERE skitID = @skitID AND actorID = @oldActorID;

-- DELETE an actor from a skit
DELETE FROM SkitActors
WHERE skitID = @skitID AND actorID = @actorID;

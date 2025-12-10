/*Importable DDL for Group 72 Portfolio Project on "The Local Stage." Preps database with sample data. 
First section drops tables if they already exists and create the 5 new tables.
*/

DROP PROCEDURE IF EXISTS sp_load_skitsdb()
DELIMITER //
CREATE PROCEDURE sp_load_skitsdb()
BEGIN
	SET FOREIGN_KEY_CHECKS=0;
	SET AUTOCOMMIT = 0;

	DROP TABLE IF EXISTS SkitActors;
	DROP TABLE IF EXISTS Skits;
	DROP TABLE IF EXISTS Shows;
	DROP TABLE IF EXISTS Actors;
	DROP TABLE IF EXISTS Directors;


	CREATE TABLE Directors (
	directorID int NOT NULL AUTO_INCREMENT,
	firstName varchar(50) NOT NULL,
	lastName varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	PRIMARY KEY (directorID) 
	);

	/* Used on delete set null so a deleted director doesn't cause an entire show to be deleted.
	*/
	CREATE TABLE Shows (
	showID int AUTO_INCREMENT NOT NULL,
	`date` date NOT NULL,
	directorID int,
	PRIMARY KEY (showID),
	FOREIGN KEY (directorID) REFERENCES Directors(directorID) ON DELETE SET NULL
	);

	CREATE TABLE Actors (
	actorID int AUTO_INCREMENT NOT NULL,
	firstName varchar(50) NOT NULL,
	lastName varchar(50) NOT NULL,
	email varchar(100) NOT NULL,
	PRIMARY KEY (actorID)
	);

	/* Used on delete set null so a deleted actor doesn't delete the skits they are in.
	*/
	CREATE TABLE Skits (
	skitID int AUTO_INCREMENT NOT NULL,
	title varchar(100) NOT NULL,
	`description` TEXT,
	showID int NOT NULL,
	authorID int,
	PRIMARY KEY (skitID),
	FOREIGN KEY (showID) REFERENCES Shows(showID) ON DELETE CASCADE,
	FOREIGN KEY (authorID) REFERENCES Actors(actorID) ON DELETE SET NULL
	);

	CREATE TABLE SkitActors (
	skitID int NOT NULL,
	actorID int NOT NULL,
	`role` varchar(100),
	PRIMARY KEY (skitID, actorID),
	FOREIGN KEY (skitID) REFERENCES Skits(skitID) ON DELETE CASCADE,
	FOREIGN KEY (actorID) REFERENCES Actors(actorID) ON DELETE CASCADE
	);

	/* This section adds the Sample Data to the new tables.
	*/

	 
	INSERT INTO Directors (
		firstName,
		lastName,
		email
	) VALUES
		('Mary', 
		'Smith', 
		'marysmith@localstage.com'),
		('Daniel', 
		'Craig', 
		'notthatdanielcraig@localstage.com'),
		('John', 
		'Doe', 
		'johndoe@localstage.com');

	/* Shows with directorID populated via SELECT */
	INSERT INTO Shows (`date`, directorID)
	SELECT '2025-01-15', directorID FROM Directors WHERE firstName='Mary' AND lastName='Smith';

	INSERT INTO Shows (`date`, directorID)
	SELECT '2025-02-20', directorID FROM Directors WHERE firstName='Daniel' AND lastName='Craig';

	INSERT INTO Shows (`date`, directorID)
	SELECT '2025-03-18', directorID FROM Directors WHERE firstName='Mary' AND lastName='Smith';

	INSERT INTO Shows (`date`, directorID)
	SELECT '2025-04-10', directorID FROM Directors WHERE firstName='Mary' AND lastName='Smith';

	/* Insert Actors */
	INSERT INTO Actors (
		firstName,
		lastName,
		email
	) VALUES
		('Chris', 
		'Lowe', 
		'chrislowe@gmail.com'),
		('Steve', 
		'Rogers', 
		'thecap@aol.com'),
		('Beau', 
		'Regard', 
		'beauregard1234@live.com'),
		('May', 
		'Bee', 
		'maybee@gmail.com'),
		('Sue', 
		'Mary', 
		'MarySue@hotmail.com');

	/* Insert Skits using SELECT for showID and authorID */
	INSERT INTO Skits (title, `description`, showID, authorID)
	SELECT 'Morning Monster', 'A comedy about not have my morning coffee',
		   Shows.showID, Actors.actorID
	FROM Shows
	JOIN Actors ON Actors.firstName='Chris' AND Actors.lastName='Lowe'
	WHERE Shows.`date` = '2025-01-15';

	INSERT INTO Skits (title, `description`, showID, authorID)
	SELECT 'Love at First Swipe', 'A romance about dating apps',
		   Shows.showID, Actors.actorID
	FROM Shows
	JOIN Actors ON Actors.firstName='Chris' AND Actors.lastName='Lowe'
	WHERE Shows.`date` = '2025-01-15';

	INSERT INTO Skits (title, `description`, showID, authorID)
	SELECT 'Office Apocalypse', 'A skit about being stuck in the office even after the apocalypse.',
		   Shows.showID, Actors.actorID
	FROM Shows
	JOIN Actors ON Actors.firstName='Steve' AND Actors.lastName='Rogers'
	WHERE Shows.`date` = '2025-02-20';

	INSERT INTO Skits (title, `description`, showID, authorID)
	SELECT 'Line!', 'A skit about actors forgetting their lines.',
		   Shows.showID, Actors.actorID
	FROM Shows
	JOIN Actors ON Actors.firstName='Beau' AND Actors.lastName='Regard'
	WHERE Shows.`date` = '2025-03-18';

	INSERT INTO Skits (title, `description`, showID, authorID)
	SELECT 'Waxing Poetic', NULL,
		   Shows.showID, Actors.actorID
	FROM Shows
	JOIN Actors ON Actors.firstName='Sue' AND Actors.lastName='Mary'
	WHERE Shows.`date` = '2025-04-10';

	/* Insert SkitActors using SELECT for FKs */
	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, NULL
	FROM Skits
	JOIN Actors ON Actors.firstName='Chris' AND Actors.lastName='Lowe'
	WHERE Skits.title='Morning Monster';

	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, 'Angry Coffee Hulk'
	FROM Skits
	JOIN Actors ON Actors.firstName='Steve' AND Actors.lastName='Rogers'
	WHERE Skits.title='Morning Monster';

	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, 'male lead'
	FROM Skits
	JOIN Actors ON Actors.firstName='Steve' AND Actors.lastName='Rogers'
	WHERE Skits.title='Love at First Swipe';

	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, 'robot dating app'
	FROM Skits
	JOIN Actors ON Actors.firstName='Beau' AND Actors.lastName='Regard'
	WHERE Skits.title='Love at First Swipe';

	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, 'office worker'
	FROM Skits
	JOIN Actors ON Actors.firstName='Chris' AND Actors.lastName='Lowe'
	WHERE Skits.title='Office Apocalypse';

	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, 'intern'
	FROM Skits
	JOIN Actors ON Actors.firstName='Steve' AND Actors.lastName='Rogers'
	WHERE Skits.title='Office Apocalypse';

	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, 'manager'
	FROM Skits
	JOIN Actors ON Actors.firstName='May' AND Actors.lastName='Bee'
	WHERE Skits.title='Office Apocalypse';

	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, 'actor'
	FROM Skits
	JOIN Actors ON Actors.firstName='Chris' AND Actors.lastName='Lowe'
	WHERE Skits.title='Line!';

	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, 'forgetful actor'
	FROM Skits
	JOIN Actors ON Actors.firstName='Beau' AND Actors.lastName='Regard'
	WHERE Skits.title='Line!';

	INSERT INTO SkitActors (skitID, actorID, `role`)
	SELECT Skits.skitID, Actors.actorID, 'solo performance'
	FROM Skits
	JOIN Actors ON Actors.firstName='Steve' AND Actors.lastName='Rogers'
	WHERE Skits.title='Waxing Poetic';

	SET FOREIGN_KEY_CHECKS=1;
	COMMIT;
 END //
 
 DELIMITER ;
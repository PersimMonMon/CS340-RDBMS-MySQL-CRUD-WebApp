-- Group 72
-- Kyle Norris and Thomas Bui
-- PL for Portfolio project

-- Citation for use of AI Tools
-- 11-16-2025
-- Prompt used: Could you help me add a check to this stored procedure to 
-- make sure that each actor can only be assigned to each skit once?
-- AI Source: chatgpt.com


-- CREATE Stored Procedure
DROP PROCEDURE IF EXISTS sp_CreateSkitActor;

DELIMITER //
CREATE PROCEDURE sp_CreateSkitActor(
	IN p_skitID INT,
    IN p_actorID INT,
    IN p_role VARCHAR(100)
)
BEGIN
	-- Deplicate Prevention created using help from ChatGPT
    IF NOT EXISTS (
		SELECT 1
        FROM SkitActors
        WHERE skitID = p_skitID AND actorID = p_actorID
	) THEN
		INSERT INTO SkitActors (skitID, actorID, role)
		VALUES (p_skitID, p_actorID, p_role);
	END IF;
END //
DELIMITER ;
    
-- RESET Stored Procedure
-- Citation for use of AI Tools
-- 11-16-2025
-- Prompt used: Could you fill out the rest of the re-insertion
-- AI Source: chatgpt.com

DROP PROCEDURE IF EXISTS sp_ResetSkitActors;
DELIMITER // 
CREATE PROCEDURE sp_ResetSkitActors()
BEGIN 
  SET FOREIGN_KEY_CHECKS = 0;
  DELETE FROM SkitActors;

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

    -- Re-enable the foreign key checks 
    SET FOREIGN_KEY_CHECKS = 1;
END //
DELIMITER ;

-- Update Stored Procedure
-- No AI used
DROP PROCEDURE IF EXISTS sp_UpdateSkitActor;

DELIMITER //
CREATE PROCEDURE sp_UpdateSkitActor(
	IN p_oldSkitID INT,
    IN p_oldActorID INT,
    IN p_newSkitID INT,
    IN p_newActorID INT,
    IN p_newRole VARCHAR(100)
)
BEGIN
	UPDATE SkitActors
	SET skitID = p_newSkitID, 
    actorID = p_newActorID, 
    `role` = p_newRole
    WHERE
    skitID = p_oldSkitID AND actorID = p_oldActorID;
END //
DELIMITER ;



-- Delete Stored Procedure
-- No AI used

DROP PROCEDURE IF EXISTS sp_DeleteSkitActor;

DELIMITER //
CREATE PROCEDURE sp_DeleteSkitActor(
IN p_skitID INT,
IN p_actorID INT
)
BEGIN
    DELETE FROM SkitActors 
    WHERE skitID = p_skitID AND actorID = p_actorID;
END //
DELIMITER ;
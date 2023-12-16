-- Create animal table
CREATE TABLE Animal (
    AnimalID INT PRIMARY KEY,
    Species VARCHAR(255),
    Name VARCHAR(255),
    Age INT,
    Status VARCHAR(50),
    Location VARCHAR(255),
    EntryDate DATETIME,
    ExitDate DATETIME
);
-- Insert data to animal table
INSERT INTO Animal (AnimalID, Species, Name, Age, Status, Location, EntryDate, ExitDate)
VALUES
    (1, 'Dog', 'Buddy', 3, 'Adoptable', 'Shelter A', '2023-01-01 10:00:00', NULL),
    (2, 'Cat', 'Whiskers', 2, 'In Medical Care', 'Clinic B', '2023-02-15 14:30:00', NULL),
    (3, 'Rabbit', 'Cotton', 1, 'Available for Adoption', 'Shelter C', '2023-03-20 09:45:00', '2023-04-10 11:20:00');
-- Create changeLog for trigger
CREATE TABLE ChangeLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    AnimalID INT,
    OldStatus VARCHAR(50),
    NewStatus VARCHAR(50),
    OldLocation VARCHAR(255),
    NewLocation VARCHAR(255),
    UpdateTime DATETIME
);
-- Create Trigger for animal status update
CREATE TRIGGER AnimalStatusUpdateTrigger
AFTER UPDATE ON Animal
FOR EACH ROW
INSERT INTO ChangeLog (AnimalID, OldStatus, NewStatus, OldLocation, NewLocation, UpdateTime)
VALUES (OLD.AnimalID, OLD.Status, NEW.Status, OLD.Location, NEW.Location, NOW());

-- Create Procedure for animal status location
DELIMITER //

CREATE PROCEDURE UpdateAnimalStatusAndLocation(
    IN AnimalID_Param INT,
    IN NewStatus_Param VARCHAR(50),
    IN NewLocation_Param VARCHAR(255)
)
BEGIN
    UPDATE Animal
    SET Status = NewStatus_Param,
        Location = NewLocation_Param
    WHERE AnimalID = AnimalID_Param;
    
    -- change
    INSERT INTO ChangeLog (AnimalID, OldStatus, NewStatus, OldLocation, NewLocation, UpdateTime)
    SELECT
        AnimalID_Param,
        Status AS OldStatus,
        NewStatus_Param AS NewStatus,
        Location AS OldLocation,
        NewLocation_Param AS NewLocation,
        NOW() AS UpdateTime
    FROM Animal
    WHERE AnimalID = AnimalID_Param;
END //

DELIMITER ;

-- call procedure
CALL UpdateAnimalStatusAndLocation(1, 'Adopted', 'New Home');

-- Create MedicalRecord 
CREATE TABLE MedicalRecord (
    RecordID INT PRIMARY KEY,
    AnimalID INT,
    HealthStatus VARCHAR(255),
    MedicalHistory TEXT,
    FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID)
);

-- Insert data to Medical record
INSERT INTO MedicalRecord (RecordID, AnimalID, HealthStatus, MedicalHistory)
VALUES
    (1, 1, 'Healthy', 'Regular check-up, vaccinations up to date.'),
    (2, 2, 'Recovering', 'Underwent surgery for a broken leg.'),
    (3, 3, 'Stable', 'No major health issues, routine examinations performed.');

-- Create IntegratedHealthStatistics View
CREATE VIEW IntegratedHealthStatistics AS
SELECT
    HealthStatus,
    COUNT(*) AS NumberOfAnimals
FROM MedicalRecord
GROUP BY HealthStatus;

-- UpdateMedicalRecord store procedure
DELIMITER //

CREATE PROCEDURE UpdateMedicalRecord(
    IN AnimalID_Param INT,
    IN HealthStatus_Param VARCHAR(255),
    IN MedicalHistory_Param TEXT
)
BEGIN
    DECLARE existingRecordCount INT;
    
    -- Check if there is an existing medical record for the animal
    SELECT COUNT(*) INTO existingRecordCount
    FROM MedicalRecord
    WHERE AnimalID = AnimalID_Param;
    
    -- If an existing record is found, update it; otherwise, insert a new record
    IF existingRecordCount > 0 THEN
        UPDATE MedicalRecord
        SET HealthStatus = HealthStatus_Param,
            MedicalHistory = MedicalHistory_Param
        WHERE AnimalID = AnimalID_Param;
    ELSE
        INSERT INTO MedicalRecord (AnimalID, HealthStatus, MedicalHistory)
        VALUES (AnimalID_Param, HealthStatus_Param, MedicalHistory_Param);
    END IF;
END //

DELIMITER ;

-- Call the UpdateMedicalRecord Procedure
CALL UpdateMedicalRecord(1, 'Stable', 'Regular check-up, vaccinations up to date.');

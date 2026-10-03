-- ============================================================
-- CREATE CORE EQUIPMENT TABLES FROM PdM SOURCE TABLES
-- ============================================================

-- ============================================================
-- 1. Equipment
-- Source: PdM_machines
-- ============================================================

CREATE TABLE Equipment
(
    machineID TINYINT NOT NULL,
    model NVARCHAR(50) NOT NULL,
    age TINYINT NOT NULL,

    CONSTRAINT PK_Equipment
        PRIMARY KEY (machineID)
);
GO

INSERT INTO Equipment
(
    machineID,
    model,
    age
)
SELECT
    machineID,
    model,
    age
FROM PdM_machines;
GO


-- ============================================================
-- 2. EquipmentMeasurements
-- Source: PdM_telemetry
-- ============================================================

CREATE TABLE EquipmentMeasurements
(
    datetime DATETIME2(7) NOT NULL,
    machineID TINYINT NOT NULL,
    volt DECIMAL(10,3) NULL,
    rotate DECIMAL(10,3) NULL,
    pressure DECIMAL(10,3) NULL,
    vibration DECIMAL(10,3) NULL,

    CONSTRAINT PK_EquipmentMeasurements
        PRIMARY KEY (datetime, machineID),

    CONSTRAINT FK_EquipmentMeasurements_Equipment
        FOREIGN KEY (machineID)
        REFERENCES Equipment(machineID)
);
GO

INSERT INTO EquipmentMeasurements
(
    datetime,
    machineID,
    volt,
    rotate,
    pressure,
    vibration
)
SELECT
    datetime,
    machineID,
    volt,
    rotate,
    pressure,
    vibration
FROM PdM_telemetry;
GO


-- ============================================================
-- 3. EquipmentErrors
-- Source: PdM_errors
-- ============================================================

CREATE TABLE EquipmentErrors
(
    datetime DATETIME2(7) NOT NULL,
    machineID TINYINT NOT NULL,
    errorID NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_EquipmentErrors
        PRIMARY KEY (datetime, machineID, errorID),

    CONSTRAINT FK_EquipmentErrors_Equipment
        FOREIGN KEY (machineID)
        REFERENCES Equipment(machineID)
);
GO

INSERT INTO EquipmentErrors
(
    datetime,
    machineID,
    errorID
)
SELECT
    datetime,
    machineID,
    errorID
FROM PdM_errors;
GO


-- ============================================================
-- 4. EquipmentMaintenance
-- Source: PdM_maint
-- ============================================================

CREATE TABLE EquipmentMaintenance
(
    datetime DATETIME2(7) NOT NULL,
    machineID TINYINT NOT NULL,
    comp NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_EquipmentMaintenance
        PRIMARY KEY (datetime, machineID, comp),

    CONSTRAINT FK_EquipmentMaintenance_Equipment
        FOREIGN KEY (machineID)
        REFERENCES Equipment(machineID)
);
GO

INSERT INTO EquipmentMaintenance
(
    datetime,
    machineID,
    comp
)
SELECT
    datetime,
    machineID,
    comp
FROM PdM_maint;
GO


-- ============================================================
-- 5. EquipmentFailures
-- Source: PdM_failures
-- ============================================================

CREATE TABLE EquipmentFailures
(
    datetime DATETIME2(7) NOT NULL,
    machineID TINYINT NOT NULL,
    failure NVARCHAR(50) NOT NULL,

    CONSTRAINT PK_EquipmentFailures
        PRIMARY KEY (datetime, machineID, failure),

    CONSTRAINT FK_EquipmentFailures_Equipment
        FOREIGN KEY (machineID)
        REFERENCES Equipment(machineID)
);
GO

INSERT INTO EquipmentFailures
(
    datetime,
    machineID,
    failure
)
SELECT
    datetime,
    machineID,
    failure
FROM PdM_failures;
GO
# Data Dictionary

## Overview

The project uses five core SQL Server tables created from the Microsoft Azure Predictive Maintenance synthetic dataset.

These tables represent equipment, telemetry measurements, error events, maintenance events, and failure events.

---

## 1. Equipment

**Purpose:** Stores master information about industrial equipment.

**Source:** `PdM_machines`

| Column | Data Type | Description |
|---|---|---|
| `machineID` | `tinyint` | Unique identifier for the equipment |
| `model` | `nvarchar` | Equipment model |
| `age` | `tinyint` | Equipment age |

### Primary Key

```text
machineID
```

### Record Count

**100 machines**

---

## 2. EquipmentMeasurements

**Purpose:** Stores periodic telemetry measurements recorded for each machine.

**Source:** `PdM_telemetry`

| Column | Data Type | Description |
|---|---|---|
| `datetime` | `datetime2` | Date and time of the measurement |
| `machineID` | `tinyint` | Equipment identifier |
| `volt` | `float` | Voltage measurement |
| `rotate` | `float` | Rotation measurement |
| `pressure` | `float` | Pressure measurement |
| `vibration` | `float` | Vibration measurement |

### Primary Key

```text
machineID + datetime
```

### Foreign Key

```text
machineID → Equipment(machineID)
```

### Record Count

**876,100 measurements**

---

## 3. EquipmentErrors

**Purpose:** Stores recorded error events associated with equipment.

**Source:** `PdM_errors`

| Column | Data Type | Description |
|---|---|---|
| `datetime` | `datetime2` | Date and time of the error |
| `machineID` | `tinyint` | Equipment identifier |
| `errorID` | `nvarchar(50)` | Error type identifier |

### Primary Key

```text
machineID + datetime + errorID
```

### Foreign Key

```text
machineID → Equipment(machineID)
```

### Record Count

**3,919 error events**

---

## 4. EquipmentMaintenance

**Purpose:** Stores recorded maintenance events for equipment components.

**Source:** `PdM_maint`

| Column | Data Type | Description |
|---|---|---|
| `datetime` | `datetime2` | Date and time of maintenance |
| `machineID` | `tinyint` | Equipment identifier |
| `comp` | `nvarchar(50)` | Component associated with the maintenance event |

### Primary Key

```text
machineID + datetime + comp
```

### Foreign Key

```text
machineID → Equipment(machineID)
```

### Record Count

**3,286 maintenance events**

---

## 5. EquipmentFailures

**Purpose:** Stores recorded equipment failure events.

**Source:** `PdM_failures`

| Column | Data Type | Description |
|---|---|---|
| `datetime` | `datetime2` | Date and time of the failure |
| `machineID` | `tinyint` | Equipment identifier |
| `failure` | `nvarchar(50)` | Component associated with the failure |

### Primary Key

```text
machineID + datetime + failure
```

### Foreign Key

```text
machineID → Equipment(machineID)
```

### Record Count

**761 failure events**

---

## Table Relationships

The core data model is centered around the `Equipment` table.

```text
                         Equipment
                       machineID (PK)
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
          ▼                 ▼                 ▼
EquipmentMeasurements  EquipmentErrors  EquipmentMaintenance
machineID (FK)         machineID (FK)  machineID (FK)
          │
          │
          └──────────────────────┐
                                 ▼
                         EquipmentFailures
                         machineID (FK)
```

---

## Relationship Summary

| Parent Table | Child Table | Relationship |
|---|---|---|
| `Equipment` | `EquipmentMeasurements` | One-to-many |
| `Equipment` | `EquipmentErrors` | One-to-many |
| `Equipment` | `EquipmentMaintenance` | One-to-many |
| `Equipment` | `EquipmentFailures` | One-to-many |

---

## Analytical Grain

The tables have different analytical grains:

| Table | Grain |
|---|---|
| `Equipment` | One row per machine |
| `EquipmentMeasurements` | One row per machine and timestamp |
| `EquipmentErrors` | One row per machine, timestamp, and error type |
| `EquipmentMaintenance` | One row per machine, timestamp, and component |
| `EquipmentFailures` | One row per machine, timestamp, and failure component |

Understanding the grain of each table is important when joining event-level data.

Directly joining multiple event tables only by `machineID` can create many-to-many row multiplication. The project therefore uses aggregation and event-sequencing techniques where appropriate.

---

## Key Analytical Concepts

The project uses the following analytical concepts:

- Equipment-level aggregation
- Component-level failure analysis
- Event-level analysis
- Failure-to-maintenance sequencing
- Error-to-failure sequencing
- Maintenance coverage
- Failure frequency
- Error frequency
- Equipment-age analysis
- Multi-signal maintenance classification

---

## Important Interpretation Notes

The project uses recorded event relationships rather than confirmed maintenance work orders linked to individual failures.

Therefore:

- A later maintenance event is treated as the **next recorded corresponding maintenance event**.
- Failure-to-maintenance response time is not treated as MTTR.
- Maintenance coverage does not prove that every failure was repaired.
- Error-to-failure relationships describe temporal association rather than causation.
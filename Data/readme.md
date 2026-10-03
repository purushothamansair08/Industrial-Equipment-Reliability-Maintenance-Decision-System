# Dataset Documentation

## Dataset

**Microsoft Azure Predictive Maintenance Dataset**

This project uses the Microsoft Azure Predictive Maintenance synthetic dataset to analyze industrial equipment reliability, failures, errors, telemetry, and maintenance activity.

The dataset contains information from multiple interconnected sources representing equipment, sensor measurements, errors, maintenance events, and failures.

---

## Source Tables

The project uses five source datasets:

| Dataset | Description | Records |
|---|---|---:|
| `PdM_machines` | Equipment master data | 100 |
| `PdM_telemetry` | Equipment sensor measurements | 876,100 |
| `PdM_errors` | Equipment error events | 3,919 |
| `PdM_maint` | Equipment maintenance events | 3,286 |
| `PdM_failures` | Equipment failure events | 761 |

---

## 1. PdM_machines

Contains the master information for each machine.

### Key Columns

| Column | Description |
|---|---|
| `machineID` | Unique identifier for the machine |
| `model` | Machine model |
| `age` | Age of the machine |

### Records

- Machines: **100**
- Machine age range: **0–20 years**
- Average machine age: **11.33 years**

---

## 2. PdM_telemetry

Contains periodic sensor measurements recorded for each machine.

### Key Columns

| Column | Description |
|---|---|
| `datetime` | Date and time of measurement |
| `machineID` | Machine identifier |
| `volt` | Voltage measurement |
| `rotate` | Rotation measurement |
| `pressure` | Pressure measurement |
| `vibration` | Vibration measurement |

### Records

**876,100**

### Measurement Ranges

| Measurement | Minimum | Maximum |
|---|---:|---:|
| Voltage | 97.334 | 255.125 |
| Rotation | 138.432 | 695.021 |
| Pressure | 51.237 | 185.952 |
| Vibration | 14.877 | 76.791 |

---

## 3. PdM_errors

Contains recorded error events associated with machines.

### Key Columns

| Column | Description |
|---|---|
| `datetime` | Date and time of error |
| `machineID` | Machine identifier |
| `errorID` | Error type identifier |

### Records

**3,919**

The dataset contains five recorded error types:

- `error1`
- `error2`
- `error3`
- `error4`
- `error5`

---

## 4. PdM_maint

Contains recorded maintenance events.

### Key Columns

| Column | Description |
|---|---|
| `datetime` | Date and time of maintenance |
| `machineID` | Machine identifier |
| `comp` | Component associated with maintenance |

### Records

**3,286**

The component identifiers used in the dataset include:

- `comp1`
- `comp2`
- `comp3`
- `comp4`

---

## 5. PdM_failures

Contains recorded equipment failure events.

### Key Columns

| Column | Description |
|---|---|
| `datetime` | Date and time of failure |
| `machineID` | Machine identifier |
| `failure` | Component associated with the failure |

### Records

**761**

The recorded failure components include:

- `comp1`
- `comp2`
- `comp3`
- `comp4`

---

## Data Relationships

The datasets are connected primarily through `machineID`.

PdM_machines
     |
     +---- PdM_telemetry
     |
     +---- PdM_errors
     |
     +---- PdM_maint
     |
     +---- PdM_failures

`machineID` acts as the common equipment identifier across the datasets.

---

## Project Core Tables

The raw datasets were loaded into SQL Server and organized into core project tables:

| Core Table | Source |
|---|---|
| `Equipment` | `PdM_machines` |
| `EquipmentMeasurements` | `PdM_telemetry` |
| `EquipmentErrors` | `PdM_errors` |
| `EquipmentMaintenance` | `PdM_maint` |
| `EquipmentFailures` | `PdM_failures` |

The core tables are used for the reliability analysis and decision-engine queries contained in the `SQL/` folder.

---

## Data Quality Checks

The project includes validation of:

- Row counts between source and core tables
- Duplicate records
- NULL values
- Primary-key integrity
- Foreign-key/orphan records
- Date ranges
- Telemetry value ranges

The detailed validation queries are maintained in the project's SQL files.

---

## Important Dataset Limitation

This project uses a **synthetic predictive-maintenance dataset**.

The analysis demonstrates SQL-based industrial reliability analysis and decision logic. The results should therefore be treated as analytical outputs from the synthetic dataset rather than measurements of real-world equipment or production maintenance performance.
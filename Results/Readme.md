# Project Results & Key Findings

## 1. Dataset Overview

| Metric | Value |
|---|---:|
| Total Equipment | 100 |
| Telemetry Records | 876,100 |
| Error Events | 3,919 |
| Maintenance Events | 3,286 |
| Failure Events | 761 |

---

## 2. Failure Analysis

### Failures per Machine by Equipment Age

| Age | Machines | Failures | Failures / Machine |
|---:|---:|---:|---:|
| 0 | 1 | 4 | 4.00 |
| 1 | 3 | 17 | 5.67 |
| 2 | 6 | 38 | 6.33 |
| 3 | 4 | 25 | 6.25 |
| 4 | 3 | 19 | 6.33 |
| 5 | 4 | 21 | 5.25 |
| 6 | 4 | 26 | 6.50 |
| 7 | 6 | 32 | 5.33 |
| 8 | 1 | 5 | 5.00 |
| 9 | 5 | 24 | 4.80 |
| 10 | 10 | 53 | 5.30 |
| 11 | 2 | 11 | 5.50 |
| 12 | 2 | 9 | 4.50 |
| 14 | 14 | 145 | 10.36 |
| 15 | 6 | 56 | 9.33 |
| 16 | 5 | 51 | 10.20 |
| 17 | 7 | 59 | 8.43 |
| 18 | 6 | 60 | 10.00 |
| 19 | 4 | 38 | 9.50 |
| 20 | 7 | 68 | 9.71 |

Older equipment groups generally show higher failures per machine in this dataset.

---

## 3. Maintenance Analysis by Equipment Age

Maintenance activity was analyzed by equipment age to understand how frequently maintenance events were recorded across different age groups.

| Equipment Age | Machines | Maintenance Events | Maintenance per Machine |
|---:|---:|---:|---:|
| 0 | 1 | 33 | 33.00 |
| 1 | 3 | 106 | 35.33 |
| 2 | 6 | 190 | 31.67 |
| 3 | 4 | 129 | 32.25 |
| 4 | 3 | 91 | 30.33 |
| 5 | 4 | 118 | 29.50 |
| 6 | 4 | 126 | 31.50 |
| 7 | 6 | 204 | 34.00 |
| 8 | 1 | 37 | 37.00 |
| 9 | 5 | 180 | 36.00 |
| 10 | 10 | 343 | 34.30 |
| 11 | 2 | 65 | 32.50 |
| 12 | 2 | 62 | 31.00 |
| 14 | 14 | 457 | 32.64 |
| 15 | 6 | 185 | 30.83 |
| 16 | 5 | 156 | 31.20 |
| 17 | 7 | 219 | 31.29 |
| 18 | 6 | 204 | 34.00 |
| 19 | 4 | 131 | 32.75 |
| 20 | 7 | 250 | 35.71 |

### Interpretation

Maintenance events per machine remain within a relatively narrow range across the observed equipment-age groups. The highest recorded maintenance activity per machine is **37.00 events per machine** for age 8, while the lowest is **29.50 events per machine** for age 5.

These results describe recorded maintenance activity in the synthetic dataset and should not be interpreted as evidence that equipment age directly causes maintenance frequency.
---

## 4. Most Frequently Failing Components

| Machine | Component | Failure Count |
|---:|---|---:|
| 16 | Component 3 | 6 |
| 37 | Component 4 | 6 |
| 81 | Component 2 | 6 |
| 83 | Component 4 | 6 |
| 99 | Component 2 | 6 |
| 99 | Component 3 | 6 |

---

## 5. Failure-to-Maintenance Response

**Process:**

Failure → Same Machine → Same Component → Next Recorded Maintenance → Days to Maintenance

**Metric:**

> Time from a recorded failure to the next recorded maintenance event for the same machine and component.

This is not treated as MTTR because the dataset does not establish repair completion for the specific failure.

---

## 6. Component Response Time

| Component | Average Days to Maintenance |
|---|---:|
| Component 4 | 50.06 days |

---

## 7. Maintenance Coverage by Component

**Maintenance Coverage % = (Failures With Later Recorded Maintenance / Total Failures) × 100**

| Component | Total Failures | With Maintenance | Coverage |
|---|---:|---:|---:|
| Component 1 | 192 | 172 | 89.58% |
| Component 3 | 131 | 116 | 88.55% |
| Component 2 | 259 | 226 | 87.26% |
| Component 4 | 179 | 149 | 83.24% |

Component 4 has the lowest recorded maintenance coverage.

---

## 8. Error Frequency vs Failure Frequency

| Error Group | Error Count |
|---|---|
| Low | `< 35` |
| Medium | `35–44` |
| High | `45+` |

| Error Group | Machines | Total Errors | Total Failures | Avg Failures / Machine |
|---|---:|---:|---:|---:|
| Low | 23 | 690 | 106 | 4.61 |
| Medium | 57 | 2,254 | 452 | 7.93 |
| High | 20 | 975 | 203 | 10.15 |

Higher error-frequency groups show higher average failures per machine.

---

## 9. Error Frequency vs Time to Next Failure

| Error Group | Machines with Measurable Response | Avg Days to Next Failure |
|---|---:|---:|
| Low | 38 | 35.28 |
| Medium | 47 | 26.15 |
| High | 13 | 23.91 |

---

## 10. Error Type to Component Failure Association

| Error Type | Component | Failure Count | Component Failure % |
|---|---|---:|---:|
| error1 | comp1 | 386 | 42.75% |
| error1 | comp2 | 272 | 30.12% |
| error2 | comp2 | 474 | 53.14% |
| error3 | comp2 | 440 | 57.29% |
| error4 | comp2 | 199 | 31.29% |
| error4 | comp3 | 187 | 29.40% |
| error5 | comp4 | 186 | 55.69% |

---

## 11. Multi-Signal Maintenance Candidate Analysis

A candidate must satisfy:

- **Failure Count ≥ 3**
- **Average Days to Maintenance ≥ 60**
- **Machine Error Count ≥ 45**

These thresholds are project-defined analytical rules.

---

## 12. Maintenance Priority Classification

| Maintenance Coverage | Priority |
|---:|---|
| `< 80%` | High Attention |
| `80% to <100%` | Monitor |
| `100%` | Covered |

---

## 13. Final Decision Engine Results

**SQL View:** `vw_Equipment_Reliability_Priority`

| Metric | Result |
|---|---:|
| Priority Candidates | 13 |
| High Attention | 9 |
| Monitor | 1 |
| Covered | 3 |
| Average Failures per Candidate | 3.69 |
| Average Days to Maintenance | 79.81 |
| Average Maintenance Coverage | 77.95% |

**Analysis Unit:** `Machine + Component`

One machine can appear multiple times when multiple components satisfy the candidate rules.

---

## 14. High Attention Candidates

| Machine | Model | Age | Component | Failures | Avg Days | Errors | Coverage |
|---:|---|---:|---|---:|---:|---:|---:|
| 49 | model1 | 15 | comp3 | 4 | 80.00 | 51 | 75.00% |
| 22 | model1 | 14 | comp4 | 4 | 80.00 | 60 | 75.00% |
| 71 | model2 | 18 | comp4 | 4 | 70.00 | 45 | 75.00% |
| 52 | model3 | 14 | comp4 | 4 | 65.00 | 46 | 75.00% |
| 15 | model3 | 14 | comp4 | 3 | 172.50 | 51 | 66.67% |

---

## 15. Decision Engine Validation

### Machine-Component Uniqueness

```sql
SELECT
    machineID,
    component,
    COUNT(*) AS row_count
FROM vw_Equipment_Reliability_Priority
GROUP BY
    machineID,
    component
HAVING COUNT(*) > 1;
```

**Result:** `0 rows`

### Business Rule Validation

```sql
SELECT *
FROM vw_Equipment_Reliability_Priority
WHERE failure_count < 3
   OR avg_days_to_maintenance < 60
   OR error_count < 45;
```

**Result:** `0 rows`

### Priority Classification Validation

**Result:** `0 rows`

---

## 16. Main Analytical Findings

1. Older equipment groups generally show higher failures per machine.
2. Component 4 has the longest average recorded failure-to-maintenance response.
3. Component 4 has the lowest recorded maintenance coverage.
4. Higher error-frequency groups show higher average failures per machine.
5. Error types show different distributions of subsequent recorded component failures.
6. The analysis identified 13 machine-component priority candidates.
7. 9 candidates were classified as `High Attention`.
8. The final decision view passed all validation checks.

---

## 17. Technical Workflow

**Raw Dataset**  
↓  
**Data Validation**  
↓  
**Data Modeling**  
↓  
**Reliability Analysis**  
↓  
**Failure Analysis**  
↓  
**Maintenance Analysis**  
↓  
**Error Analysis**  
↓  
**Chronological Event Matching**  
↓  
**Multi-Signal Candidate Detection**  
↓  
**Maintenance Priority Classification**  
↓  
**Reusable SQL View**

---

## 18. Key SQL Techniques

- Aggregation
- CTEs
- `INNER JOIN`
- `LEFT JOIN`
- `OUTER APPLY`
- `TOP 1`
- `DATEDIFF`
- `COUNT`
- `COUNT(DISTINCT)`
- `SUM`
- `AVG`
- `CASE`
- `CAST`
- `DECIMAL`
- `ISNULL`
- `GROUP BY`
- `HAVING`
- Views
- Data validation
- Business-rule validation
- Chronological event matching

---

## 19. Limitations

- Synthetic predictive-maintenance dataset.
- The results should not be treated as real-world production or operational findings.
- Maintenance records are not explicitly linked to individual failures.
- The next maintenance event is used as a chronological proxy.
- Failure-to-maintenance response time is not MTTR.
- Error-to-failure relationships represent temporal association, not causation.
- Priority thresholds are project-defined.
- Small equipment groups can produce unstable percentages.
- The decision engine is rule-based, not a machine-learning prediction model.

---

## 20. Final Project Output

**Equipment + Errors + Failures + Maintenance + Equipment Age**

↓

**Reliability Intelligence**

↓

**Maintenance Priority**

### Primary Output

`vw_Equipment_Reliability_Priority`

The view provides a structured machine-component level summary for downstream reporting, analysis, and future predictive-maintenance models.
# Business Questions

This project uses SQL-based industrial reliability analysis to answer business questions related to equipment failures, maintenance activity, error events, equipment age, and maintenance response.

---

## 1. Equipment Reliability

### Q1. Which equipment has the highest number of recorded failures?

Identify machines with the highest recorded failure counts to understand where failure events are concentrated.

### Q2. Which equipment has the highest number of recorded errors?

Identify machines with the highest error-event frequency.

### Q3. Which equipment has the highest maintenance activity?

Identify machines with the highest number of recorded maintenance events.

### Q4. Which component has the highest number of recorded failures?

Analyze failure events by component to understand component-level failure frequency.

### Q5. How does equipment age relate to failure frequency?

Compare the number of failures across different equipment-age groups.

### Q6. How does equipment age relate to maintenance activity?

Compare maintenance events per machine across different equipment-age groups.

---

## 2. Failure Analysis

### Q7. Which machine/component combinations experience repeated failures?

Identify equipment and components with multiple recorded failure events.

### Q8. How long after a recorded failure is the next corresponding maintenance event recorded?

For each failure, identify the earliest later maintenance event for the same machine and component.

The analysis uses the recorded event sequence and calculates the number of days between the failure and the next recorded maintenance event.

### Q9. Which component has the longest average recorded failure-to-maintenance response?

Compare the average recorded response time across components.

### Q10. Which repeated failures also have prolonged recorded maintenance response?

Identify machine/component combinations meeting the project-defined conditions:

- At least 3 recorded failures
- Average recorded failure-to-maintenance response of at least 60 days

---

## 3. Maintenance Analysis

### Q11. What percentage of recorded failures are followed by a corresponding maintenance event?

Calculate maintenance coverage for each component.

### Q12. Which machines have lower recorded maintenance coverage following failures?

Calculate maintenance coverage at the machine level to identify equipment requiring further analysis.

### Q13. How do maintenance events compare with failure events by machine and component?

Compare recorded maintenance and failure event counts for the same machine/component combinations.

This is used as a supporting analysis and does not establish that a specific maintenance event repaired a specific failure.

### Q14. Are there recorded failures without a later corresponding maintenance event?

Identify failure events for which no later maintenance event for the same machine and component was recorded.

---

## 4. Error and Failure Analysis

### Q15. Is higher error frequency associated with higher failure frequency?

Compare machine error counts with recorded failure counts.

The analysis is descriptive and identifies association within the dataset; it does not establish causation.

### Q16. How does failure frequency vary across error-frequency groups?

Machines are grouped based on recorded error frequency:

| Error Group | Error Count |
|---|---:|
| Low | < 35 |
| Medium | 35–44 |
| High | 45+ |

The average recorded failures per machine are then compared across these groups.

### Q17. How much time passes between an error event and the next recorded failure?

For each error event, identify the next recorded failure for the same machine and calculate the number of days between the two events.

### Q18. Which component failures are associated with different error types?

Analyze the relationship between error types and the next recorded component failure.

This analysis identifies event associations and does not establish that an error caused a particular component failure.

---

## 5. Maintenance Decision Analysis

### Q19. Which machine/component combinations meet multiple reliability warning conditions?

Identify combinations satisfying all three project-defined conditions:

- Failure count >= 3
- Average recorded failure-to-maintenance response >= 60 days
- Error count >= 45

This creates the candidate population for the maintenance decision engine.

### Q20. What is the recorded maintenance coverage for these candidates?

Calculate the percentage of candidate failures followed by a corresponding maintenance event.

### Q21. How should candidate machine/component combinations be classified?

The project applies the following analytical classification:

| Maintenance Coverage | Classification |
|---:|---|
| < 80% | High Attention |
| 80% to <100% | Monitor |
| 100% | Covered |

These thresholds are project-defined analytical rules and are not presented as industry-standard thresholds.

---

## 6. Decision Engine Output

The final decision engine combines multiple signals:

```text
Failure Frequency
        +
Recorded Maintenance Response
        +
Error Frequency
        +
Maintenance Coverage
        ↓
Maintenance Priority Classification
```

The resulting output provides a reusable machine/component-level reliability view containing:

- Machine ID
- Machine model
- Equipment age
- Component
- Failure count
- Average recorded maintenance response
- Error count
- Maintenance coverage percentage
- Maintenance priority

---

## 7. Analytical Limitations

The analysis is based on recorded events in a synthetic predictive-maintenance dataset.

The project does not claim that:

- A maintenance event definitively repaired a particular failure.
- The recorded response time represents MTTR.
- An error event caused a subsequent failure.
- The project-defined thresholds represent industry standards.
- The dataset is synthetic predictive-maintenance data and should not be interpreted as real-world production or operational performance data.

The purpose of the analysis is to demonstrate SQL-based industrial reliability analysis, event-sequence analysis, maintenance coverage analysis, and a transparent decision-engine approach.
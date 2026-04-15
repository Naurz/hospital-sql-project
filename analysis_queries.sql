-- Department revenue
SELECT department, SUM(cost) AS total_revenue
FROM appointments
GROUP BY department;

-- Patients per department
SELECT department, COUNT(DISTINCT patient_id) AS total_patients
FROM appointments
GROUP BY department;

-- Top spending patient
SELECT patient_id, SUM(cost) AS total_cost
FROM appointments
GROUP BY patient_id
ORDER BY total_cost DESC
LIMIT 1;

-- Latest appointment per patient
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY patient_id
               ORDER BY appointment_date DESC
           ) AS rn
    FROM appointments
) t
WHERE rn = 1;

-- Cost ranking per patient
SELECT patient_id, cost,
       RANK() OVER (
           PARTITION BY patient_id
           ORDER BY cost DESC
       ) AS rnk
FROM appointments;

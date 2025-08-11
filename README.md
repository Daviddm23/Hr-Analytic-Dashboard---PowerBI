# HR-Analytics-PowerBI-Dashboard

This is an interactive HR Analytics Dashboard built in Power BI using a dataset created by me in R to simulate realistic HR data.  
The dashboard provides a comprehensive view of workforce demographics, salaries, performance, and attrition insights, allowing HR teams to make data-driven decisions.

---

## What’s Included in the Dashboard?

- **Total Employees** – Interactive KPI card that updates based on filters.
- **Average Monthly Income** – KPI card that changes dynamically with selections.
- **Average Performance Rating** – KPI card responsive to filters.
- **Average Job Satisfaction** – KPI card responsive to filters.
- **Gender Distribution** – Interactive chart that changes based on office, role, and age filters.
- **Age Distribution** – Bar chart showing employee counts by age groups.
- **Job Role Composition** – Distribution of employees across job roles.
- **Years at Company vs Attrition** – Visual showing tenure distribution and attrition counts.
- **Geographic Office Map** – Circle size proportional to the number of employees per office.
- **Attrition Key Influencers** – Visual showing main factors correlated with attrition (e.g., overtime, tenure, job satisfaction).

> *See the pdf later for a preview of the dashboard*  
> *A full walkthrough video is also available in this repository*
> *The Code used to create the dataset and the dataset itself is also included in the repository*
 
---

## Dataset Overview

The dataset contains 1500 employees and was generated in R to reflect realistic HR scenarios.  
It includes variables often used in People Analytics and employee lifecycle analysis.

### Variables Included
- `Name`: Employee initials  
- `Office`: Location (Milan, Berlin, Rome, Munich, Vienna)  
- `Age`, `AgeGroup`  
- `Attrition`: Yes/No  
- `BusinessTravel`  
- `DailyRate`  
- `Department`  
- `TravelDistance`  
- `Education`, `EducationField`  
- `EmployeeNumber`  
- `Gender`  
- `JobLevel`, `JobRole`  
- `MaritalStatus`  
- `StockOptionLevel`  
- `MonthlyIncome`  
- `NumCompaniesWorked`  
- `OverTime`  
- `PercentSalaryHike`  
- `PerformanceRating`  
- `YearsAtCompany`, `YearsInCurrentRole`, `YearsSinceLastPromotion`, `YearsWithCurrManager`  
- `TotalWorkingYears`  
- `RelationshipSatisfaction`  
- `TrainingTimesLastYear`  
- `WorkLifeBalance`  
- `JobSatisfaction`  
- `EnvironmentSatisfaction`  
- `JobInvolvement`

---

## Key Insights from the Dashboard
- **Early tenure attrition**: Employees with ≤ 2 years at the company are 2.02x more likely to leave.
- **Burnout risk**: Employees working overtime are 1.62x more likely to leave.
- **Late-career exits**: Employees with 26–35 years at the company have a 1.59x higher attrition likelihood.
- **Low satisfaction impact**: Job satisfaction ≤ 3 increases attrition by 1.25x.


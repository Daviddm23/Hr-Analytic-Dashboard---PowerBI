library(truncnorm)
set.seed(123)

n <- 1500
active_count <- 1275

# EmployeeNumber
EmployeeNumber <- sample(100000:999999, n, replace = FALSE)

# Name
Name <- paste0(sample(LETTERS, n, replace = TRUE),
               sample(LETTERS, n, replace = TRUE))

# Office
cities <- c("Milan", "Berlin", "Rome", "Munich", "Vienna")
Office <- sample(cities, n, replace = TRUE, prob = c(0.4, 0.2, 0.1, 0.15, 0.15))

# Age
Age <- round(rtruncnorm(n, a = 18, b = 65, mean = 36.2, sd = 10))
AgeGroup <- cut(Age, breaks = c(0, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65),
                labels = c("20", "25", "30", "35", "40", "45", "50", "55", "60", "65"),
                include.lowest = TRUE)

# Years at company
YearsAtCompany <- pmin(Age - 18, sample(0:40, n, replace = TRUE))

# Departments: equilibrar por ciudad
departments <- c("IT", "Sales", "Human Resources", "Research & Development", "Operations")
Department <- unlist(lapply(table(Office), function(n_city) {
  rep_len(departments, n_city)
}))
Department <- sample(Department) # Mezclar

# Gender
Gender <- ifelse(Department == "Human Resources",
                 sample(c("Male", "Female"), n, replace = TRUE, prob = c(0.3, 0.7)),
                 sample(c("Male", "Female"), n, replace = TRUE, prob = c(0.62, 0.38)))

# Travel
BusinessTravel <- sample(c("Travel_Rarely", "Travel_Frequently", "Non-Travel"), n, replace = TRUE,
                         prob = c(0.3, 0.1, 0.6))
TravelDistance <- sample(5:50, n, replace = TRUE)

# Education
Education <- ifelse(Age <= 20, "High School Diploma",
                    ifelse(Age > 45 & runif(n) < 0.3, "PhD",
                           sample(c("Bachelors Degree", "Masters Degree"), n, replace = TRUE, prob = c(0.6, 0.4))))
EducationField <- sample(c("Life Sciences", "Technical Degree", "Medical", "Other", "Marketing"), n, replace = TRUE)
# Corregir campo de estudio si solo tiene High School
EducationField[Education == "High School Diploma"] <- "Other"


# Job
JobLevel <- sample(1:5, n, replace = TRUE, prob = c(0.4, 0.3, 0.15, 0.1, 0.05))
job_roles <- c("Software Engineer", "Research Scientist", "HR Specialist", "Sales Executive", "Manager", "Data Scientist", "Lab Technician")
JobRole <- sample(job_roles, n, replace = TRUE)

# MaritalStatus
MaritalStatus <- ifelse(Age < 25, "Single",
                        ifelse(Age < 35,
                               sample(c("Single", "Married"), n, replace = TRUE, prob = c(0.5, 0.5)),
                               sample(c("Married", "Divorced"), n, replace = TRUE, prob = c(0.7, 0.3))))

# OverTime
OverTime <- sample(c("Yes", "No"), n, replace = TRUE, prob = c(0.25, 0.75))

# Satisfaction & performance
JobSatisfaction <- sample(1:5, n, replace = TRUE, prob = c(0.02, 0.1, 0.3, 0.4, 0.18)) # Media ≈ 3.72
PerformanceRating <- sample(c(3, 4, 5), n, replace = TRUE, prob = c(0.05, 0.6, 0.35)) # Media ≈ 4.12

# Otros ratings
RelationshipSatisfaction <- sample(1:5, n, replace = TRUE)
TrainingTimesLastYear <- sample(0:6, n, replace = TRUE)
WorkLifeBalance <- sample(1:4, n, replace = TRUE)
EnvironmentSatisfaction <- sample(1:5, n, replace = TRUE)
JobInvolvement <- sample(1:5, n, replace = TRUE)

# Ingresos ajustados: ciudad + departamento + educación + edad
base_income <- 2500
city_multipliers <- c("Munich" = 1.6, "Berlin" = 1.4, "Vienna" = 1.2, "Milan" = 1.0, "Rome" = 0.95)
dept_multipliers <- c("IT" = 1.2, "Sales" = 1.1, "Human Resources" = 1.0, 
                      "Research & Development" = 1.4, "Operations" = 1.15)
edu_bonus <- ifelse(Education == "High School Diploma", 0,
                    ifelse(Education == "Bachelors Degree", 2000,
                           ifelse(Education == "Masters Degree", 4000, 7000)))

age_bonus <- (Age - 18) * 40  # +40 por año de edad más allá de 18

MonthlyIncome <- round(base_income * city_multipliers[Office] * dept_multipliers[Department] +
                         edu_bonus + age_bonus + rnorm(n, 0, 500), 0)

# Otros
DailyRate <- sample(100:1500, n, replace = TRUE)
StockOptionLevel <- sample(0:3, n, replace = TRUE, prob = c(0.4, 0.3, 0.2, 0.1))
PercentSalaryHike <- sample(10:25, n, replace = TRUE)
NumCompaniesWorked <- ifelse(Age < 25, sample(0:2, n, replace = TRUE), sample(1:6, n, replace = TRUE))

YearsInCurrentRole <- pmin(YearsAtCompany, sample(0:10, n, replace = TRUE))
YearsSinceLastPromotion <- pmin(YearsAtCompany, sample(0:10, n, replace = TRUE))
YearsWithCurrManager <- pmin(YearsAtCompany, sample(0:10, n, replace = TRUE))
TotalWorkingYears <- YearsAtCompany + sample(0:5, n, replace = TRUE)

# Probabilidad de attrition
attrition_prob <- ifelse(YearsAtCompany < 3, 0.4,
                         ifelse(YearsAtCompany > 25, 0.3, 0.15))
attrition_prob <- attrition_prob + ifelse(OverTime == "Yes", 0.15, 0)
attrition_prob <- attrition_prob + ifelse(JobSatisfaction <= 2, 0.15, 0)
attrition_prob <- attrition_prob + ifelse(MaritalStatus == "Single", 0.1, 0)
Attrition <- ifelse(runif(n) < attrition_prob, "Yes", "No")

# DataFrame final
df_powerbi_HRAnalytics <- data.frame(Name, Office, Age, AgeGroup, Attrition, BusinessTravel, DailyRate, Department,
                 Traveldistance = TravelDistance, Education, EducationField, EmployeeNumber,
                 Gender, JobLevel, JobRole, MaritalStatus, StockOptionLevel, MonthlyIncome,
                 NumCompaniesWorked, OverTime, PercentSalaryHike, PerformanceRating,
                 YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion,
                 YearsWithCurrManager, TotalWorkingYears, RelationshipSatisfaction,
                 TrainingTimesLastYear, WorkLifeBalance, JobSatisfaction,
                 EnvironmentSatisfaction, JobInvolvement)


my.path <- "/Users/daviddardon/Desktop/2025"

setwd(my.path)  # Cambias el directorio de trabajo


write_xlsx(df_powerbi_HRAnalytics, "data_dashboard_powerbi.xlsx")  # Guardas el archivo en esa carpeta

library(lme4)
library(performance)
library(lmerTest)

## Read the csv file
df_wvs_wb <- read.csv(file_path)

## Define a function to fit and summarize linear mixed-effects models (NON-CENTERED IVs)
fit <- function(dv, data) {
  ### Construct the formula using the specified dependent variable
  formula <- reformulate(c(
    "sub_class_recoded", "age", "income", "gender_recoded", "marital_binary", 
    "employment_binary", "hs_binary", "gini", "gdp_2015usd", "total_pop", 
    "pop_density", "poverty_ratio", "unemployment", "year", 
    "(1|country_iso)", "(1|country_iso:year)"
  ), response = dv)
  
  ### Fit the linear mixed-effects model
  model <- lmer(formula, data = data, REML = FALSE)
  
  ### Summarize the model
  model_summary <- summary(model)
  
  ### Calculate the ICC
  icc_val <- icc(model)
  
  ### Return the model summary and ICC value as a list
  return(list(model_summary = model_summary, icc = icc_val))
  }
  
  
## Call the function with different dependent variables
r_general_trust <- fit("social_trust_recoded", df_wvs_wb)
r_family_trust <- fit("trust_family_recoded", df_wvs_wb)
r_neighbor_trust <- fit("trust_neighborhood_recoded", df_wvs_wb)
r_acq_trust <- fit("trust_personal_known_recoded", df_wvs_wb)
r_stranger_trust <- fit("trust_first_time_recoded", df_wvs_wb)
r_diff_religion_trust <- fit("trust_diff_religion_recoded", df_wvs_wb)
r_diff_country_trust <- fit("trust_diff_country_recoded", df_wvs_wb)
  
## Access the model summary and ICC value
### general trust
print(r_general_trust$model_summary)
print(r_general_trust$icc)

### trust in family
print(r_family_trust$model_summary)
print(r_family_trust$icc)

### trust in neighborhood
print(r_neighbor_trust$model_summary)
print(r_neighbor_trust$icc)

### trust in people personally known
print(r_acq_trust$model_summary)
print(r_acq_trust$icc)

### trust in people first time meet
print(r_stranger_trust$model_summary)
print(r_stranger_trust$icc)

### trust in people with a different religion
print(r_diff_religion_trust$model_summary)
print(r_diff_religion_trust$icc)

### trust in people from a different country
print(r_diff_country_trust$model_summary)
print(r_diff_country_trust$icc)

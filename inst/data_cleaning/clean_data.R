##Script for cleaning NHANES data
library(NHANES)
library(tidyverse)
data("NHANES")

##Build Diabetes dataset
##show there is an association between BMI and diabetes
NHANES %>% select(BMI, Diabetes, Gender) %>% ggplot(aes(x=Diabetes, y=BMI)) + geom_boxplot() + facet_wrap(~Gender)

##Bin Data into High (> 30) and Low BMI (<=30)
bmi_diabetes <- NHANES %>% select(BMI,Diabetes, Gender, Age) %>% filter(Age > 20) %>%
  mutate(BMIstatus=ifelse(BMI > 30, "High", "Low"), BMIstatus=as.factor(BMIstatus))

bmi_diabetes %>% ggplot(aes(x=Diabetes, fill=BMIstatus)) +
  geom_bar(position="fill", color="black") + facet_wrap(~Gender)

devtools::use_data(bmi_diabetes)

library(readxl)
library(tidyverse)

DI_Activity <- read_excel("data/2021-21 Brett Johnson DI Activity.xlsx") %>% 
  mutate(active = case_when(Status == "Active" ~ 1,
                             Status == "Fallow" ~ 0)) 

month_summary <- DI_Activity %>%  
  group_by(`Reporting Year`, `Reporting Period`) %>% 
  summarize(sum = sum(active)) %>% 
  ungroup() %>% 
  pivot_wider(names_from = `Reporting Period`, values_from = sum)

year_summary <- DI_Activity %>% 
  group_by(`Reporting Year`) %>% 
  summarize(sum = sum(active)/3)
  
previous_years_summary <- year_summary %>% 
  filter(`Reporting Year` != 2021)

mean(previous_years_summary$sum)

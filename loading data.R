#Step 1: 
## Create folder in AWS

#Step 2: 
## Upload file: 
##S:\PerformanceManagementGroup\Workforce Planning and Analysis\Workforce Strategy\Examination of sources of workforce data\SOP and Data Quality\WfPT\September 2022\Python Version
##Try your own later this week

#Step 3: 
#Use the "Copy S3 URI" button to get that link


#Step 4:
#Install other packages not in Intialisation.R file
install.packages("ggplot2")
install.packages("plotly")
install.packages("janitor")



#Step 5:
##Run libraries
library(botor)
library(ggplot2)
library(plotly)
library(janitor)
#comment
#New work

#Step 6:
##Load data into R
df1 <- s3_read(uri = "s3://alpha-piatool/sopdq_AV/inputs/WFPT Staff Data Jul22.csv", read_csv) %>% 
  mutate(months_sop = "July")
df2 <- s3_read(uri = "s3://alpha-piatool/sopdq_AV/inputs/WFPT Staff Data Aug22.csv", read_csv) %>% 
  mutate(months_sop = "August")
df3 <- s3_read(uri = "s3://alpha-piatool/sopdq_AV/inputs/WFPT Staff Data Sep22.csv", read_csv) %>% 
  mutate(months_sop = "September")
 
#Step 7: 
## Manipulate data
df1_tidied <- df1 %>% 
  janitor::clean_names()


df_combined <- df1_tidied %>% 
  bind_rows(df2, df3) %>% 
  group_by(area_directorate, months_sop) %>% 
  summarise(count_staff = n())

ggplot(data = df_combined, mapping = aes(area_directorate, count_staff))+
  geom_col()+
  facet_wrap(~months_sop)

  



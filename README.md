
COHORT ANALYSIS (Retention Rate)


Table of Contents
Introduction
Problem Statement
Data source and loading
Data cleaning
Cohort analysis (retention rate) using mysql server
Visualization using tableau and Insights


INTRODUCTION
What is cohort analysis?
Cohort analysis is a type of behavioral analytics in which you take a group of users, and analyze their usage patterns based on their shared traits to better track and understand their actions. A cohort is simply a group of people with shared characteristics. 

Cohort analysis allows you to ask more specific, targeted questions and make informed product decisions that will reduce churn and drastically increase revenue. You could also call it customer churn analysis.


Types of cohort analysis:
The 2 most common types of cohorts are:

Acquisition cohorts: Groups divided based on when they signed up for your product. Typically, the shared characteristics of this group of users offers an opportunity to measure retention and churn rates within a specific timeframe. 
Behavioral cohorts: Groups divided based on their behaviors and actions in your product. This type allows you to view your active users in different demographics and with different behavioral patterns.


PROBLEM STATEMENT:
To determine the retention rate of customers in an online retail store.

DATA SOURCE AND LOADING:

The data source is UCI Machine Learning Repository and the dataset named "online retail store". After downloading the data, I loaded it into microsoft sql server  through Microsoft SQL Server Integration Services. A data integration, transformation and migration tool used to extract, transform and load data.

DATA CLEANING:
Data cleaning was done in microsoft sql server and it involved removing rows with customer ID equals to zero. Since this is a unique number given to every customer, zero values means  null values. Secondly, I removed the rows where the values of price and quantity are negative. Negative values could mean product returns, error while entering e.t.c. Thirdly, I checked for duplicate entries and dropped the rows. The cleaned data was selected into a temp table.


COHORT ANALYSIS(RETENTION RATE):
To perform cohort analysis, I created a cohort using customer ID as the unique identifier, first invoice date as initial start date and revenue data. I used DATAFROMPARTS function to extract the year and month from the invoice date according the customer's first purchase. To calculate the cohort index, which is the integer representation of the months since the customer's first purchase, I used this formula;

cohort index = year difference * 12 + month difference + 1

year difference = cohort year(first year of purchase) - invoice year(whenever the customer revisited)

month difference = cohort month(first year of purchase) - invoice month(whenever the customer revisited)

VISUALIZATION WITH TABLEAU:

click on this site

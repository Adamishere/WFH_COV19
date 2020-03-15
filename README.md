# Effects of working from home >1 days a week on time a sick person is in the office
## Purpose:
In 2020, the COVID-19 pandemic caused many companies to instruct employees to work from home to avoid spreading the disease. Some companies more restrictive work-from-home policies and still required some presense in a physical office throughout the week. However, COVID-19 infections can largely be asymptomatic for several days while still being contagious and as a result, while an employee may not appear to be sick, they can still infect others for several days before they can self-quarantine.

## Question:
Under the assumption that you can only pick a few days out of the week to work from home: 

* Do more days working from home reduce the time a sick person would be in the office? If so, by how much?
* What would be the best days to be out of the office to minimize the spread of the disease? 

## Description:
This program simulates a 5 day work week, with Saturday and Sunday off. Using incubation period models from recent research which suggest a [log-normal incubation time](https://annals.org/aim/fullarticle/2762808/incubation-period-coronavirus-disease-2019-covid-19-from-publicly-reported) (approximately a mean of 5 days), this program simulates:

* Random day of infection
* Random incubation period from log-normal model
* Length of time an employee would be in the office before symptoms appear

In the simulation, I test several scenarios:

* No work from home (Monday - Friday in the office)
* One day work from home (every combination)
* Multiple days work from home

Each scenario and test combination was tested with 15,000 iterations

# Results
## Does working from home reduce the number of days a sick person is in the office?
On average, a person would spend 4 days in the office before they would realize they are sick (and hopefully self-quarantine)

Below is the summary statistics for a traditional work week (M-F, weekends off)

       Min.   1st Qu.  Median    Mean    3rd Qu.    Max. 
       0.000  3.000    4.000     3.925   5.000      21.000 

For comparison, with working from home one day a week (any day), we see the mean time a person is sick in the office is 3.2 days.

       Min.    1st Qu.  Median    Mean    3rd Qu.    Max. 
       0.000   2.000    3.000     3.157   4.000      16.000 

This difference is signifcant at p<0.0001 level.

Additionally, when simulating additional days out of the office, mean time of an employee being sick in the office is reduced linearly by 1 day, for each work from home day added.

    #0 WFH days
    Min.    1st Qu.  Median    Mean    3rd Qu.    Max. 
    0.000   3.000    4.000     3.925   5.000      21.000 
    
    #1 WFH days
    Min.    1st Qu.  Median    Mean    3rd Qu.    Max. 
    0.000   2.000    3.000     3.167   4.000      17.000 
    
    #2 WFH days
    Min.    1st Qu.  Median    Mean    3rd Qu.    Max. 
    0.000   1.000    3.000     2.357   3.000      9.000 
    
    #3 WFH days
    Min.    1st Qu.  Median    Mean    3rd Qu.    Max. 
    0.00    1.00     2.00      1.58    2.00       7.00 

## Does the specific day you work from home matter?

This question arises due to the idea that you potentially have a longer time out of the office if your WFH day is on a Friday or Monday, results in 3 full days out of the office. This longer period out of the office maybe give an employee more time to develop symptoms outside of work.

The results of the simulation suggest that there is no significant difference in time in the office between days:

    Pairwise comparisons using t tests with pooled SD 
       M    Tu    W    Th   F
    M  -    -     -    -    -
    Tu 1.00 -     -    -    -   
    W  1.00 1.00  -    -    -   
    Th 0.42 1.00  1.00 -    -   
    F  1.00 1.00  1.00 0.82 -
    
    P value adjustment method: holm 

The average time a sick person is in the office is effectively the same across all work from home days.


# Conclusions

This simulation shows that for reducing the spread of the COVID-19 virus, working from home can reduce the changes an employee infects their coworkers before they are symptomatic. The more days working from home, the less time an infected employee spends in the office. It also doesn't matter what day you chose.



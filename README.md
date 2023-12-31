# Introduction

## Goal
In this supplementary analysis, integral to my overarching research into the consequences of economic inequality, I explored the relationship between economic inequality—quantified by the Gini coefficient—and diverse facets of trust. These facets encompass a spectrum of dimensions, including general trust, trust in family, trust in the neighborhood, trust in people known personally, trust in people meeting for the first time, trust in people of another religion, and trust of another nationality.  

## Data

### World Value Survey (WVS) Data
I gathered individual-level trust data encompassing all the aforementioned dimensions from the World Values Survey (WVS) spanning the years 2005 to 2022. The rationale for selecting this time frame is that earlier waves of the survey only assessed general trust and lacked the granularity to explore various facets of trust in detail. Trust is measured on a four-point scale, recoded as 1 = do not trust at all, 4 = completely trust) Meanwhile, I collected a set of individual-level covariates, including subject social class (1 = lower class, 5 = upper class), age, income (1 = the bottom 10th percentile, 10 = the top 10th percentile), gender (0 = female, 1 = male), marital status (recoded as 0 = not married, 1 = married), employment (recoded as 0 = unemployed, 1 = employed), highest education attainment (recoded as 0 = less than high school, 1 = high school graduate or above) and political ideology (1 = far left, 10 = far right). 

### World Bank (WB) Data
Next, I collected the country-year Gini index (1 = perfect equal, 100 = perfectly unequal; M = 37.69, SD = 7.52) from World Bank for the years 2005 to 2022. Meanwhile, I collected a set of country-year level covariates, including GDP (in constant 2015 USD), total population, population density (people per sq. km of land area), poverty ratio (i.e., poverty headcount ratio at $2.15 a day (2017 PPP), and unemployment rate (national estimate).

### Master Dataset
Finally, I merged the two datasets based on the country and year. This master dataset consists of 256,871 responses from 49 countries for 17 years. Note that the missing value for each variable is different, and the final sample size for the statistical analysis sees the Table below:

| Trust Dimension          | Number of Observations |
|--------------------------|------------------------|
| General                  | 92,049                 |
| Family                   | 93,841                 |
| Neighborhood             | 93,238                 |
| Acquaintance             | 93,487                 |
| Stranger                 | 92,348                 |
| Different Religion       | 88,060                 |
| Different Nationality    | 88,150                 |

The data collection and wrangling refer to the Python Notebook ```wvs_wb_data_processing```.

## Statistical Analysis
I employed the three-level multi-level modeling, treating individual responses (level 1, N refers to the table above) as nested in country-year (level 2, N = 80), which were themselves nested countries (level 3 factor, N = 49). The focal predictor is the country-year Gini index at level 2 and the focal outcome variable is the trust (in various aspects) at level 1. Meanwhile, we included country-year covariates at level 2 and individual-level covariates at level 1. Formally:

$Trust_{ikl} = β_{000} + β_{100} * SCO_{ikl} + β_{200} * Age_{ikl} + β_{300} * Gender_{ikl} + β_{400} * Marital_{ikl}$ 
            $+ β_{500} * Employment_{ikl} + β_{600} * M_{ikl} + β_{700} * Education_{ikl} + β_{800} * Ideogloy_{ikl}$ 
            $+ β_{010} * Gini_{kl} + β_{020} * Gdp_{ikl} + β_{030} * Population_{kl} + β_{040} * Density_{kl}$ 
            $+ β_{050} * Poverty_{kl} + β_{060} * Unemployment_{tkl} + β_{070} * Year_{kl}$ 
            $+ v_{l} + u_{kl} + e_{ikl}$

Which is equivalent to:

$Trust_{ikl} = β_{000} + β_{010}*Gini_{kl} * β_{m00} * L1COV_{ikl} + β_{0n0} * L2COV_{kl}$ 
                      $+ v_{l} + u_{kl} + e_{ikl}$


Where:
- $i$ represents the $i$ th individual ($i$ = 1, 2, ...,  256,871);
- $k$ represents the $k$ th country-year ($k$ = 1, 2, ..., 80);
- $j$ represents the $j$ th country ($j$ = 1, 2, ..., 49);
- $m$ represents the $m$ th level 1 covariates ($m$ = 1, 2, ..., 8);
- $n$ represents the $m$ th level 1 covariates ($n$ = 2, 3, ..., 7);
- $v_{l}$ is the level 3 residuals;
- $u_{kl}$ is the level 2 residuals;
- $e_{ijk}$ is the level 1 residuals.

The data analysis refers to the R script```wvs_wb_data_analysis```.

## Results
Economic inequality undermines people's trust in all aspects except for their trust in people of another region (see the table below).

|       DV         |M (SD) of DV | Gini   |
|------------------|-------------|--------|
| General          | 3.25 (.43)  | -.014***|
| Family           | 3.77 (.52)  | -.0071***|
| Neighborhood     | 2.85 (.81)  | -.018***|
| Acquittance      | 2.96 (.79)  | -.022***|
| Stranger         | 1.97 (.80)  | -.017***|
| Of another religion |2.31 (.86)| -.0049ns|
| Of another nationality |2.21 (.87)| -.018**|

<i> *** denotes p < .001, ns denotes p > .05 <i>


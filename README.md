## Project 2 - Predictive Modeling for Stat 159 ##
Authors: Dakota Lim & Kartikeya Gupta

This is project 2 for Stat 159 with Prof. Gaston Sanchez. It is based on Chapter 6 of Introduction to Statistical Learning which focuses on exploring a relationship between the averge credit debt across people to a set of explanatory variables.  

The project is done in R, managed through git and github and incorporates markdown, pandoc and some bash.   

The structure of this project is as follows:  

stat159-fall2016-project2/  
...README.md  
...Makefile  
...LICENSE  
...session-info.txt  
...gitignore  
...code/  
......functions/  ...  
......scripts/ ...  
......tests/ ...  
...data/  
......Credit.csv  ...   
...images/ ...   
...report/    
......report.pdf  
......report.Rmd  
......sections/  
.........00-abstract.Rmd  
.........01-introduction.Rmd  
.........02-data.Rmd  
.........03-methods.Rmd  
.........04-analysis.Rmd  
.........05-results.Rmd  
.........06-conclusions.Rmd  
...slides/ ...  


All the code is store in the code/ folder which is subdivided into scripts, functions and tests.
The dataset and other data generated through the scripts is stored in the data/ folder.
The report folder contains the .rmd files that build the report. For reproducibility and collaboration, the paper is divided into sections which are then combined into one .RMD file.
The slides for the report are contained within the slides/ folder.

This project is created in a way so that it can be completely reproduced. Hence, the code and the dataset are available for use. 

The Makefile can essentially reproduce the whole analysis. The Makefile phony targets are:

- all: To run the complete analysis.  
- data: To download the dataset from the website http://www-bcf.usc.edu/~gareth/ISL/Credit.csv  
- tests: To run tests on functions to check for correct output.  
- regressions: To run all the 5 types of regressions.  
- ols: To run OLS Regression  
- ridge: To run Ridge Regression  
- lasso: To run Lasso Regression  
- pcr: To run Principle Component Regression    
- plsr: To run Partial Least Sqaures Regression  
- report: To execute and combine all the section RMD files into a Report.Rmd  
- slides: To generate slides.html  
- session: To generate the session-info.txt and session.sh that document the session information.  
- clean: To delete the report file.  
- cleanall: To delete all the .pdf, .Rdata, .txt and images produced by the project scripts and functions.  

I hope that you enjoy reading through the project and that it's convenient for you to reproduce the project. 

Finally, the code for this open-source project is licensed through the MIT Open Source License. And the media content is licensed through Creative Commons 4.0.

Stat 159 - Project 2 (c) by Dakota Lim & Kartikeya Gupta

[![Creative Commons
License](https://i.creativecommons.org/l/by/4.0/88x31.png)](http://creativecommons.org/licenses/by/4.0/)
This work is licensed under a [Creative Commons Attribution 4.0
International License](http://creativecommons.org/licenses/by/4.0/).

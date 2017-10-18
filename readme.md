## Tutorial for OHSU Data Science Institute

By Jessica Minnier and Ted Laderas

This is the repository for the Exploratory Data Analysis and Statistics workshops for the OHSU Data Science Institute.

To run this, you'll need to do the following:
```{r}
install.packages("devtools")
library(devtools)
install_github("laderast/DSIExplore")
learnr::run_tutorial("categoricalDats", package = "DSI_explore1")
```
This material is released under an Apache 2.0 License

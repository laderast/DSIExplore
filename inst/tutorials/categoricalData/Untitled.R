```{r}
sliderInput(inputId = "samp_n", label = "N in study",min = 10, max=1000, value = 500)
checkboxInput(inputId = "samp_check", label="Show proportions", value=FALSE)
plotOutput("plot_n_bar")
plotOutput("tab_n_out")
```

```{r context="server"}
data_n_example <- reactive({
  sampSize <- input$samp_n
  noAssocSmoking <- data.frame(probSmok = runif(n=sampSize), probDeath = runif(n=sampSize))
  noAssocSmoking <- noAssocSmoking %>% mutate(smoking=ifelse(probSmok < .3, "Y", "N"),
                                              outcome=ifelse(probDeath < .2, "Dead", "Alive"))

  return(noAssocSmoking)
})

tab_assoc <- reactive({
  noAssocSmoking <- data_n_example()
  tabNoAssoc <- data.frame(table(noAssocSmoking$smoking,
                                 noAssocSmoking$outcome))
  colnames(tabNoAssoc) <- c("smoking", "outcome", "value")
  tabNoAssoc
})

t_stat_n <- reactive({
  tt <- tidy(prop.test(tab_assoc()))
})

output$plot_n_bar <- renderPlot({
  prop_status <- input$samp_check

  if(prop_status){
    pos_val = "fill"
    lims <- c(0,1)
  }else{
    pos_val="stack"
    lims <- c(0,1000)
  }

  data_n_example() %>%

    ggplot(aes(x=smoking, fill=outcome)) +
    geom_bar(color="black", position=pos_val) + scale_y_continuous(limits=lims)
})

output$chi_dist <- renderPlot({
  dchisq(c(1:10),1)
})
```

```{r asis=TRUE}
bmicols <- colnames(bmi_diabetes)
selectInput("missing_col", "Select a Variable", choices = bmicols, selected =bmicols[2])
verbatimTextOutput("missing_val")
```

```{r context="server"}
data(bmi_diabetes)
bmi2 <- bmi_diabetes


missingDat <- reactive({

  print(input$missing_col)

  if(is.null(input$missing_col)){
    miss_col <- "Diabetes"
  } else
  {miss_col <- input$missing_col}

  var1 <- quote(miss_col)
  #print(!!var1)
  out <- bmi2 %>% dplyr::filter_(is.na(miss_col))
  out
})

output$missing_val <- renderText({
  print(missingDat())
})
```

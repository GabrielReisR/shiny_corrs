# Nome: Understanding correlations
# Autor: Gabriel dos Reis Rodrigues
# June, 2021
# Last update: 25/06/2021
# ----------------------------------------

# Initial loading ====
if(!require("faux"))
    install.packages("faux"); library(faux)
if(!require("ggplot2"))
    install.packages("ggplot2"); library(ggplot2)
if(!require("shiny"))
    install.packages("shiny"); library(shiny)

# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Visualize correlations"),

    # Sidebar with inputs ====
    sidebarLayout(
        sidebarPanel(
            sliderInput("corr",
                        "Specify correlation",
                        min = -0.9999999,
                        max = 0.9999999,
                        value = 0,
                        step = 0.001),
            sliderInput("samplesize",
                        "Change sample size",
                        min = 3,
                        max = 10000,
                        value = 1000,
                        step = 1),
            selectInput("plotline",
                        "Show regression line?",
                        c("Yes" = T, "No" = F)),
            
            # Conditional Panels ====
            conditionalPanel("input.corr < 0.1 &
                             input.corr > -0.1",
                             h5(strong("It appears that X and Y are NOT
                                       correlated.")),
                             h6("Based on Cohen (1988), this happens when the
                             absolute value of the correlation is below 0.1. If
                             we're measuring the correlation with Pearson's r,
                             a correlation of 0.1 means that both variables 
                             share less than 1% of their variance."),
                             
                             h6("We get the less than 1% value when we multiply
                             the correlation value r by itself (r*r = r²). So,
                             if r = 0.09, r² = 0.09 * 0.09 = 0.0081. This is
                             less than 0.81% of shared variance, less than 1%.
                             We could almost certainly say that X and Y are very
                             different things."),
                             
                             hr(),
                             
                             h6(strong("Reference")),
                             
                             h6("Cohen, J. (1988). Statistical power
                             analysis for the behavioral sciences (2nd edition).
                                      Lawrence Erlbaum.")),
            
            conditionalPanel("input.corr >= 0.1 & input.corr < 0.3|
                             input.corr <= -0.1 & input.corr > -0.3",
                             h5(strong('There seems to be a WEAK correlation
                                       between X and Y.')),
                             h6("Based on Cohen (1988), this happens when the
                             absolute value of the correlation is above or 
                             equal to 0.1. If we're measuring the correlation
                             with Pearson's r, a correlation of 0.1 means that
                             both variables share at least 1% of their
                             variance."),
                                       
                             h6("We get the 1% value when we multiply the
                             correlation value r by itself (r*r = r²).
                             So, if r = 0.1, r² = 0.1 * 0.1 = 0.01.
                             It should be obvious that 1% is a very low
                             percentage."),
                             
                             hr(),
                             
                             h6(strong("Reference")),
                             
                             h6("Cohen, J. (1988). Statistical power
                             analysis for the behavioral sciences (2nd edition).
                                      Lawrence Erlbaum.")),
            
            conditionalPanel("input.corr >= 0.3 & input.corr < 0.5|
                             input.corr <= -0.3 & input.corr > -0.5",
                             h5(strong('There seems to be a MODERATE correlation
                                       between X and Y.')),
                             h6("Based on Cohen (1988), this happens when the
                             absolute value of the correlation is above or equal
                             to 0.3. If we're measuring the correlation with
                             Pearson's r, a correlation of 0.3 means that both
                             variables share 9% of their variance."),
                                       
                             h6("We get the 9% value when we multiply the
                             correlation value r by itself (r*r = r²). So, if
                             r = 0.3, r² = 0.3 * 0.3 = 0.09."),
                             
                             hr(),
                             
                             h6(strong("Reference")),
                             
                             h6("Cohen, J. (1988). Statistical power
                             analysis for the behavioral sciences (2nd edition).
                                      Lawrence Erlbaum.")),
            
            conditionalPanel("input.corr >= 0.5 & input.corr < 0.7|
                             input.corr <= -0.5 & input.corr > -0.7",
                             h5(strong('There seems to be a STRONG correlation
                                       between X and Y.')),
                             h6("Based on Cohen (1988), this happens when the
                             absolute value of the correlation is above or equal
                             to 0.5. If we're measuring the correlation with
                             Pearson's r, a correlation of 0.5 means that both
                             variables share 25% of their variance."),
                             
                             h6("We get the 25% value when we multiply the
                             correlation value r by itself (r*r = r²). So, if
                             r = 0.5, r² = 0.5 * 0.5 = 0.25."),
                             
                             hr(),
                             
                             h6(strong("Reference")),
                             
                             h6("Cohen, J. (1988). Statistical power
                             analysis for the behavioral sciences (2nd edition).
                                      Lawrence Erlbaum.")),
            
            conditionalPanel("input.corr >= 0.7 & input.corr < 0.9 |
                             input.corr <= -0.7 & input.corr > -0.9 ",
                             h5(strong('There seems to be a STRONG correlation
                                       between X and Y.')),
                             h6("Based on Cohen (1988), this happens when the
                             absolute value of the correlation is above or equal
                             to 0.5. If we're measuring the correlation with
                             Pearson's r, a correlation of 0.5 means that both
                             variables share 25% of their variance."),
                             
                             h6("We get the 25% value when we multiply the
                             correlation value r by itself (r*r = r²). So, if
                             r = 0.5, r² = 0.5 * 0.5 = 0.25."),
                             
                             h6("When correlation is above or equal to 0.7,
                                almost half of the variance between the
                                two variables is being shared, given that
                                r² = 0.49, which is equivalent to 49% of 
                                shared variance. Maybe it's time to think if
                                these two variables have a common cause or if
                                one causes another."),
                             
                             hr(),
                             
                             h6(strong("Reference")),
                             
                             h6("Cohen, J. (1988). Statistical power
                             analysis for the behavioral sciences (2nd edition).
                                      Lawrence Erlbaum.")),
            
            conditionalPanel("input.corr >= 0.9 |
                             input.corr <= -0.9",
                             h5(strong('There seems to be a STRONG correlation
                                       between X and Y.')),
                             h6("Based on Cohen (1988), this happens when the
                             absolute value of the correlation is above or equal
                             to 0.5. If we're measuring the correlation with
                             Pearson's r, a correlation of 0.5 means that both
                             variables share 25% of their variance."),
                             
                             h6("We get the 25% value when we multiply the
                             correlation value r by itself (r*r = r²). So, if
                             r = 0.5, r² = 0.5 * 0.5 = 0.25."),
                             
                             h6("When correlation is above or equal to 0.9,
                                almost all of the variance between the
                                two variables is being shared, given that
                                r² = 0.81, which is equivalent to 81% of 
                                shared variance. It seems that these two
                                variables have a common cause or one is causing
                                variation in the other."),
                             
                             hr(),
                             
                             h6(strong("Reference")),
                             
                             h6("Cohen, J. (1988). Statistical power
                             analysis for the behavioral sciences (2nd edition).
                                      Lawrence Erlbaum.")),
            
            ),

        
        # Show the correlation plot ====
        mainPanel(
           plotOutput("corrplot")
        )
    )
)

# Define server logic ====
server <- function(input, output) {

    output$corrplot <- renderPlot({
        corr_plot(corr = input$corr,
                  sample = input$samplesize,
                  line = input$plotline)
    })
}


# Run the application 
shinyApp(ui = ui, server = server)
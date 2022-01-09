library(tidyverse)
library(reshape2)
library(shiny)
library(googlesheets4)


ui <- fluidPage(
  
  # App title ----
  titlePanel("Wellbeing monitoring tool"),
  helpText("Navigate across daily responses of well-being scores."),
  
  # Sidebar layout
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "days",
                  label = span(icon("calendar"), "Show me the last ___ days:"),
                  min = 1,
                  max = 50,
                  value = 30), width = 3
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      width = 9,
      tabsetPanel(
        tabPanel(
        title = "Team analysis",
        icon = icon("group"),
        "oi"
          
          
        ), # Close team analysis tab
        
        tabPanel(
          title = "Individual analysis",
          icon = icon("user"),
          "oi"
          
          
    ) # Close individual analysis tab
   )
  )
 )
)

server <- function(input, output) {

# Reading our data from Google Sheets
gs4_auth()
df <- read_sheet(ss = "https://docs.google.com/spreadsheets/d/1RN1mviub6Cx5uSD7duMEkN0zeIlARfUXje67HUsf04s/edit?usp=sharing")

# Stacking our data
df <- melt(data = df, id.vars = c("Name", "Date"), 
           measure.vars = c("Sleep quality", "Stress level", "Soreness", "Fatigue"),
           variable.name = "Domain",
           value.name = "Score"
           )



}


shinyApp(ui, server)
,
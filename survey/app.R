library(surveydown)

# Connect to database (reads credentials from .env file).
# Run sd_db_config() interactively to set up the .env file with:
#   SD_HOST, SD_PORT, SD_DBNAME, SD_USER, SD_PASSWORD, SD_TABLE
# To run locally without a database, set ignore = TRUE:
#   db <- sd_db_connect(ignore = TRUE)
db <- sd_db_connect(ignore = TRUE)

ui <- sd_ui()

server <- function(input, output, session) {
  # Show the hero design textarea only for hardcore/casual fans
  sd_show_if(
    input$superhero_fan %in% c("hardcore", "casual") ~ "hero_design"
  )

  sd_server(db = db)
}

shiny::shinyApp(ui = ui, server = server)

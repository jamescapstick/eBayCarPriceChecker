library( shiny )
library( XML )
source( "helpers.R" )

#load the categories first
#categoriesRaw <- eBayGetCategories()
#categoriesParsed <- xmlParse( categoriesRaw )
#top <- xmlRoot( categoriesParsed )
#categoryList <- list()
#free( categoriesParsed )

shinyUI(
  fluidPage(
    titlePanel( "eBay Car Price Checker" ),

    sidebarLayout(
      sidebarPanel(
        helpText( "Enter an eBay search term for the car you want to look for." ),
        helpText( "Average sold prices for the first 100 returned matches will appear on the right." ),

        textInput( "filter", "Search Terms", "Mitsubishi Mirage" )
      ),

      mainPanel(
        textOutput( "input" ),
        textOutput( "status" ),
        textOutput( "averageSalePrice" ),
        textOutput( "response" ),
        tableOutput( "table" )
      )
    )
  )
)

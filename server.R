# server.R
source( "helpers.R" )

shinyServer( function( input, output ) {

  # do the eBay request
  response <- reactive({
    eBayRequest( input$filter )
  })

  # format the reply as a list R object so we can use it easier
  rootNode <- reactive({
    eBayGetResponseRootNode( response() )
  })

  # get the list of items sold
  items <- reactive({
    eBayGetResponseSoldItems( rootNode() )
  })

  # get the average sold price
  averageSoldPrice <- reactive({
    mean( items()[ , "price" ] )
  })

  # output what the user inputted
  output$input <- renderText({
    paste( "User Input: '", input$filter, "'" )
  })

  # output status
  output$status <- renderText({
    paste( "Response status: ", http_status( response()$status_code )$message )
  })

  # output average sale price
  output$averageSalePrice <- renderText({
    paste( "Average Sale Price: $", averageSoldPrice() )
  })

  # output response
  output$response <- renderText({
    errorHappened <- http_error( response() )
    if( errorHappened )
    {
      "Error"
    }
    else
    {
      paste( "Results: ", xmlValue(rootNode()[["paginationOutput"]][["totalEntries"]]) )
    }
  })

  # output a table of results
  output$table <- renderTable({
    items()
  }, sanitize.text.function = function(x) x)
})

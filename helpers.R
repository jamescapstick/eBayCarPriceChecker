library( httr )
library( XML )

appID <- "JamesCap-PriceChe-PRD-e2f871c91-3850538e"

# sends a request to eBay with the supplied filter
eBayRequest <- function( filter )
{
  eBayURL <- "http://svcs.ebay.com/services/search/FindingService/v1"
  version <- "1.0.0"
  responseFormat <- "XML"
  operation <- "findCompletedItems"
  GET( eBayURL, query = list( "OPERATION-NAME" = operation,
                              "SERVICE-VERSION" = version,
                              "SECURITY-APPNAME" = appID,
                              "RESPONSE-DATA-FORMAT" = responseFormat,
                              "REST-PAYLOAD" = NULL,
                              "itemFilter(0).name" = "SoldItemsOnly",
                              "itemFilter(0).value" = "true",
                              "categoryId" = 6001,
                              keywords = filter ) )
}

# gets the categories available
eBayGetCategories <- function()
{
  eBayURL <- "http://open.api.ebay.com/Shopping"
  version <- "677"
  operation <- "GetCategoryInfo"
  GET( eBayURL, query = list( "callname" = operation,
                              "appid" = appID,
                              "version" = version,
                              "siteid" = 0,
                              "CategoryID" = 6001,
                              "IncludeSelector" = "ChildCategories" ) )
}

# gets the root node of the xml response
eBayGetResponseRootNode <- function( response )
{
  responseContent <- content( response )
  xmlRoot( xmlParse( responseContent ) )
}

# gets the list of sold items and their price in data table format
eBayGetResponseSoldItems <- function( rootNode )
{
  myDataFrame <- data.frame()
  count <- 0
  for( node in xmlChildren( rootNode[["searchResult"]] ))
  {
    name <- xmlValue( node[["title"]] )
    url <- xmlValue( node[["viewItemURL"]] )
    imageUrl <- xmlValue( node[["galleryURL"]] )
    myDataFrame[ count + 1, "image" ] <- paste0("<img src='",  imageUrl, "'/>" )
    myDataFrame[ count + 1, "name" ] <- paste0("<a href='",  url, "' target='_blank'>", name ,"</a>" )
    myDataFrame[ count + 1, "price" ] <- as.numeric( xmlValue( node[["sellingStatus"]][["currentPrice"]] ) )
    count = count + 1
  }
  myDataFrame
}

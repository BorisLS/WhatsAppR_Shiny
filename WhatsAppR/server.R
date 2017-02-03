#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(WhatsAppR)
library(dplyr)

# Define server logic required to draw a histogram
# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 9MB.
options(shiny.maxRequestSize = 9*1024^2)

function(input, output) {
  
  import_chat <- eventReactive(input$start, {
    
    inFile <- input$file1
    
    if (is.null(inFile)){
      return(NULL)
    } else{
      
      imp_chat <- WhatsAppR::wapp_import(inFile$datapath,
                                         input$os,
                                         input$language,
                                         FALSE)
      return(imp_chat)
    }
    
  })
  
  output$laenge <- renderText({
    
    imp_chat <- import_chat()
    
    return(dim(imp_chat))
  })
  
  output$wapp_author <- renderTable({
    
    chat_author <- import_chat() %>%
                   wapp_stat_author()
    return(chat_author)
  })
  
  
}

#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Package Management
library(shiny)
library(readr)
library(lubridate)
library(stringr)
library(dplyr)
library(tidytext)

#devtools::install_github("BorisLS/WhatsAppR")
library(WhatsAppR)
#

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
    
    return(paste0("Insgesamt besitzt der importierte Chatverlauf ", 
                  dim(imp_chat)[1],
                  " Zeilen."))
  })
  
  
  ###### Tabset Teilnehmer
  
  output$intro_author <- renderText({
    
    chat_author <- import_chat()
    count_author <- length(unique(chat_author$author))
    
    return(paste0("In dem Chatverlauf sind ", count_author, " Teilnehmer enthalten.")) 
  })
  
  output$wapp_author_all <- renderTable({
    
    chat_author <- import_chat() %>%
                   wapp_stat_author()
    
    return(chat_author)
  })
  
  output$wapp_author_text <- renderTable({
    
    chat_author <- import_chat() %>%
                   wapp_filter(type = "text") %>%
                   wapp_stat_author()
    
    return(chat_author)
  })
  
  output$wapp_author_media <- renderTable({
    
    chat_author <- import_chat() %>%
                   wapp_filter(type = "media") %>%
                   wapp_stat_author()
    
    return(chat_author)
  })
  
  
  output$wapp_author_firstpost <- renderTable({
    
    chat_author <- import_chat() %>%
                   wapp_filter(type = "message") %>%
                   wapp_stat_firstpost()
    
    return(chat_author)
  })
  
  ###### Tabset Datum
  
  output$wapp_date_all <- renderTable({
    
    chat_date <- import_chat() %>%
                 wapp_stat_date(n=5)
    
    chat_date$day <- as.character(chat_date$day)
    
    return(chat_date)
  })
  
  
  output$wapp_date_text <- renderTable({
    
    chat_date <- import_chat() %>%
                 wapp_filter(type = "message") %>%
                 wapp_stat_date(n=5)
    
    chat_date$day <- as.character(chat_date$day)
    
    return(chat_date)
  })
  
  output$wapp_date_media <- renderTable({
    
    chat_date <- import_chat() %>%
                 wapp_filter(type = "media") %>%
                 wapp_stat_date(n=5)
    
    chat_date$day <- as.character(chat_date$day)
    
    return(chat_date)
  })
  
  output$wapp_stat_time_all <- renderTable({
    
    chat_date <- import_chat() %>%
                 wapp_stat_time(interval = "quarter")

    return(chat_date)
  })
  
  ###### Tabset Emoticon
  output$wapp_emoticons_all <- renderTable({
    
    chat_emo <- import_chat()
    
    author <- unique(chat_emo$author)
    
    table_emo <- data.frame(author = "first line",
                            char = "first line",
                            description = "first line",
                            number = 0,
                            share = 0.01,
                            stringsAsFactors = FALSE)
    for(aut in author){
      
      df.aut <- chat_emo %>%
        wapp_stat_emoticons(author = aut, 
                            n = 3)
      
      df.aut$author <- aut
      
      table_emo <- bind_rows(table_emo, df.aut)
      
    }
    
    table_emo <- table_emo %>% filter(char != "first line")

    return(table_emo)
  })

  
}

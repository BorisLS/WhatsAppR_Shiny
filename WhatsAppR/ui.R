#
# This is the user-interface definition a Shiny web application. 
# With this web app You can automate analyses with the WhatsAppR-package
####################################################
#             ui.R
####################################################

#
library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  titlePanel("Uploading Files"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose file to upload',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
      ),
      actionButton("start", "Analyze"),
      p('Geduld.....'),
      tags$hr(),
      radioButtons('os', 'OS',
                   c(Android='android',
                     iOS='iOS'),
                   'android'),
      radioButtons('language', 'Language',
                   c('German'='de',
                     'English'='en'),
                   'de'),
      tags$hr(),
      p('If you want a sample .csv or .tsv file to upload,',
        'you can first download the sample',
        a(href = 'mtcars.csv', 'mtcars.csv'), 'or',
        a(href = 'pressure.tsv', 'pressure.tsv'),
        'files, and then try uploading them.'
      )
    ),
    mainPanel(
      verbatimTextOutput('laenge'),
      tableOutput('wapp_author')
    )
  )
)

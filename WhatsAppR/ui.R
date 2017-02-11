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
  titlePanel("Analyse von WhatsApp Chatverläufe mit WhatsAppR"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Wähle Chatverlauf aus',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
      ),
      tags$hr(),
      radioButtons('os', 'OS',
                   c(Android='android',
                     iOS='iOS'),
                   'android'),
      radioButtons('language', 'Language',
                   c('Deutsch'='de'),
                   'de'),
      tags$hr(),
      actionButton("start", "Analyse"),
      tags$hr(),
      p('Weitere Informationen zu dem WhatsAppR-Package',
        'stehen unter',
        a(href = 'https://github.com/BorisLS/WhatsAppR', 'https://github.com/BorisLS/WhatsAppR'),
        'bereit.'
      ),
      tags$hr(),
      p('Boris.Luetke.Schelhowe (at) gmail.com')
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Zusamenfassung",
                           p("Diese Webapp ermöglicht es WhatsApp-Chats auf Basis des R-Packages WhatsAppR zu analysieren. Als Grundlage dient der als Textdatei exportierte Chatverlauf."),
                           p("Eine Anleitung wie der Chatverlauf eines Chats als txt-Datei exportiert werden kann, findet sich für das jeweilige Betriebssystem in den FAQs von WhatsApp:",
                             a(href = 'https://www.whatsapp.com/faq/de/android/23756533', 'Android'), "oder",
                             a(href = 'https://www.whatsapp.com/faq/de/iphone/20888066#email', 'iOS'), "."
                           ),
                           p("Als Einstellung ist der Export ohne Medien zu wählen."),
                           p("Der exportierte Chatverlauf ist zuerst auszuwählen und hochzuladen."),
                           p("Im Anschluss ist auszuwählen, welche Sprache die Systemeinstellung des Smartphones ist und welches Betriebssystem das Smartphone hat."),
                           p("Auf den verschiedenen Tabs finden sich die jeweiligen Auswertungen, die nach Betätigen von Analyse erstellt wurden."),
                           verbatimTextOutput('laenge')), 
                  tabPanel("Teilnehmer",
                           textOutput("intro_author"),
                           p("Die nachfolgenden Tabelle stellt dar, wie sich die versendeten Nachrichten auf die einzelnen Teilnehmer aufteilen:"),
                           tableOutput("wapp_author_all"),
                           p("Die nachfolgenden Tabelle dagegen umfasst nur die die versendeten Textnachrichten:"),
                           tableOutput("wapp_author_text"),
                           p("Die nachfolgenden Tabelle dagegen umfasst nur die die versendeten Nachrichten, die keine Textnachrichten sind (z.B. Bilder, Videos):"),
                           tableOutput("wapp_author_media"),
                           p("In Gruppenchat existieren einzelne Personen die meist den ersten Post des Tages durchführen und damit den Chatverlauf des Tages initiieren. Die nachfolgende Tabelle stellt dar, wie häufig ein Teilnehmer den ersten Post des Tages erstellt hat."),
                           tableOutput("wapp_author_firstpost")
                           ),
                  tabPanel("Datum",
                           p("Die nachfolgenden Tabelle stellt dar, an welchen 5 Tagen die meisten Nachrichten versendet wurden:"),
                           tableOutput("wapp_date_all"),
                           p("Die nachfolgenden Tabelle dagegen umfasst nur die die versendeten Textnachrichten:"),
                           tableOutput("wapp_date_text"),
                           p("Die nachfolgenden Tabelle dagegen umfasst nur die die versendeten Nachrichten, die keine Textnachrichten sind (z.B. Bilder, Videos):"),
                           tableOutput("wapp_date_media"),
                           p("Die stellt dar in welchen Zeiträumen am Tag die Nachrichten in der Gruppe versendet wurden:"),
                           tableOutput("wapp_stat_time_all")
                          ),
                  tabPanel("Emoticon",
                           p("Emoticons sind ein wichtiger Bestandteil in der Kommunikation mit WhatsApp. Die nachfolgende Tabelle stellt dar, welche 3 Emoticons jeder Teilnahmer in dem Chat am häufigsten verwendet."),
                           tableOutput("wapp_emoticons_all")
                  )
              )
    )
  )
)
library(shiny)
library(googlesheets4)
library(tidyverse)
library(shinydashboard)

# Initialize Google Sheets

service_key<- "oapaul-3660ce57f74c.json"
gs4_auth(path = service_key, scopes = "https://www.googleapis.com/auth/spreadsheets")

# Replace 'SHEET_ID' with the ID of your Google Sheet
sheet_id <- "1qbZkaKLLlEMGkkrlkdmY6tR9Wow5TFOevmLK4t3nBe4"

function(input, output, session) {
        
        observeEvent(input$submit, {
                # Create a new row to store the input data in Google Sheets
                newRow <- data.frame(
                        name = input$fullName,
                        state = input$state,
                        age = input$age,
                        gender = input$gender,
                        request = input$request,
                        time_stamp = Sys.time()
                )
                
                # Append the new row to the Google Sheet
                write_sheet(sheet = sheet_id, data = newRow )
                sheet_append(ss = sheet_id, data = newRow)
                
                session$reload()
                
        })
        
        # Get data from Google Sheets
        sheet_data <- read_sheet(sheet_id)
        
        # Plot1
        output$ageGenderPlot <- renderPlot({
               
                # Plot the distribution of age and gender
                age_gender_plot <- function(data, variable) {
                        data <- data |>
                                select({{variable}}) |>
                                filter(!is.na({{variable}})) |>
                                count({{variable}}, sort = TRUE)
                        
                        data$frac = data$n / sum(data$n)
                        data$ymax = cumsum(data$frac)
                        data$ymin = c(0, head(data$ymax, n = -1))
                        
                        # Distribution of variable
                        data |>
                                ggplot(aes(ymax = ymax, ymin = ymin, xmax = 4, xmin = 3,
                                           fill = {{variable}})) +
                                geom_rect() +
                                coord_polar(theta = "y") +
                                xlim(c(1.4, 4)) + theme_void() +
                                theme(legend.position = c(.5,.5),
                                      legend.key.size = unit(.8, "cm"),
                                      legend.text = element_text(size = 10),
                                      legend.title = element_text(size = 10))+
                                scale_fill_manual(values = c("#2A8E21","#6BE95F","#CFFFCB"))
                }
                
                main_plot <- age_gender_plot(sheet_data, gender)
                print(main_plot)
        })
        
        # plot 2
        output$secondPlot <- renderPlot({
                
                # Plot the distribution of age and gender
                location_plot <- ggplot(sheet_data, aes(x = as.factor(state), fill = state)) +
                        geom_bar() +
                        labs(title = "States Repersentation", x = "State", y = "Count") +
                        theme_minimal()+
                        scale_fill_viridis_d(option = "H")+
                        theme(legend.position = "none")+
                        coord_flip()
                
                print(location_plot)
        })
        
        #Box A
        output$box_A <- renderValueBox({
                data <- sheet_data
                
                average_age<- data %>% 
                        select(age) %>% 
                        summarize(av_age = mean(age)) %>% 
                        mutate(av_age = round(av_age, 1))
                
                valueBox(paste0(average_age, " Years"),
                         "Average Age", icon = icon("user"), color = 'green')
        })
        
        # box B
        output$box_B <- renderValueBox({
                data <- sheet_data
                
                input_count<- data %>% 
                        nrow()
                
                valueBox(paste0(input_count, " "),
                         "Respondents Count", icon = icon("users"), color = 'lime')
        }) 
        
        # Create data table
        output$recentUpdate <- renderDataTable({
                data <- sheet_data
                
                brief_data<- data %>% 
                        select(name,time_stamp) %>% 
                        tail(10)
                
                # Output a data table
                datatable(brief_data,
                          options = list(searching = F, paging = F, info = F))
        })
}

library(shiny)
library(shinydashboard)
library(DT)

dashboardPage(
        skin = "green",
        dashboardHeader(title = "Government Survey Dashboard", titleWidth = 1300),
        dashboardSidebar(disable = TRUE),
        # You can add sidebar items if necessary
        
        dashboardBody(
                # Create title
                fluidRow(titlePanel("")),
                
                # Create Value Boxes (replace with your values)
                fluidRow( 
                        # Put something here
                        box(width= 4, height = "100px", status = "success",
                            p("This is a shiny dashboard that takes input data and saves in google sheet.
                              We also retrieve updated data from the sheet to plot.")),
                        valueBoxOutput("box_A"),
                        valueBoxOutput("box_B")
                ),
                
                column(width = 4,
                        box(
                                width = 12,
                                height = "60%",
                                title = "Log your details Here",
                                status = "success",
                                solidHeader = TRUE,
                                textInput("fullName", label = NULL, placeholder = "Full name(Last, First Middle)"),
                                selectInput(
                                        "state",
                                        label = "State",
                                        choices = c(
                                                "Abia","Adamawawa","Akwa-ibom",
                                                "Anambra","Bauchi","Bayelsa",
                                                "Benue","Borno","Cross River",
                                                "Delta","Ebonyin","Edo",
                                                "Ekiti","Enugu","Gombe",
                                                "Imo","Jigawa","Kaduna",
                                                "Kano","Katsina","Kebbi",
                                                "Kogi","Kwara","Lagos",
                                                "Nasarawa","Niger","Ogun",
                                                "Ondo","Osun","Oyo",
                                                "Plateau","Rivers","Sokoto",
                                                "Taraba","Yobe","Zamfara",
                                                "FCT"),
                                        selected = "Lagos"
                                ),
                                
                                numericInput("age", "Age", value = 18, min = 0),
                                selectInput(
                                        "gender",
                                        "Gender",
                                        choices = c("Male", "Female", "Other"),
                                        selected = "Male"
                                )
                        ),
                        
                        box(
                                width = 12,
                                title = "Request",
                                status = "success",
                                solidHeader = TRUE,
                                textAreaInput("request", "Request",placeholder = "Input your request here"),
                                actionButton("submit", "Submit")
                        )
                        
                ),
                
                # Create input panel
                column(width = 4,
                        box(
                                title = "Age to Gender distribution",
                                solidHeader = TRUE,
                                width = 12,
                                height = "100%",
                                collapsible = TRUE,
                                plotOutput("ageGenderPlot")
                        )
                       
                ),
                
                column(
                        width = 4,
                        # # Create Plots panel
                        # box(
                        #         title = "States Represented",
                        #         solidHeader = TRUE,
                        #         width = 12,
                        #         height = "100%",
                        #         collapsible = TRUE,
                        #         plotOutput("secondPlot")
                        # ),
                        
                        box(
                                width = 12,
                                # height = "100px",
                                title = "Recent update",
                                status = "success",
                                dataTableOutput("recentUpdate")
                        )
                )
        )
)

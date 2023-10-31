# Shiny Dashboard with Google Sheets Integration
## Project overview:
This project is a Shiny web application that interacts with Google Sheets using the Google Sheets API. It allows users to enter input and save it on google sheet. The system may then read back the data for further charts on the same dashboard.

## Setup:
### Prerequisites:
- **R and RStudio:** Install R and RStudio on your local machine or server.
- **Google Account:** Access to a Google account is necessary for setting up Google Sheets and the associated API access.
- **Google Cloud Console:** A project set up in the Google Cloud Console is required to use the Google Sheets API.

### Install Required Packages
```{r}
install.packages("shiny")
install.packages("googlesheets4")
# other packages are available in the server script
```

### Service Account Setup:
- Create a service account in the Google Cloud Console.
- Enable the Google Sheets API for your project.
- Obtain a JSON file containing the service account key.

### Configuring the App:
Set the path to the JSON file containing the service account key in the Shiny app code.
Configure necessary parameters for Google Sheets access.

### Interact with the App:
Open your web browser and navigate to here [link to dashboard]("https://paul-alexander.shinyapps.io/surveyApp/")

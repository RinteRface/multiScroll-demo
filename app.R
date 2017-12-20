library(fullPage)
library(shiny)

options <- list(
  sectionsColor = c("#4BBFC3", "#7BAABE", "lightgray")
)

ui <- multiPage(
  opts = options,
  menu = c("Multi Scroll" = "multiscroll",
           "Plots" = "plots",
           "Full Section plots" = "fullplots",
           "More" = "more"),
  multiLeft(
    multiSection(
      center = TRUE,
      menu = "multiscroll",
      h1("Multiple")
    ),
    multiSection(
      menu = "plots",
      multiContainer(
        h1("Plot ->"),
        numericInput(
          "max",
          "Maximum",
          min = 50,
          max = 250,
          value = 10
        )
      )
    ),
    multiSectionPlot(
      menu = "fullplots",
      "fullPlot"
    ),
    multiSection(
      menu = "more",
      center = TRUE,
      multiContainer(
        p("Want more Stuff like this?"),
        p("->")
      )
    )
  ),
  multiRight(
    multiSection(
      center = TRUE,
      h1("scroll")
    ),
    multiSection(
      center = TRUE,
      plotOutput("plot")
    ),
    multiSection(
      multiContainer(
        center = TRUE,
        h1("<- Full Section plot"),
        sliderInput(
          "number",
          "Data points",
          min = 50,
          max = 250,
          value = 10
        )
      )
    ),
    multiSection(
      multiButton(
        href = "http://john-coene.com",
        "Click me!"
      ),
      p(
        "This run just fine... the issue is with showcase mode."
      )
    )
  )
)

server <- function(input, output){
  
  output$plot <- renderPlot({
    hist(rnorm(100, 20, input$max))
  })
  
  output$fullPlot <- renderPlot({
    par(bg = "gray")
    hist(rnorm(input$number, 20, 250))
  })
}

shinyApp(ui, server)


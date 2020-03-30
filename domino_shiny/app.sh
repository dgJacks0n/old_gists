# bootstrap file to run shiny app on domino
R -e 'shiny::runApp("./", port=8888, host="0.0.0.0")'
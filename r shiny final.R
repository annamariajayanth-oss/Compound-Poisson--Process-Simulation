library(shiny)
library(ggplot2)

# Simulate Compound Poisson Process
simulateCPO <- function(lambda, gamma, Tmax, nSims) {
  times <- c(10, 100, 1000, 10000)
  
  out <- matrix(0, nrow=nSims, ncol=length(times))
  colnames(out) <- paste0("t=", times)
  
  paths <- vector("list", nSims)
  
  for(i in 1:nSims) {
    N <- rpois(1, lambda*Tmax)
    if(N == 0) {
      out[i,] <- 0
      paths[[i]] <- data.frame(t=0, S=0)
      next
    }
    
    jt <- sort(runif(N, 0, Tmax))
    js <- rexp(N, rate=gamma)
    S <- cumsum(js)
    
    paths[[i]] <- data.frame(t=c(0, jt), S=c(0, S))
    
    for(k in seq_along(times)) {
      idx <- findInterval(times[k], jt)
      out[i,k] <- ifelse(idx==0, 0, S[idx])
    }
  }
  
  list(paths=paths, samples=out)
}

# =============================
# UI
# =============================
ui <- fluidPage(
  titlePanel("Compound Poisson Process Simulator"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("lambda", "λ (Poisson arrival rate)", min=0.1, max=5, value=1, step=0.1),
      sliderInput("gamma", "γ (Exponential jump-size rate)", min=0.1, max=5, value=1, step=0.1),
      numericInput("sims", "Number of Simulations", value=200, min=10),
      sliderInput("paths", "Paths to Plot", min=1, max=20, value=5),
      actionButton("run", "Run Simulation")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Sample Paths", plotOutput("pathPlot")),
        
        tabPanel("Histograms",
                 fluidRow(
                   column(6, plotOutput("h10")),
                   column(6, plotOutput("h100"))
                 ),
                 fluidRow(
                   column(6, plotOutput("h1000")),
                   column(6, plotOutput("h10000"))
                 )
        ),
        
        tabPanel("Parameter Effects",
                 h3("Interpretation of Parameter Sensitivity"),
                 verbatimTextOutput("paramText")
        )
      )
    )
  )
)

# =============================
# SERVER
# =============================
server <- function(input, output, session) {
  
  res <- eventReactive(input$run, {
    simulateCPO(input$lambda, input$gamma, Tmax=10000, nSims=input$sims)
  })
  
  # ---- Sample Path Plot ----
  output$pathPlot <- renderPlot({
    paths <- res()$paths
    n <- min(input$paths, length(paths))
    
    df <- do.call(rbind, lapply(1:n, function(i){
      out <- paths[[i]]
      out$sim <- paste("Sim", i)
      out
    }))
    
    ggplot(df, aes(t, S, color=sim)) +
      geom_step(alpha=0.7) +
      theme_minimal() +
      theme(legend.position="none") +
      labs(title="Sample Paths", x="t", y="S(t)")
  })
  
  # ---- Histogram Helper ----
  histo <- function(col, tval) {
    df <- data.frame(S = res()$samples[, col])
    
    ggplot(df, aes(S)) +
      geom_histogram(color="black", fill="skyblue", bins=40) +
      theme_minimal() +
      labs(title=paste("Histogram at t =", tval),
           x="S(t)", y="Count")
  }
  
  output$h10    <- renderPlot({ histo(1, 10) })
  output$h100   <- renderPlot({ histo(2, 100) })
  output$h1000  <- renderPlot({ histo(3, 1000) })
  output$h10000 <- renderPlot({ histo(4, 10000) })
  
  # ---- Parameter Effects Text ----
  output$paramText <- renderText({
    lambda <- input$lambda
    gamma  <- input$gamma
    
    mean_jump <- 1/gamma
    var_jump  <- 1/gamma^2
    
    paste0(
      "### Parameter Effects\n\n",
      "You selected:\n",
      "• λ = ", lambda, "  (Poisson arrival intensity)\n",
      "• γ = ", gamma,  "  (rate of exponential jump sizes)\n\n",
      
      "### Interpretation:\n\n",
      
      "1. **Effect of λ (arrival rate):**\n",
      "   - Expected number of jumps by time t is λt.\n",
      if(lambda < 1) {
        "   - Small λ → rare jumps → S(t) grows slowly.\n"
      } else if(lambda < 3) {
        "   - Moderate λ → jumps occur frequently enough to smooth the path.\n"
      } else {
        "   - Large λ → many jumps → S(t) rises quickly and looks smoother by CLT.\n"
      },
      "\n",
      
      "2. **Effect of γ (jump-size rate):**\n",
      "   - Mean jump size = 1/γ = ", round(mean_jump, 3), "\n",
      "   - Variance of jump size = 1/γ² = ", round(var_jump, 3), "\n",
      if(gamma < 1) {
        "   - Small γ → large average jumps → S(t) increases in bigger steps.\n"
      } else if(gamma < 3) {
        "   - Moderate γ → medium jump sizes with medium noise.\n"
      } else {
        "   - Large γ → very small jumps → S(t) grows more smoothly.\n"
      },
      "\n",
      
      "3. **Combined Effect on S(t):**\n",
      "   Expected value:\n",
      "   E[S(t)] = λt / γ\n",
      "   Variance:\n",
      "   Var[S(t)] = 2λt / γ²\n",
      "\n",
      
      "4. **Meaning for the histograms:**\n",
      "   - At small t, distributions are skewed and discrete-like.\n",
      "   - For large t (1000, 10000), distributions become nearly normal due to the Central Limit Theorem.\n",
      "   - Increasing λ shifts histograms right (more jumps).\n",
      "   - Decreasing γ shifts histograms right (bigger jumps).\n"
    )
  })
}

# =============================
# RUN APP
# =============================
shinyApp(ui, server)

# 📘 Compound Poisson Process Simulator (R Shiny App)

This project provides an interactive **R Shiny application** for simulating and analyzing the **Compound Poisson Process (CPP)**, a fundamental stochastic model widely used in **insurance risk**, **finance**, **queueing systems**, and **reliability engineering**. The process is defined as:

\[
S(t) = \sum_{i=1}^{N(t)} X_i,
\]

where \(N(t)\) is a Poisson process with arrival rate **λ**, and the jump sizes \(X_i\) follow an exponential distribution with rate **γ**. This app enables users to explore how the compound Poisson process behaves over time and how its distribution changes under different parameter settings.

---

## 🚀 Key Features

### 🔧 Adjustable Parameters
- **λ (arrival rate):** Controls how often jumps occur  
- **γ (jump-size rate):** Controls average jump size  
- Number of simulations  
- Number of sample paths to plot  

### 📈 Sample Path Visualization
Generate multiple realizations of \(S(t)\) to observe:
- Large vs. small jumps  
- Sparse vs. dense arrival events  
- Smooth vs. noisy paths depending on parameters  

### 📊 Histogram Exploration
View the distribution of \(S(t)\) at:

- **t = 10**  
- **t = 100**  
- **t = 1000**  
- **t = 10000**

This demonstrates how:
- Early-time distributions are skewed  
- Large-time distributions approach a normal shape  
- Increasing λ or decreasing γ shifts the distribution upward  

### 📘 Parameter Interpretation Panel
A built-in explanation automatically interprets:
- The role of λ in jump frequency  
- The role of γ in jump magnitude  
- The expected value:  
  \[
  \mathbb{E}[S(t)] = \frac{\lambda t}{\gamma}
  \]
- The variance:  
  \[
  \text{Var}(S(t)) = \frac{2\lambda t}{\gamma^2}
  \]
- How these parameters shape the trajectory and distribution of the process  

---

## 🧠 Why This Project?

This app provides an intuitive, visual, and interactive way to understand compound Poisson processes—something traditional textbooks cannot deliver. It is ideal for:

- Students learning stochastic processes  
- Actuarial and financial engineering education  
- Research involving jump-process modeling  
- Anyone exploring Poisson-driven stochastic systems  

---

## ▶️ Running the App

Clone the repository and run:

```r
library(shiny)
shiny::runApp("path_to_project/")


or use this code in rstudio which will direct to rshiny app.

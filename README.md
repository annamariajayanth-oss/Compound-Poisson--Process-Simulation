This project provides an interactive R Shiny dashboard for simulating and studying the Compound Poisson Process (CPP)—a widely used stochastic model in insurance mathematics, risk theory, finance, queueing, and reliability analysis.

The CPP is defined as:

𝑆
(
𝑡
)
=
∑
𝑖
=
1
𝑁
(
𝑡
)
𝑋
𝑖
,
S(t)=
i=1
∑
N(t)
	​

X
i
	​

,

where

𝑁
(
𝑡
)
∼
Poisson
(
𝜆
𝑡
)
N(t)∼Poisson(λt) is the arrival process,

𝑋
𝑖
∼
Exp
(
𝛾
)
X
i
	​

∼Exp(γ) are i.i.d. jump sizes,

𝑆
(
𝑡
)
S(t) is the accumulated jump magnitude up to time 
𝑡
t.

This Shiny app enables exact event-driven simulation of the process, visualization of sample paths, exploration of distribution behavior at multiple timescales, and real-time interpretation of how model parameters affect the system.

🚀 Features
✔️ 1. Interactive Parameter Control

Users can dynamically adjust:

λ – Poisson arrival rate

γ – Exponential jump-size rate

Number of simulations

Number of sample paths to plot

✔️ 2. Sample Path Visualization

Generates step-function trajectories of 
𝑆
(
𝑡
)
S(t) showing:

Rare jumps (small λ)

Frequent jumps (large λ)

Small or large jump sizes depending on γ

✔️ 3. Distribution Histograms

The app plots histograms of 
𝑆
(
𝑡
)
S(t) at:

t = 10

t = 100

t = 1000

t = 10000

This allows users to observe the transition from:

Skewed, discrete-like distributions at small 
𝑡
t

Nearly Gaussian behavior at large 
𝑡
t, due to the Central Limit Theorem

✔️ 4. Automatic Parameter Interpretation Panel

A dedicated “Parameter Effects” tab explains:

How λ impacts jump frequency

How γ affects jump magnitude and variance

How the expected value and variance of 
𝑆
(
𝑡
)
S(t) scale in time

How distribution shapes change under different parameter setups

This provides real-time theoretical context for the simulation output.

📊 Key Mathematical Properties

Mean jump size: 
𝐸
[
𝑋
𝑖
]
=
1
𝛾
E[X
i
	​

]=
γ
1
	​


Variance of jump size: 
Var
[
𝑋
𝑖
]
=
1
𝛾
2
Var[X
i
	​

]=
γ
2
1
	​


Mean of the process:

𝐸
[
𝑆
(
𝑡
)
]
=
𝜆
𝑡
𝛾
E[S(t)]=
γ
λt
	​


Variance of the process:

Var
[
𝑆
(
𝑡
)
]
=
2
𝜆
𝑡
𝛾
2
Var[S(t)]=
γ
2
2λt
	​


These expressions are integrated into the interpretation panel.

🛠 Technologies Used

R Shiny for interactive UI

ggplot2 for plotting

Base R simulation methods (Poisson increments + exponential jumps)

📦 How to Run
library(shiny)
shiny::runApp("path_to_project/")


or simply open the .R file in RStudio and click Run App.

🎯 Purpose

This application serves as an educational and analytical tool for:

Students learning stochastic processes

Actuarial science coursework

Financial engineering simulations

Demonstrations of Poisson-driven jump models

Exploratory model analysis

The combination of simulation, visualization, and interpretation makes it ideal for teaching, research, and interactive exploration.

#Compound Poisson Process Simulator (R Shiny App)

This project provides an interactive R Shiny application for simulating and analyzing the Compound Poisson Process (CPP), a fundamental stochastic model widely used in insurance risk, finance, queueing systems, and reliability engineering. The process is defined as:

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
N(t) is a Poisson process with arrival rate λ, and the jump sizes 
𝑋
𝑖
X
i
	​

 follow an exponential distribution with rate γ. This app enables users to explore how the compound Poisson process behaves over time and how its distribution changes under different parameter settings.

##🚀 Key Features
###🔧 Adjustable Parameters

λ (arrival rate): Controls how often jumps occur

γ (jump-size rate): Controls average jump size

Number of simulations

Number of sample paths to plot

##📈 Sample Path Visualization

Generate multiple realizations of 
𝑆
(
𝑡
)
S(t) to observe:

Large jumps vs. small jumps

Sparse vs. dense arrival events

Smooth vs. noisy paths depending on parameters

##📊 Histogram Exploration

View the distribution of 
𝑆
(
𝑡
)
S(t) at four time points:

t = 10

t = 100

t = 1000

t = 10000

This shows how:

Early-time distributions are skewed

Large-time distributions approach normality (Central Limit Theorem)

##📘 Parameter Interpretation Panel

A built-in explanation automatically interprets:

How λ affects jump frequency

How γ determines jump magnitude

The expected value: 
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
/
𝛾
E[S(t)]=λt/γ

The variance: 
Var
(
𝑆
(
𝑡
)
)
=
2
𝜆
𝑡
/
𝛾
2
Var(S(t))=2λt/γ
2

How the process behavior changes over time


This app provides an intuitive, visual, and interactive way to understand compound Poisson processes—something traditional textbooks cannot deliver. It is ideal for:

Students learning stochastic processes

Actuarial science and financial engineering courses

Researchers exploring jump-process behavior

Anyone wanting to experiment with Poisson-driven models

##▶️ Running the App

Clone the repository and run:

shiny::runApp("path_to_project/")


or open the file in RStudio and click Run App.

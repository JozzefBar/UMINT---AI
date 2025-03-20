
# UMINT-Assignments - Matlab 🤖
This repository contains tasks created for the **Artificial Intelligence** course at the Faculty of Electrical Engineering and Informatics, STU. All tasks are implemented in **Matlab**.

<img src = pics/Calculate-Artificial-Intelligence-GIF-by-Pudgy-Penguins.gif alt = "gif" width = 200 hspace = 50>

## Contents 📚

- [Installation](#installation-)
- [Usage](#usage-%EF%B8%8F)
- [Assignments](#assignments-)
  - [Assignment 1](#assignment-1%EF%B8%8F⃣)
  - [Assignment 2](#assignment-2%EF%B8%8F⃣)
  - [Assignment 3](#assignment-3%EF%B8%8F⃣)
  - [Assignment 4](#assignment-4%EF%B8%8F⃣)

## Installation 📥

To run the projects, you need to have **Matlab** installed. **Matlab version 2024b** was used during creation

1. Download and install [Matlab](https://www.mathworks.com/products/matlab.html) .
2. Download necessary Toolboxes.

		Computer Vision Toolbox
		Deep Learning Toolbox
		Fuzzy Logic Toolbox
		Optimization Toolbox
		
4. Clone this repository.
5. Open Matlab, navigate to the directory where this repository is stored.

## Usage ⚙️

Each project includes separate scripts and functions, which can be executed directly in the Matlab environment. The scripts are labeled with the assignment names and can be run directly from Matlab.

To run the tasks, follow these steps: 
1. Open **Matlab**. 
2. Navigate to the directory where the files are stored using the Matlab file explorer. 
3. Add the necessary functions to the Matlab path
4. Run the main program *(usually named cviko+sth.)*

## Assignments 📄

All assignments are in file [seminar](seminar/).

For assignments 1 - 4, there is a separate PDF with images and detailed descriptions. Additionally, lecture PDFs contain theoretical explanations of the tasks. *(But in **Slovak Language!**)*

### Assignment 1️⃣

Find the global minimum of the **New Schwefel function** for one variable using the **hill-climbing algorithm**.

-   The function is defined in `testfn3b.m` within the domain -800 < x < 800.
-   Start searching from a random point on the x-axis.
-   Choose an appropriate step size.
-   Display the steps using different markers in a graph.
-   Mark the final result with a unique color.

**Bonus:**
-   Implement a **stochastic hill-climbing algorithm**.
-   Extend the task to 2D and 3D function optimization.

   <img src = pics/pic1.png alt = "pic1" width = 500 hspace = 50>
    
### Assignment 2️⃣
 
Find the global minimum of the **New Schwefel function** for 10 variables using a **genetic algorithm (GA)**.

Steps:
1.  Review the lecture on **evolutionary and genetic algorithms**.
2.  Implement your own GA program.
3.  Run the GA and plot the **fitness function evolution** over generations.
4.  Output the **best individual** with its coordinates and fitness value.
5.  Run the GA multiple times, compare results, and discuss them.
    
**Bonus:** Solve the problem for **100 variables** and the **Eggholder function** for 10 variables.
    
<img src = pics/pic2.png alt = "pic2" width = 450 hspace = 50>

### Assignment 3️⃣

Design a **genetic algorithm** to compute the shortest path for a mobile robot visiting **20 points** in a 2D plane.
-   The robot must start at **(0,0)** and end at **(100,100)**.
-   The chromosome represents a **permutation of point indices**.
-   The fitness function calculates the **total path length**.
-   Modify **mutation and crossover operations** to handle permutations.
-   Run the GA at least **10 times**, visualize the **best-found path** and compare results.
    
<img src = pics/pic3.png alt = "pic3" width = 450 hspace = 50>

### Assignment 4️⃣

Optimize **investment allocation** into financial products using a **genetic algorithm**.

-   Respect given **constraints** (as explained in lectures).
-   Modify the **fitness function** by adding penalties for constraint violations.
-   Run the GA multiple times, compare results, and analyze constraint fulfillment.

<img src = pics/pic4.png alt = "pic3" width = 450 hspace = 50>


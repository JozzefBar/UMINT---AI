
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
  - [Assignment 5](#assignment-5%EF%B8%8F⃣)
  - [Assignment 6](#assignment-6%EF%B8%8F⃣)
  - [Assignment 7](#assignment-7%EF%B8%8F⃣)
  - [Assignment 8](#assignment-8%EF%B8%8F⃣)
  - [Assignment 9](#assignment-9%EF%B8%8F⃣)
- [Personal Documentation](#personal-documentation-%EF%B8%8F)

## Installation 📥

To run the projects, you need to have **Matlab** installed. **Matlab version 2024b** was used during creation

1. Download and install [Matlab](https://www.mathworks.com/products/matlab.html) .
2. Download necessary Toolboxes.

		Computer Vision Toolbox
		Deep Learning Toolbox
		Fuzzy Logic Toolbox
		Optimization Toolbox

3. Download opational Toolboxe *(for better workspace)*

   		New Desktop for MATLAB Tech Preview
     
5. Clone this repository.
6. Open Matlab, navigate to the directory where this repository is stored.

## Usage ⚙️

Each project includes separate scripts and functions, which can be executed directly in the Matlab environment. The scripts are labeled with the assignment names and can be run directly from Matlab.

To run the tasks, follow these steps: 
1. Open **Matlab**. 
2. Navigate to the directory where the files are stored using the Matlab file explorer. 
3. Add the necessary functions to the Matlab path
4. Run the main program *(usually named cviko+sth. or programy_ulohyXX)*

## Assignments 📄

All assignments are in file [seminar](seminar/).

For assignments `1 - 4`, `5 - 8` and `9`, there is a separate PDF with images and detailed descriptions. Additionally, lecture PDFs contain theoretical explanations of the tasks. *(But in **Slovak Language!**)*

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

### Assignment 5️⃣

5a – Classification with MLP
Create a multi-layer perceptron (MLP) network to classify points into 5 groups based on 3D coordinates (x, y, z). Data is in databody.mat. Use patternet for classification and split data into training (max. 80%) and testing.

- Tune the number of hidden neurons to minimize classification error.
- Plot the training error and the confusion matrix.
- Classify 5 predefined test points and visualize group assignment.

<img src = pics/pic5a.png alt = "pic1" width = 500 hspace = 50>

5b – Function Approximation with MLP
Approximate a non-linear function f(x) = y using an MLP network (fitnet). Data is in datafun.mat.

- Use provided training/testing indices.
- Find minimal number of hidden neurons to reach test error < 1e-4.
- Plot error curves for training and testing.
- Compute SSE, MSE, MAE for different neuron counts.
- Visualize real vs. predicted outputs.

<img src = pics/pic5b.png alt = "pic1" width = 500 hspace = 50>

### Assignment 6️⃣

Use an MLP network to classify fetal condition based on CTG (cardiotocographic) measurements. Use CTGdata.mat, which contains 2126 samples with 25 features and 3 classes (normal, suspect, pathological).

- Use up to 60% of data for training, rest for testing.
- Compare at least 3 network structures.
- Use confusion matrices to evaluate performance.
- Run 5-fold cross-validation or repeated training.
- Target classification accuracy on test data: >92%.

<img src = pics/pic6.png alt = "pic1" width = 500 hspace = 50>

### Assignment 7️⃣

Train an MLP network to recognize handwritten digits using the MNIST dataset. Inputs are 28x28 pixel images (flattened to 784 inputs), values normalized to [0, 1].

- Use max 60% of samples for training.
- Tune network structure to achieve >95% classification accuracy.
- Validate using cross-validation or multiple training runs.
- Evaluate accuracy using confusion matrices.

<img src = pics/pic7.png alt = "pic1" width = 500 hspace = 50>

### Assignment 8️⃣

Train a Convolutional Neural Network (CNN) to recognize handwritten digits (same MNIST dataset as in Assignment 7).

- Use 60% of data for training.
- Design CNN with 2–3 convolutional layers.
- Compare training progress and accuracy with MLP.
- Run training multiple times or use cross-validation.
- Evaluate using confusion matrix and accuracy scores.
- Compare two CNN structures and MLP vs CNN results.

<img src = pics/pic8.png alt = "pic1" width = 500 hspace = 50>

### Assignment 9️⃣

Create a fuzzy logic controller for a traffic intersection (FEI–ZOO) using a Mamdani system. Control signal timing for 3 traffic light configurations based on the number of cars waiting.
- Define fuzzy inputs: number of cars on green and red.
- Define output: green light duration.
- Tune fuzzy rules to minimize waiting cars and maximize throughput.
- Compare results of fixed-timing vs fuzzy logic in modes 3–6.
- Evaluate performance based on number of waiting cars.

**Bonus:**  *(not done)*
- Modify fuzzy inputs to improve control quality by at least 10% (adjust init_krizovatka).

<img src = pics/pic9.png alt = "pic1" width = 500 hspace = 50>

## Personal Documentation 🗃️

This repository also includes personal documentation in **Slovak language**. The documentation contains short summaries and outputs for each task.

-   Documentation for **Assignments 1–4** is available in:
    
    -   [`Assignments 1–4 pdf`](seminar/documentation/barcak_jozef/barcak_jozef.pdf)
        
    -   [`Assignments 1–4 docx`](seminar/documentation/barcak_jozef/barcak_jozef.docx)
        
-   Documentation for **Assignments 5–8** is available in:
    
    -   [`Assignments 5–8 pdf`](seminar/documentation/barcak_jozef/barcak_jozef2.pdf)
        
    -   [`Assignments 5–8 docx`](seminar/documentation/barcak_jozef/barcak_jozef2.docx)
        
-   **Assignment 9** does not have documentation.
    
All documentation with its screenshots is located in the [`documentation`](seminar/documentation) folder.

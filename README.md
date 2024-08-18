# 1D-Convolution in ARM Assembly Language


## Project Overview 

This project was a short 6-weeks project where teams of 2 were tasked to perform 1D convolution on a given kernel and signal arrays in ARM Assembly Code.

**Tech Stack**
- Programming Languages: C and ARM Assebly
- Software: STEM32CubeIDE
- Hardware: B-L475E-IOT01A development board
  (STM32L4 Series Microcontroller)


## Objective

Perform 1D Convolution on a given kernel and signal array

![Illustration of 1D Convolution](1D%20Convolution%20Example.png)

### 1D Convolution Explained

In a 1D convolution, a filter (or kernel) is slid across the input array, and at each position, the filter values are multiplied by the corresponding input values and summed to produce the output.

For example, consider the following input array and filter:

**Input:** `[1, 2, 3, 4, 5]`  
**Filter:** `[1, 0, -1]`

The convolution operation at each step would look like this:

1. `[1*1 + 2*0 + 3*(-1)] = -2`
2. `[2*1 + 3*0 + 4*(-1)] = -2`
3. `[3*1 + 4*0 + 5*(-1)] = -2`

So, the resulting output would be `[-2, -2, -2]`.


## Explanation of Code

### main.c

C Program that calls assembly function with given parameters and checks it against ground truth.

### convolve.s

File for ARM assembly Code for 1D Convolution

To achieve an 1D convolution, we split the function into 3 smaller parts

1. Flipping of Kernel Signal
2. Padding of Input Signal with additional zeros
3. Calculation 1D of Convolution Result

*Refer to code comments in convole.s file, written for readability*

**Flipping of Kernel Signal**

Flipping of kernel signal was done by simply having two iterators from the front and end of the kernel signal, and swapping the two values while moving the iterators

**Padding of Input Signal with additional zeros**

Padding of input signal with additional zeros are necessary to make the 1D convolution calculation easier in the next step.

This was achieved by assigning a new space in memory to be the padded signal array. Storing N - 1 zeros, then the original signal, and finally another N - 1 zeros into the new array, where N is the signal size into the array.

**Computation of 1D Convolution Result**

The 1D convolution result was computed by using a double loop, where the outer loop would loop M + N times, and inner loop would loop M times, where M is the kernel size and N is the signal size.  
There are M + N - 1 positions to consider. To calculate the dot product of every position, we iterate from 1 to M + N - 1, calculating the dot product at every position with no special consideration to the indexing or edge cases due to the zero padding of the signal.

Example: `Signal [1,2,3]`  `Kernel [1,1,1]`

First iteration
<pre>
0 0 1 2 3 0 0  	
1 1 1
</pre>

Second iteration

<pre>
0 0 1 2 3 0 0  	
  1 1 1
</pre>  

Second-last iteration
<pre>
0 0 1 2 3 0 0  	
      1 1 1
</pre>  
Last iteration 
<pre>
0 0 1 2 3 0 0  	
        1 1 1
</pre>  



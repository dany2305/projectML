# projectML
PEGASOS ALGORITHM - Primal Estimated sub-GrAdient SOlver for SVM


I describe and analyze a simple and effective stochastic sub-gradient descent algorithm for solving the optimization problem cast by Support Vector Machines (SVM).
In particular, Pegasos solves the primal formulation, hence optimizing directly the weights w.
I analyze the Basic Pegasos Algorithms (with a Projection Step) and the Mini-Batch Iterations (a more general algorithm that utilizes k examples at
each iteration instead of 1). 

All the code is written in Matlab. 

The"PEGASOS2.m" file contains the Pegasos algorithm code and the "PEGASOSBATCH.m" file contains the Pegasos Mini-Batch code. 
The user must give in input the x data, y data, the number of iterations (default 10k, there is also a stop-criteria), the lambda regularization parameter (and the number of k samples).
The "Crossval.m" file contains the code for hold-out cross-validation in order to evaluate the best lambda for the Pegasus model.
The "CrossvalBatch.m" file contains the code for hold-out cross-validation in order to evaluate the best lambda for the Pegasus Mini-Batch model.
Train the models with the lambdas found, then use the test set for evaluate the accuracy of your models. 
To make predictions on the data use "Test.m" then calculate the prediction error with "Error.m". For a simple graph-result use "graphErr.m".
The "Shuffle.m" file is useful for shuffling the row of your dataset randomly.

I use a public dataset. It is available here: https://archive.ics.uci.edu/ml/datasets/wine+quality 
The Pegasos paper: http://ttic.uchicago.edu/~nati/Publications/PegasosMPB.pdf



# Heart Arrhythmia Detection and Classification

We use the arrhythmia dataset found at the UCI Machine Learning Repository (Bache &Lichman, 2013; Guvenir, 1997). It consists of 452 records with 279 attributes per record. Each record is assigned to 1 of 16 classes: a class label of 1 indicates normal ECG patterns while a class label between 2 to 16 indicates “abnormal ECG patterns” or arrhythmia of varying types. The dataset’s class distribution is shown in Figure.

In our experiment, we use principal component analysis to extract features from the dataset. Using these principal components, we train model and results.

We employ a multi-layer neural network for both binary and multi-class classification. We train the network using back propagation and stochastic gradient descent to minimize the cost function.
Regularized cost function for multi-layer neural networks. Let theta to the power l contain the network parameters for layer l, htheta(x) belongs to RK be the output probabilities where K is the number of classes, (htheta(x) )i denotes the ith output, L denotes the number of layers and sl denotes the number of neurons in layer l.
Due to the large number of hyper parameters, a significant portion of this project was devoted to exploring the effect of hidden layer size, depth, learning rate, and regularization parameters. Perhaps the most important hyper parameter, we analyze the effect of the number of neurons on performance.

We can see, the number of neurons grows, the performance decreases. This is apparent for both the binary and multi-class case. Based on these results, we use 100 neurons at each layer. Although the analysis is not shown, deeper networks do not necessarily produce better results. Most often, performance suffered as the number of hidden layers increased. Based on this analysis, we select two hidden layers for our network topology. Instead of using features from the raw dataset, we use principal components as inputs into our neural network. As shown in figure below, we analyze the number of principal components versus the classification accuracy.
Too few(less than 50) or too many (greater than 200) principal components result in poor performance across all models. Based on these results, we use 100 principal components for our final model. The regularization parameter attempts to prevent over fitting λ by reducing the magnitude of parameters in ϴ. Fixing all other parameters, we vary λ for various values, and set λ = 0.01.

In summary, we use the following hyperparameters:

1.	Regularization parameter, λ = 0.01 
2.	Two hidden layers L = 2 
3.	One hundred neurons at each layer H1 = H2 = 100 
4.	First 100 principal components are used as features

Following is the structure of the model:

- IMPUTE.m - MATLAB code to impute the original dataset
- ACCURACY_PLOT.m -Take input files containing results of the neural network tuning stage, generate and form plots.
- SVD_single_iter.m - Trains a single neural network using specified parameters
- TRAIN.m - Iteratively trains several neural networks by varying several hyperparameters, training set size, and train/test ratios.
- COMPILE.m - To run the trained neural network to identify arrhythmia according to input time series values

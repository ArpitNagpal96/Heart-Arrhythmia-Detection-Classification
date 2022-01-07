clc;
clear;
CLASSIFICATION_STYLE = 1;
NUM_FEATURES = 279;
NUM_COMPONENTS = 100;

set(0,'DefaultAxesFontSize', 12)
set(0,'DefaultTextFontSize', 12)


data = csvread('data_clean_imputed.csv');
m = length(data(:,1));
[U,S,V] = svd(data);


X = U(:,1:NUM_COMPONENTS);
y_label = data(:,end);

C=S;  
N=100;  
C(N+1:end,:)=0;  
C(:,N+1:end)=0;  
D=U*C*V';


    % Binary classification
    y(y_label == 1,2) = 1;
    y(y_label > 1,1) = 1; % First column is the "true" and has arrithmia

 %Plots distribution of input classes
 class_dist = tabulate(y_label);
 figure
 bar(class_dist(:,1),class_dist(:,2));
 ylabel('Number of Instances');
 xlabel('Class Label');
 xlim([0 17]);

inputs = X';
targets = y';

hiddenLayerSize = [100 100];
net = patternnet(hiddenLayerSize);
% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 0/100;
net.divideParam.testRatio = 30/100;
net.trainFcn = 'trainscg';
net.performFcn = 'mse';
net.performParam.regularization = .01;

% Train the Network
[net,tr] = train(net,inputs,targets,'useGPU','no');

% Test the Network
outputs = net(inputs);
errors = gsubtract(outputs,targets);

%performance = perform(net,targets,outputs)
mse = mse(net,targets,outputs);



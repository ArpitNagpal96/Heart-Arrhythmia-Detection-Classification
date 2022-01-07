clc;
clear;

CLASSIFICATION_STYLE = 1;
NUM_FEATURES = 100;
set(0,'DefaultAxesFontSize', 14)
set(0,'DefaultTextFontSize', 14)
training_sizes = 452;

data = csvread('data_clean_imputed.csv');
    X = data(1:training_sizes,1:NUM_FEATURES);
    y_label = data(1:training_sizes,end);


        % Binary classification
        y(y_label == 1,2) = 1;
        y(y_label > 1,1) = 1; % First column is the "true" and has arrithmia
    

   

    inputs = X';
    targets = y';
    hiddenLayerSize = [100 100];
    mse_per_layer = zeros(1,length(hiddenLayerSize));
    for hls = 1:length(hiddenLayerSize)
        net2 = patternnet(hiddenLayerSize,'trainscg','mse');
        
        % Set up Division of Data for Training, Validation, Testing
        net2.divideParam.trainRatio = 62/100;
        net2.divideParam.valRatio = 8/100;
        net2.divideParam.testRatio = 30/100;
        net2.performParam.regularization = 0.01;

        % Train the net2work
        [net2,tr] = train(net2,inputs,targets,'useGPU','no');
        
         % Test the net2work
        outputs = net2(inputs);
        errors = gsubtract(outputs,targets);
        %performance = perform(net2,targets,outputs)
        mse_per_layer(hls) = mse(net2,targets,outputs);

        % View the net2work
       view(net2)
        folder='C:\Users\Dell\Desktop\MAJOR';
        dlmwrite(fullfile(folder,'test_mse.csv'),tr.tperf,'delimiter',',','-append');
        dlmwrite(fullfile(folder,'validate_mse.csv'),tr.vperf,'delimiter',',','-append');
        dlmwrite(fullfile(folder,'train_mse.csv'),tr.perf,'delimiter',',','-append');
        %figure, plotperform(tr)
       % figure, plottrainstate(tr)
        %figure, plotconfusion(targets,outputs)
        %figure, ploterrhist(errors)
        
[val, idx] = max(outputs); 
        split_index = round(training_sizes*.7);
        test_size = training_sizes - split_index;
        train_accuracy = sum(idx(1:split_index) - y_label(1:split_index)' ~= 0)/split_index;
        test_accuracy = sum(idx(split_index+1:end) - y_label(split_index+1:end)' ~= 0)/test_size;
        fprintf('NN Size: %d\tMSE: %d\n', hiddenLayerSize(hls), mse_per_layer(hls));

    end

plot(hiddenLayerSize, mse_per_layer,'-b^')
ylabel('Mean Squared Error (MSE)');
xlabel('Number of Layer 1 Neurons');



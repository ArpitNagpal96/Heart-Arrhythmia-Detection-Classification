clear ;
clc;
data = csvread('data_clean_imputed.csv');
X1 = data(:,1:end-1);
y1 = data(:,end);
impute1 = zeros(1,length(data(1,:)-1));

% For each column, compute mean from non-9999 values
for i = 1:length(data(1,:)-1)
   non9999 = find(data(:,i) ~= -9999);
   impute1(i) = mean(data(non9999,i));
end

% Convert ? (or -9999s) to mean column values
for i = 1:length(data(:,1))
   for j = 1:length(data(1,:))
      if data(i,j) == -9999
         data(i,j) = impute1(j);
      end
   end
end
location='C:\Users\Dell\Desktop\MAJOR';
csvwrite(fullfile(location,'data_clean_imputed.csv'),data);
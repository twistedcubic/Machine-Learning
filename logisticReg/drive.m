%imports and pre-processes data

clear;

data = load('data2.txt');

X = data(:, [1, 2]);
y = data(:, 3);

[m, n] = size(X);
%normalize X and y: subtract mean and divide by SD
for i = 2:n
    X(:,i) = X(:,i) - mean(X(:,i));
    X(:,i) = X(:,i) ./ std(X(:,i));    
end

y(:,1) = y(:,1) - mean(y(:,1));
y(:,1) = y(:,1) ./ std(y(:,1));
    
% add intercept terms as the first column
X = [ones(m, 1) X];
theta0 = zeros(n + 1, 1);

% use logistic model to predict 
[C, G] = cost(X, y, theta0, @(X) sigmoid(X));

fprintf('For theta0, Cost: %f\n', C);
fprintf('For theta0, Gradient:\n');
disp(G)

% train the model to find the theta that minimizes cost
% using various methods

% use gradient descent
% @params: cost function, initial theta, step size, max iteration

% batch gradient descent
alpha = 0.01;
maxIter = 400;
[T, C] = gradientDesc(X, @(t)cost(X, y, t, @(X1)sigmoid(X1)), theta0, alpha, maxIter);
fprintf('Batch gradient descent optimal theta for %d iterations', maxIter);
disp(T);

% stochastic gradient descent
[T_stoc, C_stoc] = stocGradDesc(X, @(X,t)cost(X, y, t, @(X1)sigmoid(X1)), theta0, alpha, 10);
fprintf('Stochastic gradient descent optimal theta for %d iterations over data', 10);
disp(T_stoc);

% use newton to find direction
[T_stoc, C_stoc] = newton(X, @(X,t)cost(X, y, t, @(X1)sigmoid(X1)), theta0, alpha, 10);

% use conjugate gradient

       


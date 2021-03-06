function [theta, C] = newton(X, cost_fn, theta0, epsilon)
% use Newton's direction
% use BFGS to update approximation of Hessian
% (its inverse)
% use   to update step size
% Upto error tolerance epsilon

%initial step size
alpha0 = 0.1;
i = 1;

[C, G_new] = cost_fn(X, theta0);
B = eyes(size(theta0, 1));

% tuning parameter for step size
tau = 0.1;

while G_new' * G_new > epsilon
    % newton's direction
    p_new = -B   *   G;
    alpha = tau / (tau + i) * alpha0;
    % Or use line search:
    %alpha = lineSearch(theta, @(t)cos_fn(X, t), p_new);
    s = alpha * p_new;
    theta = theta + s;
    G_old = G_new;
    [C, G_new] = cost_fn(X, theta);
    diff = G_new - G_old;
    I = eyes(size(theta0, 1));
    
    % update approximation for inverse of Hessian
    if i == 1
        B = (diff * s' )/(y * y')  .* I ;
    else 
        temp = (diff * s')^(-1);
        B = (I - temp * s * diff')*B*(I - temp*diff*s')...
            + temp * s * s';
    end   
    i = i+1;

end


end
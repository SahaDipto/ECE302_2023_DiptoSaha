
function [Y_mmse, sigma_2_mmse, Y_llse, sigma_2_llse] = MMSE_LLSE_attempt(Y_bounds, W_bounds, edges, rowparam, columnparam)
    
    Y = unidistgen(Y_bounds, rowparam, columnparam);
    W = unidistgen(W_bounds, rowparam, columnparam);
    
    X = Y + W;

    %Discretize the data so that I can store my values into their
    %respective bins. This essentially helps me determine what range my X
    %values fall into.
    Y_mmse = discretize(X, edges);

    %This is the entire MMSE calculation

    Y_mmse(Y_mmse == 1) = 1/2 + 1/2*(X(Y_mmse == 1));
    Y_mmse(Y_mmse == 2) = 0;
    Y_mmse(Y_mmse == 3) = -1/2 + 1/2*(X(Y_mmse == 3));
    
    sigma_2_mmse = mean((Y-Y_mmse).^2);
    
    
    Y_llse = X/5;
    sigma_2_llse = mean((Y - Y_llse).^2);

end
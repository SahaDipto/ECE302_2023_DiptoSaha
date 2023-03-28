%%Generates the MSE for the gaussian R.V. Y and R based on the number of
%%observances inputted

function [MSE, idealmse] = Observances(sigmaY, sigmaR, n, obser_num)
    idealmse = zeros(obser_num, 1);
    MSE = zeros(obser_num, 1);
    for i = 1:obser_num
        Y = normrnd(1, sigmaY, n, 1);
        R = normrnd(0, sigmaR, n, i);

        X = Y + R;
        Yp = (i*sigmaY^2 + sigmaR^2)^-1*(sigmaR^2 + sigmaY^2*sum(X, 2));
        MSE(i, 1) = mean((Yp - Y).^2);
        idealmse(i, 1) =  sigmaY^2*sigmaR^2*((i*sigmaY^2 + sigmaR^2)^-1);

    end
end
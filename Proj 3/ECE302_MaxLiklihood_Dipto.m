clc;
clear;
close all;
%Maximum liklihood estimator:

%These values can be changed and the function and graphs would update with
%these values, you can change these values and you can submit more than 3
%values for the sigma and mu.
Sigma = [0.5 1 2];
Mu = [0.5 1 2];
observation = 30;
trials = 1e5;

%Rayleigh likelihood simulation
[MSE_rayl, Var_rayl, Bias_rayl] = max_likelihood.ML_sim(Sigma, observation, trials, 'Rayleigh');

%Exponential likelihood simulation
[MSE_expo, Var_expo, Bias_expo] = max_likelihood.ML_sim(Mu, observation, trials, 'Exponential');

%% Part 2
load("data.mat", "data");

Data_est_rayl = max_likelihood.ML_estimate(data, "Rayleigh");
Data_est_expo = max_likelihood.ML_estimate(data, "Exponential");

Likelihood_rayl = sum(log(raylpdf(data, Data_est_rayl)),2);
Likelihood_expo = sum(log(exppdf(data, Data_est_expo)),2);

%The maxmimum log likelihood corresponds to the rayleigh distribution, as a
%result it is definite to say that the distribution that data belongs to is
%a rayleigh distribution

%% Graphs for the MSE, Variance, and Bias for the likelihood estimation
max_likelihood.graph(observation, MSE_rayl, Var_rayl, Bias_rayl, Sigma,"Rayleigh");
max_likelihood.graph(observation, MSE_expo, Var_expo, Bias_expo, Mu, "Exponential");

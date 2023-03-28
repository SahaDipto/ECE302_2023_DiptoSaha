clc;
clear;
close all;
%%
%specifying the number of iterations for the entire projects
n = 1e5;

%Specifiyin bounds of X and Y for their generation
Y_bounds = [-1 1];
W_bounds = [-2 2];

%This is for calculating the MMSE estimate
edges_mmse = [-3, -1, 1, 3];

%Theoretical values to compare to
MSE_mmse_correct = 1/4;
MSE_llse_correct = 4/15;

[Y_mmse, sigma_2_mmse, Y_llse, sigma_2_llse] = MMSE_LLSE_attempt(Y_bounds, W_bounds, edges_mmse, n, 1);

%Table

type = ["MMSE"; "LMSE"];
theoreticalMSE = [MSE_mmse_correct; MSE_llse_correct];
calculatedMSE = [sigma_2_mmse; sigma_2_llse];

table_mse = table(type, theoreticalMSE, calculatedMSE)
%%
%Values to test for the std dev of Y and R

%This is the most basic case
sigmay1 = 3;
sigmar1 = 4;

%extreme case when signal has a lot of std dev but noise does not
sigmay2 = 10;
sigmar2 = 1;

%extreme case when signal has low std dev and noise has a lot.
sigmay3 = 1;
sigmar3 = 10;

%max range for the number of observations to be used
rangeforobserv = 100;

%Auto updating legend
Legend_str1 = "Experimental \sigma_Y =" + sigmay1 + ", \sigma_R = "+ sigmar1;
Legend_str2 = "Experimental \sigma_Y =" + sigmay2 + ", \sigma_R = "+ sigmar2;
Legend_str3 = "Experimental \sigma_Y =" + sigmay3 + ", \sigma_R = "+ sigmar3;
Legend_str4 = "Theoretical \sigma_Y =" + sigmay1 + ", \sigma_R = "+ sigmar1;

Legend_str5 = "Theoretical \sigma_Y =" + sigmay2 + ", \sigma_R = "+ sigmar2;

Legend_str6 = "Theoretical \sigma_Y =" + sigmay3 + ", \sigma_R = "+ sigmar3;

%%
%MSE calculations
[MSE_set1, theoreticalMSE_set1] = Observances(sigmay1, sigmar1, n, rangeforobserv);
[MSE_set2, theoreticalMSE_set2] = Observances(sigmay2, sigmar2, n, rangeforobserv);
[MSE_set3, theoreticalMSE_set3] = Observances(sigmay3, sigmar3, n, rangeforobserv);

%% 
%figure for plotting
figure;
hold on;
plot(1:rangeforobserv, MSE_set1 , 'k');
plot(1:rangeforobserv, MSE_set2, 'b');
plot(1:rangeforobserv, MSE_set3, 'r');
plot(1:rangeforobserv, theoreticalMSE_set1, 'kx');
plot(1:rangeforobserv, theoreticalMSE_set2,'bx');
plot(1:rangeforobserv, theoreticalMSE_set3, 'rx');
hold off;
title("MSE vs # of observations");
xlabel("# of observations");
ylabel("MSE");
ylim([0 inf]);
xlim([0 inf]);
legend(Legend_str1, Legend_str2, Legend_str3, Legend_str4, Legend_str5, Legend_str6 );




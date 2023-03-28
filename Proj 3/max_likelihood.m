
%This classdef contains all the functions used for this corresponding Stoch
%Project. In this Stoch project, we are taxed with deriving and
%implementing a max liklihood estimator for a Rayleigh and Exponential
%distribution. The data was first generated from a Rayleigh or Exponential
%distribution depending on what the selected mode is. From there, the max
%likelihood estimate is determined from the data. Looking at the MSE, Var,
%and Bias plots, the function seems to 
classdef max_likelihood
    methods(Static)

        %__________________________________________________________________
        function [ml_estimate] = ML_estimate(x_n, mode)
            
            switch mode
                
                case "Rayleigh"
                    %If Rayleigh is chosen then the input for the function
                    %is the stddev, so this find the max likelihood for
                    %the stddev.
                    ml_estimate = sqrt(sum(x_n.^2, 2)/(2*size(x_n, 2)));
                
                case "Exponential"
                    %If Exponential is chosen, then the input for the
                    %function is the average, so it finds the max
                    %likelihood for the average.
                    ml_estimate = (sum(x_n, 2))/size(x_n, 2);             
                
                otherwise
                    %If another distribution is chosen, then it is an error
                    error("Assignment ");
            end
        end

        %__________________________________________________________________
        function [MSE, Var, Bias] = ML_sim(Param, N_obs, N_trials, mode)
            
            %Pre allocation for the matrices
            estimate = zeros(N_trials, N_obs, size(Param, 2));
            
            %Mean Square error
            MSE = zeros(N_obs, size(Param, 2));
            
            %Variance 
            Var = zeros(N_obs, size(Param, 2));

            %Bias
            Bias = zeros(N_obs, size(Param, 2));

            
            for i = 1:N_obs
                for z = 1:size(Param, 2)
                    switch mode
                        %Depending on the mode selected, it generates the
                        %corresponding data.
                        case "Rayleigh"
                            sample1 = raylrnd(Param(z), [N_trials, i]);
                        case "Exponential"
                            sample1 = exprnd(Param(z), [N_trials, i]);
                        otherwise
                            error("error");
                    end
                    
                    %This also depends on the mode selected. It will
                    %calculate the corresponding max likelihood estimate of
                    %either Mu or Sigma for the exponential and rayleigh
                    %distributions
                    estimate(:, i, z) = max_likelihood.ML_estimate(sample1, mode);
                    
                    %Calculates the MSE, Var, and Bias of the estimate.
                    MSE(i, z) = sum((Param(z) - estimate(:, i, z)).^2)/N_trials;
                    Var(i, z) = mean(estimate(:, i, z).^2, 1) - mean(estimate(:, i, z), 1).^2;
                    Bias(i, z) = mean(estimate(:, i, z), 1) - Param(z);

                end
            end
        end
        %__________________________________________________________________
        function graph(N_obs, MSE, Var, Bias, param, mode)
            %This is an auto graphing function that automatically updated
            %the graph to fit any changes in the # of observations, trials,
            %and inputs to the raylrnd function
            x = 1:N_obs;
            switch mode
                case "Rayleigh"
                    type_in = "\sigma";
                case "Exponential"
                    type_in = "\mu";
                otherwise
                    error("Please chose Rayleigh or Exponential")
            end

            figure(Name=("MSE, Var, and Bias for " + mode + " distribution"));
            subplot(3, 1, 1)
            plot(x, MSE);
            %This automatically generates the corresponding legend for the
            %selected parameters
            legend(("MSE with " + type_in + " = " + string(param)));
            %Automatically updates the title for MSE plot the rest of the
            %graphing code functions the same way
            title("MSE for a maxlikelihood estimate of " + type_in+ " for a " + mode + " distribution");
            xlabel("# of Observations");

            
            subplot(3, 1, 2)
            plot(x, Var);
            legend("Variance for " + type_in + " = " + string(param));                  
            title("Variancefor a maxlikelihood estimate of " + type_in+ " for a " + mode + " distribution");
            xlabel("# of Observations")

            subplot(3, 1, 3)
            plot(x, Bias);
            legend("Bias for " + type_in + " = " + string(param));
            title("Bias for a maxlikelihood estimate of " + type_in+ " for a " + mode + " distribution");
            xlabel("# of Observations")
        
        end


    end
end
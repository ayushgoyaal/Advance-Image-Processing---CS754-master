%% AA
% $E(\beta_1,\beta_2,\beta_3) =  ||y_1 - R_1U\beta_1||^2 + ||y_2 - R_2U\beta_2||^2 + ||y_3 - R_3U\beta_3||^2$
% + $\lambda||\beta_1||_1 + \lambda||\beta_2-\beta_1||_1  + \lambda||\beta_3-\beta_2||_1$
%
% $=  ||y_1 - R_1U\beta_1||^2 + ||y_2 - R_2U(\beta_1 + \Delta\beta_{21})||^2 + ||y_3 - R_3U(\beta_1 + \Delta\beta_{21} + \Delta\beta_{32})||^2$
% + $\lambda||\beta_1||_1 + \lambda||\Delta\beta_{21}||_1  + \lambda||\Delta\beta_{32}||_1$
% 
% Convert this in to matrix form.
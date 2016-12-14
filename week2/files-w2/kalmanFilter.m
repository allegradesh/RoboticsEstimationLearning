function [ predictx, predicty, state, param ] = kalmanFilter( t, x, y, state, param, previous_t )
%UNTITLED Summary of this function goes here
%   Four dimensional state: position_x, position_y, velocity_x, velocity_y

    %% Place parammeters like covarainces, etc. here:
    dt = t-previous_t;
    Q = eye(4);  
    R = 1e-3*eye(2);
    A = [1 0 dt 0;0 1 0 dt;0 0 1 0;0 0 0 1];  
    %H = [1 0 -10*dt 0;0 1 0 -10*dt];
    H = [1 0 0 0;0 1 0 0];
         
    % Check if the first time running this function
    if previous_t<0
        state = [x, y, 0, 0];
        param.P = 10*Q;%0.1 * eye(4);
        predictx = x;
        predicty = y;
        return;
    end
    
    %% TODO: Add Kalman filter updates
    % As an example, here is a Naive estimate without a Kalman filter
    % You should replace this code
    vx_n = (x - state(1)) / (t - previous_t);
    vy_n = (y - state(2)) / (t - previous_t);
    % Predict 330ms into the future
    predictx_n = x + vx_n * 0.330;
    predicty_n = y + vy_n * 0.330;
    % State is a four dimensional element
    state_n = [x, y, vx_n, vy_n];
    
    % Kalman filter
    x_pred = A * state'; 
    P_pred = A * param.P * A' + Q;
    
    K = (P_pred*(H'))*inv(H*P_pred*H'+R);  
    
    state = (x_pred + K*([x,y]'-H*x_pred))';  % x_est
    param.P = P_pred - K*H*P_pred;     % P_est
    
    predictx = state(1)+state(3)*dt*10;
    predicty = state(2)+state(4)*dt*10;
end

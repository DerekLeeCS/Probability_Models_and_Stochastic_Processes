function est = MMSE_Y(X)

        % Get case
        temp = (-3 <= X & X < -1);
        temp = temp - (1 <= X & X <= 3);
        
        % Evaluate for cases
        %   Get 1/2*x portion
        est = (1/2)*X;
        est = est .* (temp~=0);
        
        %   Get +/- 1/2 portion
        est = est + (1/2)*temp;

end
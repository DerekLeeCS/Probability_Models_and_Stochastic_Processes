function plotDataEC( data, lambda, name_y, name_title )

    figure();
    hold on;
    
    for i = flip(1:length(lambda))
        semilogy( data(i,:), 'DisplayName', "Var=" + lambda(i) );
    end
    
    hold off;
    ylabel( name_y );
    title( name_title );
    legend();
    xlabel( "n index" );
    
end
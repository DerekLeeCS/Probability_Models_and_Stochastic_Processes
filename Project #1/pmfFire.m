function percent = pmfFire( dmg )

    switch( dmg )
        
        case 2
            percent = 0.25;
        case 3
            percent = 0.5;
        case 4
            percent = 0.25;
        otherwise
            percent = 0;
            
    end

end
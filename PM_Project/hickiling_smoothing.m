function [timeo] = hickiling_smoothing(Palv,TOPmin,TOPmax,Const_O,tinsp)

k = 0;
for i = 1:length(Palv)
    press = Palv(i);
    k = k +1;
    j = 0;
    for sp = -0.5:0.5:14.5
        j = j+1;
        for opressure = TOPmin:TOPmax
            if TOPmin == TOPmax || TOPmax == 0
                opressure = TOPmax;
            end
            open = 0.9;
            
            to = 0;
            
            if  press >(sp + opressure)
                
                if open < 1
                    open =  open + Const_O* (press - (sp + opressure))*(tinsp(k));
                    % reduction of time because at higher TINSP value of
                    % open get more than 1. so it reduces the time to get
                    % time when open variable is exact 1.
                    if  open > 1
                        while open > 1
                            dt = -0.001;
                            open =  open + Const_O* (press - (sp + opressure))*dt;
                            to = to + dt;
                            to1 = to + tinsp(k);
                        end
                    elseif open < 1
                        %addition of time if open variable is still less
                        %than 1.
                        while open < 1
                            dt = 0.001;
                            open =  open + Const_O* (press - (sp + opressure))*dt;
                            to = to + dt;
                            to1 = to + tinsp(k);
                        end
                    end
                end
            end
        end
        timeo(j,i) = to1;
        
    end
    
end
end




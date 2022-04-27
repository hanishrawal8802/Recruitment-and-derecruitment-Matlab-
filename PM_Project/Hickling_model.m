function [timeo,timec,volume,Cfinal,volume2,volume3] = Hickling_model(Palv,TOPmin,TOPmax,Const_O,Const_C,tinsp)
volume = [];
volume2=[];
volume3=[];
A =0.01;
B = 0.01;
K = 0.03;
Cfinal =[];
k = 0;

for i = 1:length(Palv) %alveolar pressure found by ode45
    press = Palv(i);
    k = k + 1;
    voltot=0;
    voltot3_1=0;
    voltot4_1=0;
    C2 = 0;
    j = 0;
    for sp = -0.5:0.5:14.5
        j = j+1;
        for opressure = TOPmin:TOPmax
            if TOPmin == TOPmax || TOPmax == 0
                opressure = TOPmax;
            end
            open = 0;
            close = 1;
            to = 0;
            tc = 0;
            if  press >(sp + opressure)
                vol = (9000*(A-B*exp(-K*(press-sp)))/(1+TOPmax-TOPmin));
                C = vol/(press-sp);
                tc1 = 0;
                if open < 1
                    open =  open + Const_O* (press - (sp + opressure))*(tinsp(k));
                    
                    if  open > 1
                        % reduction of time because at higher TINSP value of
                        % open get more than 1. so it reduces the time to get
                        % time when open variable is exact 1.
                        while open > 1
                            dt = -0.001;
                            open =  open + Const_O* (press - (sp + opressure))*dt;
                            to = to + dt;
                            to1 = to + tinsp(k);
                        end
                    elseif open <1
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
            elseif press < sp
                if close >0
                    close =  close + Const_C*(press - sp)*(tinsp(k));
                    if close <=0
                        tc1 = tinsp(k);
                    else
                        while close >0
                            dt = 0.001;
                            close =  close + Const_O*(press - sp)*dt;
                            tc = tc + dt;
                            
                        end
                        tc1 = tc + tinsp(k);
                    end
                end
            else
                vol = 0;
                C = 0;
            end
            
            voltot= voltot + vol;
            C2 = C2 + C;
            
            %%%%%%%%%%%%%%%%%%%%%%
            if to1<0.1
                if press >(sp + opressure)
                   vol_1 = (9000*(A-B*exp(-K*(press-sp)))/(1+TOPmax-TOPmin));
                else
                    vol_1=0;
                end
            else
                vol_1=0;
            end
            voltot3_1=voltot3_1+vol_1;
            
            if tc1<0.1
                if press > sp 
                    vol_2 = (9000*(A-B*exp(-K*(press-sp)))/(1+TOPmax-TOPmin));
                else
                    vol_2=0;
                end
            else
                vol_2=0;
            end
            voltot4_1=voltot4_1+vol_2;
            
        end
        
        
        timeo(j,i) = to1;
        timec(j,i) = tc1;
    end
    voltot2 = voltot;
    volume(end+1)= voltot2;
    Cfinal(end+1) = C2;
    
    
    
    
    volume2(end+1) = voltot3_1;
    volume3(end+1) = voltot4_1;
end
end




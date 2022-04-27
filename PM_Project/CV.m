function [Cfinal,volume] = CV(Palv,TOPmin,TOPmax)

volume = [];
A =0.01;
B = 0.01;
K = 0.03;
Cfinal =[];

for i = 1:length(Palv) %alveolar pressure found by ode45
    press = Palv(i);
    C2 = 0;
    voltot=0;
    j = 0;
    for sp = -0.5:0.5:14.5
        j = j+1;
        for opress = TOPmin:TOPmax
            if press >(sp+opress)
                vol = (9000*(A-B*exp(-K*(press-sp)))/(1+TOPmax-TOPmin));
                C = vol/(press-sp);
            else
                vol=0;
                C = 0;
            end
            voltot= voltot + vol;
            C2 = C2 + C;
        end
        
    end
    voltot2 = voltot;
    volume(end+1)= voltot2;
    Cfinal(end+1) = C2;
end
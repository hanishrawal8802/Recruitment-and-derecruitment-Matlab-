
function dpalv = ode_Press(t,Palv,flag,TOPmin,TOPmax)
Cfinal = [];


for i = 1:length(Palv)
    [Cfinal,~] = CV(Palv(i),TOPmin,TOPmax);
end
flow  = 700;
if t>=0 && t<=2
    if Cfinal == 0
        dpalv = 0;
    else
        dpalv=(1/Cfinal)*flow;
    end
else
    dpalv=0;
end
end

TOPmin = 0;
TOPmax = 0;

x=[1 2 3];     %Different Const values
y=[1 2 3]; %Different Const_c values
for i=1:length(x) 
 PEEP=0;
 Const_O=x(i);
 Const_C=y(i);

% pressure from the ode45 
 tinsp = 0:0.01:4;
 [tinsp,Palv] =ode45(@(tinsp,Palv) ode_Press(tinsp,Palv,'',TOPmin,TOPmax),tinsp,PEEP);
 Palv = round(Palv);
%applying the ode pressure to hickling model with salazar function 

 [~,~,~,~,volume2,volume3] = Hickling_model(Palv,TOPmin,TOPmax,Const_O,Const_C,tinsp);
 marker = ['--','+','*'];

% pressure_volume for diffrent Const values
 subplot(2,1,1)
 plot(Palv,volume2,marker(i),'linewidth',1)
hold on
title('Influence of Const')
xlabel('Alveolar Pressure')
ylabel('Volume')
lgd(i) = ('Const_O'+string(x(i)));
legend(lgd,'location','northwest')

subplot(2,1,2)
plot(Palv,volume3,marker(i),'linewidth',1)
hold on
title('Influence of Const_c')
xlabel('Alveolar Pressure')
ylabel('Volume')
lgd(i) = ('Const_O'+string(y(i)));
legend(lgd,'location','southeast')
end

%p/v curve  for diffrent PEEP

TOPmin = 0;
TOPmax = 0;
Const_O = 0.05;
Const_C = 0.05;


figure
PEEP = [0 4 8 12]; % different PEEP level
for i = 1:length(PEEP)    
param = PEEP(i);
tinsp = 0:0.01:4;
[tinsp,Palv] =ode45(@(tinsp,Palv) ode_Press(tinsp,Palv,'',TOPmin,TOPmax),tinsp,PEEP(i));
Palv = round(Palv);
[~,~,volume,~,~,~] = Hickling_model(Palv,TOPmin,TOPmax,Const_O,Const_C,tinsp);
% PV curve with diffrent PEEP

plot(Palv,volume,'LineWidth',2)
xlabel('alveolar pressure')
ylabel('volume')
[t,s] = title('P/V curve','salazar volume','Color','blue');
t.FontSize = 16;
s.FontAngle = 'italic';
lgd(i) = ('PEEP' + string(PEEP(i)));
legend(lgd,'Location','southeast')
hold on 
end
%Graph for opening time of layers

PEEP = 0;
tinsp = 0:0.01:4;
[tinsp,Palv] =ode45(@(tinsp,Palv) ode_Press(tinsp,Palv,'',TOPmin,TOPmax),tinsp,PEEP);
Palv = round(Palv);
[timeo,timec,volume,Cfinal,~,~] = Hickling_model(Palv,TOPmin,TOPmax,Const_O,Const_C,tinsp);
[timesmooth]  = hickiling_smoothing(Palv,TOPmin,TOPmax,Const_O,tinsp);
% time grapf for opening layer 

figure
for x = 1:length(0:0.5:14.5)
    plot(Palv,timeo(x,:))
    hold on
end

xlabel('Palv')
ylabel('open time')
[t,s] = title('opening time','all layer','Color','blue');
t.FontSize = 16;
s.FontAngle = 'italic';
% graph for three layer 

figure
plot(Palv,timeo(1,:),'b')
hold on
plot(Palv,timeo(15,:),'r')
hold on
plot(Palv,timeo(30,:),'g')
xlabel('alveolar pressure')
ylabel('open time')
[t,s] = title('opening time','1st 15th 30th layer of the lung','Color','blue');
t.FontSize = 16;
s.FontAngle = 'italic';
legend('layer 1','layer 15','layer 30')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% smooth opening of lung layer

figure
for x = 1:length(0:0.5:14.5)
    plot(Palv,timesmooth(x,:))
    hold on
end
xlabel('Palv')
ylabel('open time')
[t,s] = title('smooth opening time','all layer','Color','blue');
t.FontSize = 16;
s.FontAngle = 'italic';

% graph for three layer
figure
plot(Palv,timesmooth(1,:),'b')
hold on
plot(Palv,timesmooth(15,:),'r')
hold on
plot(Palv,timesmooth(30,:),'g')
xlabel('alveolar pressure')
ylabel('open time')
[t,s] = title('smooth opening time','1st 15th 30th layer of the lung','Color','blue');
t.FontSize = 16;
s.FontAngle = 'italic';
legend('layer 1','layer 15','layer 30')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% closing time 

figure
for y = 1:length(0:0.5:14.5)
    plot(Palv,timec(y,:))
    hold on
end
xlabel('alveolar pressure')
ylabel('close time')
[t,s] = title('closing time','all lung layer','Color','blue');
t.FontSize = 16;
s.FontAngle = 'italic';

% closing time three layer 

figure
plot(Palv,timec(1,:),'b')
hold on
plot(Palv,timec(15,:),'r')
hold on
plot(Palv,timec(30,:),'g')
xlabel('alveolar pressure')
ylabel('close time')
[t,s] = title('closing time','1st 15th 30th layer of the lung','Color','blue');
t.FontSize = 16;
s.FontAngle = 'italic';
legend('layer 1','layer 15','layer 30')

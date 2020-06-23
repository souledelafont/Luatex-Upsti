close all
clear all

set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
set(gcf,'renderer','Painters');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% OPTION BODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
opts = bodeoptions('cstprefs');


opts.XLabel.Interpreter = 'latex';
opts.YLabel.Interpreter = 'latex';
opts.Title.Interpreter = 'latex';
opts.XLabel.String = 'Pulsation $\omega$ ';
opts.YLabel.String{1} = 'Gain $G_{dB}$';
opts.YLabel.String{2} = ('Phase $\varphi$ ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% OPTION BLACK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
optsBlack = bodeoptions('cstprefs');
optsBlack.XLabel.Interpreter = 'latex';
optsBlack.YLabel.Interpreter = 'latex';
optsBlack.Title.Interpreter = 'latex';
optsBlack.XLabel.String = 'Phase $\varphi$ ';
optsBlack.YLabel.String= ' Gain $G_{db}$ ';

optsBlack.Xlim=[-270 0];
optsBlack.Ylim=[-20 40];



%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bode sur FTBO(p) Bode asymp
%%%%%%%%%%%%%%%%%%%%%%%%%
Ka=47E-3;
Kp=1;
Km=25;
Kh=33E-3;
m=1;
taum=0.2;

nom=tf([Kp*Ka*Km*Kh],[1]);
mot=tf([1],[taum 1]);
voilure=tf([1],[m 0 0]);
FTBO=nom*mot*voilure;



opts.Title.String = 'FTBO(p)';
asymp(FTBO)
hold on
bodeplot(FTBO,opts);
grid on
grid minor

saveas(gcf,'FTBO_simple_Bode_asymp','svg') 


%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bode sur FTBOV(p) Bode Asymp  
%%%%%%%%%%%%%%%%%%%%%%%%%

K2=1;
nom2=tf([K2*Kp*Ka*Km*Kh],[1]);
mot2=tf([1],[taum 1]);
voilure2=tf([1],[m 0]);
FTBOv=nom2*mot2*voilure2;

figure()
opts.Title.String = 'Diagramme de Bode FTBO(p) ';

asymp(FTBOv)
hold on
bodeplot(FTBOv,opts)
grid on
grid minor

saveas(gcf,'FTBO_vitesse_Bode_asymp','svg') 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FTBO2(p) Bode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Kv=Ka*Km*Kh/m;
K2=182;

nom2=tf([K2*Kv],[1]);
mot2=tf([1],[taum 1 K2*Kv]);
int=tf([1],[1 0]);

FTBFv=nom2*mot2;
FTBO2=FTBFv*int;

figure()
opts.Title.String = 'Diagramme de Bode FTBO2(p) ';

bodeplot(FTBO2,opts)
grid on
grid minor

saveas(gcf,'FTBO2_Bode','svg') 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FTBO2(p) Black
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure()


optsBlack.Title.String = {'Diagramme de Black FTBO2(p)'};

nichols(FTBO2,optsBlack);
grid on

saveas(gcf,'FTBO2_Black','svg')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FTBO2(p) Black Margin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure()
[Gm,Pm,Wcg,Wcp] = margin(FTBO2)

optsBlack.Title.String = { 'FTBO2(p)' strcat(' MG = ',num2str(round(20*log10(Gm),1)),'dB  $\omega_{-180^\circ }=$ ',num2str(round(Wcg,1)),'$rad.s^{-1}$') strcat(' M$\varphi$ = ',num2str(round(Pm,1)),'$^\circ \omega_{0dB}$=',num2str(round(Wcp,1)),'$rad.s^{-1}$')};

nichols(FTBO2,optsBlack);
hold on
plot([-180,-180],[0,-20*log10(Gm)],'-')
hold on
plot([-180,Pm-180],[0,0],'-')
grid on


saveas(gcf,'FTBO2_Black_margin','svg')




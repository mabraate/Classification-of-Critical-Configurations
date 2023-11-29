%threecamerasoncubic
clc; clear all
syms a1 a2 b3 b4 b5 s t u v x y real
cubic=[s^3,s^2*t,s*t^2,t^3]'    %Parameterization of the cubic
line=[u,0,0,v]'                 %Parameterization of the line
S=[0,0,x,0;0,-x,0,y;0,0,-y,0;0,0,0,0];
S=S+S'  %Parameterization of the pencil of quadrics containing the cubic and the line

P1=[1,0,0,-a1^3;0,1,0,-a1^2;0,0,1,-a1]
P2=[1,0,0,-a2^3;0,1,0,-a2^2;0,0,1,-a2]  %Two cameras on the cubic
P3=[1,0,0,b3;0,1,0,0;0,0,1,0]
P4=[1,0,0,b4;0,1,0,0;0,0,1,0]   %Three cameras on the line
P5=[1,0,0,b5;0,1,0,0;0,0,1,0]

p1=null(P1);
p2=null(P2);
p3=null(P3);   %Camera centers
p4=null(P4);
p5=null(P5);

y1=[1,0,0,a1]';
y2=[1,0,0,a2]';
y3=[1,1,1,1]';
y4=[b3^3,b3^2*b4,b3*b4^2,b4^3]';
y5=[b3^3,b3^2*b5,b3*b5^2,b5^3]';

%fundamental matrices for one camera on the cubic, and one on the line
F13=[0,0,-1;0,1,a1+1;0,-a1-1,-a1]
F14=[0,0,-b4;0,b4,b3+a1*b4;0,-b3-a1*b4,-a1*b3]
F15=[0,0,-b5;0,b5,b3+a1*b5;0,-b3-a1*b5,-a1*b3]
F23=[0,0,1;0,-1,-a2-1;0,a2+1,a2]
F24=[0,0,-b4;0,b4,b3+a2*b4;0,-b3-a2*b4,-a2*b3]
F25=[0,0,-b5;0,b5,b3+a2*b5;0,-b3-a2*b5,-a2*b3]

%fundamental matrices for two cameras on the line
F34=[0,b4,-b4;-b4,b4-b3,b4^2+b3;b3,-b4^2-b3,-b4*(b3-b4)]
F35=[0,b5,-b5;-b5,b5-b3,b5^2+b3;b3,-b5^2-b3,-b5*(b3-b5)]
F45=[0,-b3*b4*b5,b3^2*b5;b3*b4*b5,b3^2*(b4-b5),-b3^3-b4^2*b5^2;-b3^2*b4,b3^3+b4^2*b5^2,b3*b4*b5*(b4-b5)]

%Quadrics all lie in the same pencil
S13=simplify((P1'*F13*P3)+(P1'*F13*P3)');
S14=simplify((P1'*F14*P4)+(P1'*F14*P4)');
S15=simplify((P1'*F15*P5)+(P1'*F15*P5)');
S23=simplify((P2'*F23*P3)+(P2'*F23*P3)');
S24=simplify((P2'*F24*P4)+(P2'*F24*P4)');
S25=simplify((P2'*F25*P5)+(P2'*F25*P5)');
S34=simplify((P3'*F34*P4)+(P3'*F34*P4)');
S35=simplify((P3'*F35*P5)+(P3'*F35*P5)');
S45=simplify((P4'*F45*P5)+(P4'*F45*P5)');

%Conjugate cameras
Q1=[1,0,0,0;0,1,0,0;0,0,1,0]
Q2=[1,a2-a1,-a2*(a1-a2),0;0,1,a2-a1,0;0,0,1,0]
Q3=[-a1-1,(a1+1)^2-1,a1-a1*(a1+1)+1,-1;a1^2+a1+1,-(a1+1)*(a1^2+a1+1),a1*(a1^2+a1+1),0;0,a1^2+a1+1,-(a1+1)*(a1^2+a1+1),0]
Q4=[b3+a1*b3+a1^2*b3-a1^2*b4,-a1*(b3+b4+a1*b3+a1^2*b3-a1^2*b4),b4*(b3-b4+a1*b3-a1*b4+a1^2*b3-a1^2*b4+a1^2-1),b4;-b4*(a1^2+a1+1),(b3+a1*b4)*(a1^2+a1+1),-a1*b3*(a1^2+a1+1),0;0,-b4*(a1^2+a1+1),(b3+a1*b4)*(a1^2+a1+1),0]
Q5=[b3+a1*b3+a1^2*b3-a1^2*b5,-a1*(b3+b5+a1*b3+a1^2*b3-a1^2*b5),b5*(b3-b5+a1*b3-a1*b5+a1^2*b3-a1^2*b5+a1^2-1),b5;-b5*(a1^2+a1+1),(b3+a1*b5)*(a1^2+a1+1),-a1*b3*(a1^2+a1+1),0;0,-b5*(a1^2+a1+1),(b3+a1*b5)*(a1^2+a1+1),0]

%The conjugate curve, in this case, a singular quartic
quartic=[s*t*(a1^2*t^2+a1*s*t+s^2),s*t^2*(s+a1*t),s*t^3,-(s-t)*(a1^2*s^3+b3*a1^2*t^3+a1*s^3+a1*s^2*t+b3*a1*t^3+s^3+s^2*t+s*t^2+b3*t^3)]'

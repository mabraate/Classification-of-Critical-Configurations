%three cameras on cubic
clc; clear all
syms a1 a2 a3 a4 s t u v x y real
cubic=[s^3,s^2*t,s*t^2,t^3]'    %Parameterization of the cubic
line=[u,0,0,v]' %Parameterization of the line
S=[0,0,x,0;0,-x,0,y;0,0,-y,0;0,0,0,0];
S=S+S'  %Parameterization of the pencil of quadrics containing the cubic and the line

P1=[1,0,0,-a1^3;0,1,0,-a1^2;0,0,1,-a1]
P2=[1,0,0,-a2^3;0,1,0,-a2^2;0,0,1,-a2]  %Three cameras on the cubic
P3=[1,0,0,-a3^3;0,1,0,-a3^2;0,0,1,-a3]
P4=[1,0,0,-a4^3;0,1,0,-a4^2;0,0,1,-a4]           %One camera on the line

p1=null(P1);
p2=null(P2);
p3=null(P3);%Camera centers
p4=null(P4);

y1=[1,1,1,1]';
y2=[a2^3, a1*a2^2, a1^2*a2, a1^3]';
y3=[a3^3, a1*a3^2, a1^2*a3, a1^3]';
y4=[a4^3, a1*a4^2, a1^2*a4, a1^3]';

%fundamental matrices
F12=[0,-a1,a1*(a2+1);a1,(a1-a2)*(a1-1),-a1^2*a2-a1^2+a1*a2-a2^2-a2;-a1^2-a2,a1^2*a2+a1^2-a1*a2+a2^2+a2,-a2*(a1-a2)*(a1-1)]
F13=[0,-a1,a1*(a3+1);a1,(a1-a3)*(a1-1),-a1^2*a3-a1^2+a1*a3-a3^2-a3;-a1^2-a3,a1^2*a3+a1^2-a1*a3+a3^2+a3,-a3*(a1-a3)*(a1-1)]
F23=[0,a1^2,-a1*(a2+a1*a3);-a1^2,-a1*(a2-a3)*(a1-1),a1^2*a2*a3+a1*a2^2-a1*a2*a3+a1*a3^2+a2*a3;a1*(a3+a1*a2),-a1^2*a2*a3-a1*a2^2+a1*a2*a3-a1*a3^2-a2*a3,a2*a3*(a2-a3)*(a1-1)]
F14=[0,-a1,a1*(a4+1);a1,(a1-a4)*(a1-1),-a1^2*a4-a1^2+a1*a4-a4^2-a4;-a1^2-a4,a1^2*a4+a1^2-a1*a4+a4^2+a4,-a4*(a1-a4)*(a1-1)]
F24=[0,a1^2,-a1*(a2+a1*a4);-a1^2,-a1*(a2-a4)*(a1-1),a1^2*a2*a4+a1*a2^2-a1*a2*a4+a1*a4^2+a2*a4;a1*(a4+a1*a2),-a1^2*a2*a4-a1*a2^2+a1*a2*a4-a1*a4^2-a2*a4,a2*a4*(a2-a4)*(a1-1)]
F34=[0,a1^2,-a1*(a3+a1*a4);-a1^2,-a1*(a3-a4)*(a1-1),a1^2*a3*a4+a1*a3^2-a1*a3*a4+a1*a4^2+a3*a4;a1*(a4+a1*a3),-a1^2*a3*a4-a1*a3^2+a1*a3*a4-a1*a4^2-a3*a4,a3*a4*(a3-a4)*(a1-1)]

%Quadrics all lie in the same pencil
S12=simplify((P1'*F12*P2)+(P1'*F12*P2)');
S13=simplify((P1'*F13*P3)+(P1'*F13*P3)');
S14=simplify((P1'*F14*P4)+(P1'*F14*P4)');
S23=simplify((P2'*F23*P3)+(P2'*F23*P3)');
S24=simplify((P2'*F24*P4)+(P2'*F24*P4)');
S34=simplify((P3'*F34*P4)+(P3'*F34*P4)');

%Defining epipoles
e12=null(F12')
e21=null(F12)
e13=null(F13')
e31=null(F13)
e14=null(F14')
e41=null(F14)
e23=null(F23')
e32=null(F23)
e24=null(F24')
e42=null(F24)
e34=null(F34')
e43=null(F34)

%Verifying that 1234 is a compatible quadruple:
e3124=simplify(e13'*F12*e24)
e4123=simplify(e14'*F12*e23)
e2134=simplify(e12'*F13*e34)
e4132=simplify(e14'*F13*e32)
e1234=simplify(e21'*F23*e34)
e4231=simplify(e24'*F23*e31)
e2143=simplify(e12'*F14*e43)
e3142=simplify(e13'*F14*e42)
e1243=simplify(e21'*F24*e43)
e3241=simplify(e23'*F24*e41)
e1342=simplify(e31'*F34*e42)
e2341=simplify(e32'*F34*e41)

simplify(e4123*e2134*e3142*e4231*e1243*e2341-e3124*e4132*e2143*e1234*e3241*e1342)
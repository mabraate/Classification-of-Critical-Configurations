%Two cameras on each plane
clc
syms a1 a2 a3 a4 b1 b2 b3 b4 real
%Define cameras
P1=[0,1,0,0;0,0,1,0;0,0,0,1]
P2=[1,0,0,0;0,0,1,0;0,0,0,1]
P3=[1,0,0,0;0,1,0,0;0,0,0,1]
P4=[1,0,0,0;0,1,0,0;0,0,1,0]

%Camera centers
p1=null(P1);
p2=null(P2);
p3=null(P3);
p4=null(P4);

y1=[1,1,1,1]';
y2=[a4*(a2*b4-a2*b3-a2*b1+a4*b2+a4*b4),-a2*(a4*b2-a2*b1+a4*b3),a4*(a4*b2-a2*b1+a4*b3),a4*(a4*b2-a2*b1+a4*b3)]';
y3=[a4*b3*(b2+b4),-a2*b3*(b2+b4),a2*b1*b3,a2*b1*b4]';
y4=[-a4*(b2+b4)*(a2*b1+a2*b4-a4*b2),a2*(b2+b4)*(a2*b1+a2*b4-a4*b2),-a2*b1*(a2*b1+a2*b3-a4*b2+a4*b3-a4*b4),-a2*b1*(a2*b1+a2*b4-a4*b2)]';

%The fundamental matrices
F12=[0,a4,-a4;a2,0,-a2;-a2,a2,0]
F13=[b1,0,-b1;b2,b4,-b2-b4;b3,-b3,0]
F23=[0,-a2*a4*b1*(b3-b4),-a2^2*b1*(b3-b4);a2*b4*(a4*b2-a2*b1+a4*b3),a4*(a2*b4^2-a2*b1*b4-a2*b3*b4+a4*b2*b3+a4*b3*b4),a2*a4*(b2+b4)*(b3-b4);-a2*b3*(a4*b2-a2*b1+a4*b3),-a4*b3*(a2*b4-a2*b3-a2*b1+a4*b2+a4*b4),0]
F14=[b1*(a2+a4),0,-b1*(a2+a4);a4*b2-a2*b4-a2*b1,a2*b1+a2*b4-a4*b2,0;a2*b1+a2*b2+a2*b3+a2*b4+a4*b3,a4*b2-a2*b3-a2*b1-a4*b3+a4*b4,-(a2+a4)*(b2+b4)]
F24=[0,-a2*a4*b1*(a2+a4)*(b3-b4),-a2^2*b1*(a2+a4)*(b3-b4);a2*(a2*b1+a2*b4-a4*b2)*(a4*b2-a2*b1+a4*b3),a4*(a2*b1+a2*b4-a4*b2)*(a2*b4-a2*b3-a2*b1+a4*b2+a4*b4),0;-a2*(a4*b2-a2*b1+a4*b3)*(a2*b1+a2*b3-a4*b2+a4*b3-a4*b4),a4*(a2^2*b1^2+2*a2^2*b1*b3-b4*a2^2*b1+a2^2*b3^2-b4*a2^2*b3-2*a2*a4*b1*b2+a2*a4*b1*b3-2*b4*a2*a4*b1-a2*a4*b2*b3+a2*a4*b3^2-2*b4*a2*a4*b3+a4^2*b2^2+b4*a4^2*b2),a2*a4*(a2+a4)*(b2+b4)*(b3-b4)]
F34=[0,-a2*b1,-a2*(b2+b4);a2*b1,0,-a4*(b2+b4);a2*(b2+b4),a4*(b2+b4),0]

%The quadrics
S12=(P1'*F12*P2)+(P1'*F12*P2)';
S13=(P1'*F13*P3)+(P1'*F13*P3)';
S23=(P2'*F23*P3)+(P2'*F23*P3)';
S14=(P1'*F14*P4)+(P1'*F14*P4)';
S24=(P2'*F24*P4)+(P2'*F24*P4)';
S34=(P3'*F34*P4)+(P3'*F34*P4)';

%Confirming compatibility
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
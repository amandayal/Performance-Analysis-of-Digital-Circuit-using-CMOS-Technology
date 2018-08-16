* 1bit_Full_adder_PTL

.lib "32nm_LP.pm" CMOS_models

.subckt Inv_sch in VDD Out gnd  
MNMOS_1 Out in gnd gnd NMOS W=65n L=32n 
MPMOS_1 Out in vdd VDD PMOS W=128n L=32n 
.ends

MNMOS_1 C Bbar 1 Gnd NMOS W=65n L=32n 
MNMOS_2 B B 1 Gnd NMOS W=65n L=32n 
MNMOS_3 Gnd Bbar 2 Gnd NMOS W=65n L=32n 
MNMOS_4 C B 2 Gnd NMOS W=65n L=32n
MNMOS_5 1 A carry_fadder Gnd NMOS W=65n L=32n 
MNMOS_6 2 Abar carry_fadder Gnd NMOS W=65n L=32n
MNMOS_7 C Bbar 3 Gnd NMOS W=65n L=32n 
MNMOS_8 Cbar B 3 Gnd NMOS W=65n L=32n 
MNMOS_9 Cbar Bbar 4 Gnd NMOS W=65n L=32n 
MNMOS_10 C B 4 Gnd NMOS W=65n L=32n 
MNMOS_11 3 Abar sum_fadder Gnd NMOS W=65n L=32n 
MNMOS_12 4 A sum_fadder Gnd NMOS W=65n L=32n 

XInv_sch_3 C VDD Cbar gnd Inv_sch 
XInv_sch_4 B VDD Bbar gnd Inv_sch 
XInv_sch_5 A VDD Abar gnd Inv_sch 

CCapacitor_1 sum_fadder Gnd 1f  
CCapacitor_2 carry_fadder Gnd 1f  

VVDD VDD Gnd 1 
VVA A Gnd  PULSE(1 0 0 10p 10p 1.99n 4n)  
VVB B Gnd  PULSE(1 0 0 10p 10p 0.99n 2n)  
VVC C Gnd  PULSE(1 0 0 10p 10p 1.99n 4n)

.tran 1n 8n
.op

.MEASURE avgpow AVG power FROM=1n TO=8n

.measure tran current avg i(out) from=0n to=8n

.measure tran delay TRIG v(B) VAL=0.5 fall=2 TARG v(sum_fadder)VAL=0.5 fall=1
.measure tran delay1 TRIG v(A) VAL=0.5 rise=1 TARG v(sum_fadder)VAL=0.5 fall=1 


.MEASURE TRAN tpd PARAM='(delay+delay1)/2'
.measure PDP PARAM =  'tpd*avgpow'
.end





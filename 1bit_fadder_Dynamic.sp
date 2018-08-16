* 1bit_Full_adder

.lib "32nm_LP.pm" CMOS_models

.subckt Inv_sch in VDD Out gnd  
MNMOS_1 Out in gnd gnd NMOS W=60n L=32n 
MPMOS_1 Out in vdd VDD PMOS W=128n L=32n 
.ends

MNMOS_1 1 A 2 Gnd NMOS W=60n L=32n 
MNMOS_2 2 B 5 Gnd NMOS W=60n L=32n 
MNMOS_3 1 B 3 Gnd NMOS W=60n L=32n 
MNMOS_4 3 C 5 Gnd NMOS W=60n L=32n
MNMOS_5 1 C 4 Gnd NMOS W=60n L=32n 
MNMOS_6 4 A 5 Gnd NMOS W=60n L=32n
MNMOS_7 5 CLK Gnd Gnd NMOS W=60n L=32n
MNMOS_8 6 A 7 Gnd NMOS W=60n L=32n 
MNMOS_9 7 B 8 Gnd NMOS W=60n L=32n 
MNMOS_10 8 C 10 Gnd NMOS W=60n L=32n 
MNMOS_11 6 A 9 Gnd NMOS W=60n L=32n 
MNMOS_12 6 B 9 Gnd NMOS W=60n L=32n 
MNMOS_13 6 C 9 Gnd NMOS W=60n L=32n 
MNMOS_14 9 1 10 Gnd NMOS W=60n L=32n 
MNMOS_15 10 CLK Gnd Gnd NMOS W=60n L=32n 

MPMOS_1 1 CLK VDD VDD PMOS W=128n L=32n
MPMOS_2 6 CLK VDD VDD PMOS W=128n L=32n

XInv_sch_1 1 VDD carry_fadder gnd Inv_sch  
XInv_sch_2 6 VDD sum_fadder gnd Inv_sch 

CCapacitor_1 sum_fadder Gnd .1f 
CCapacitor_2 carry_fadder Gnd .1f  

VVDD VDD Gnd 0.9
VVA A Gnd  PULSE(0 0.9 0 10p 10p 1.99n 4n)  
VVB B Gnd  PULSE(0 0.9 0 10p 10p 0.99n 2n)
VVC C Gnd  PULSE(0 0.9 0 10p 10p 1.99n 4n)
VVCLK CLK Gnd PULSE(0.9 0 0 10p 10p 0.99n 2n)

.tran 1n 8n
.op

.MEASURE avgpow AVG power FROM=1n TO=8n

.measure tran current avg i(out) from=0n to=8n

.measure tran delay TRIG v(A) VAL=0.5 rise=1 TARG v(carry_fadder)VAL=0.5 fall=1 
.measure tran delay1 TRIG v(B) VAL=0.5 rise=1 TARG v(sum_fadder)VAL=0.5 fall=1 

.MEASURE TRAN tpd PARAM='(delay+delay1)/2'
.measure PDP PARAM =  'tpd*avgpow'
.end





* 1bit_Full_adder

.lib "32nm_LP.pm" CMOS_models

*------------NMOS PMOS Initialization-----------
.subckt Inv_sch in VDD Out gnd  
MNMOS_1 Out in gnd gnd NMOS W=65n L=32n 
MPMOS_1 Out in vdd VDD PMOS W=128n L=32n 
.ends

*-----------NMOS Circuit Design-------------
MNMOS_1 3 A 4 Gnd NMOS W=65n L=32n 
MNMOS_2 4 B Gnd Gnd NMOS W=65n L=32n 
MNMOS_3 3 B 5 Gnd NMOS W=65n L=32n 
MNMOS_4 5 C Gnd Gnd NMOS W=65n L=32n
MNMOS_5 3 C 6 Gnd NMOS W=65n L=32n 
MNMOS_6 6 A gnd Gnd NMOS W=65n L=32n
MNMOS_7 7 A 8 Gnd NMOS W=65n L=32n 
MNMOS_8 8 B 9 Gnd NMOS W=65n L=32n 
MNMOS_9 9 C Gnd Gnd NMOS W=65n L=32n 
MNMOS_10 7 A 10 Gnd NMOS W=65n L=32n 
MNMOS_11 7 B 10 Gnd NMOS W=65n L=32n 
MNMOS_12 7 C 10 Gnd NMOS W=65n L=32n 
MNMOS_13 10 3 Gnd Gnd NMOS W=65n L=32n 

*-----------PMOS Circuit Design-------------
MPMOS_1 3 Gnd VDD VDD PMOS W=128n L=32n
MPMOS_2 7 Gnd VDD VDD PMOS W=128n L=32n

*-----------NOT/Inverter Circuit Design--------------
XInv_sch_1 3 VDD carry_fadder gnd Inv_sch  
XInv_sch_2 7 VDD sum_fadder gnd Inv_sch 

*-----------Load Capacitance------------------
CCapacitor_1 sum_fadder Gnd 1f  
CCapacitor_2 carry_fadder Gnd 1f  

*----------Gate Input Pulse-------------------
VVDD VDD Gnd 1 
VVA A Gnd  PULSE(1 0 0 10p 10p 1.99n 4n)  
VVB B Gnd  PULSE(1 0 0 10p 10p 0.99n 2n)  
VVC C Gnd  PULSE(1 0 0 10p 10p 1.99n 4n)

.tran 1n 8n
.op

.MEASURE avgpow AVG power FROM=1n TO=8n

.measure tran current avg i(out) from=0n to=8n

.measure tran delay TRIG v(A) VAL=0.5 fall=1 TARG v(carry_fadder)VAL=0.5 fall=1 
.measure tran delay1 TRIG v(A) VAL=0.5 rise=2 TARG v(carry_fadder)VAL=0.5 rise=2 

*-----------Calculation of Power Delay Product------
.MEASURE TRAN tpd PARAM='(delay+delay1)/2'
.measure PDP PARAM =  'tpd*avgpow'
.end





Title - RC circuit 2

.PARAM Vdd_var=1

**RC n/w
R1     vin     vout    1k
C1     vout    GND     1p

**Source
** PULSE(V1 V2 TD TR TF PW PER)
Vsin    vin     GND     0  pulse(0 Vdd_var 0.5n 1p 1p 0.05n 0.1n)

.CONTROL
OP
**TRAN time-stamp total_time
TRAN 10p 40n

.ENDC
.GLOBAL GND
.END
.TITLE Diode experiment

.MODEL diomod1 D (bv=50 is=1e-13 n=1.05)

D1    vin    vout    diomod1
R1    vout   GND     1k
**C1  vout   GND     2p

vsin  vin    GND     0 sin(0 1 1e3 0 0 0)

.OP
.TRAN  1u  4m

.END
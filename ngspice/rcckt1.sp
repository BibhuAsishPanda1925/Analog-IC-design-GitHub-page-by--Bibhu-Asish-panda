Title: experiment rise, fall, delay, period, etc

**RC n/w
R1     vin     vout    1k
C1     vout    GND     1p

**stimuli
** PULSE(V1 V2 TD TR TF PW PER)
Vsin    vin     GND     0  pulse(0 5 1n 1p 1p 10n 20n)

**rise/fall 10-90%
.MEASURE TRAN rise_time1090 TRIG v(vout) VAL='0.1*5' RISE=1 TARG v(vout) VAL='0.9*5' RISE=1
.MEASURE TRAN fall_time9010 TRIG v(vout) VAL='0.9*5' FALL=1 TARG v(vout) VAL='0.1*5' FALL=1

**rise/fall 20-80%
.MEASURE TRAN rise_time2080 TRIG v(vout) VAL='0.2*5' RISE=1 TARG v(vout) VAL='0.8*5' RISE=1
.MEASURE TRAN fall_time8020 TRIG v(vout) VAL='0.8*5' FALL=1 TARG v(vout) VAL='0.2*5' FALL=1

**delay rise/fall
.MEASURE TRAN tdrise TRIG v(vin) VAL='0.5*5' RISE=1 TARG v(vout) VAL='0.5*5' RISE=1
.MEASURE TRAN tdfall TRIG v(vin) VAL='0.5*5' FALL=1 TARG v(vout) VAL='0.5*5' FALL=1

**pulse width/period
.MEASURE TRAN PWidth TRIG v(vout) VAL='0.5*5' RISE=1 TARG v(vout) VAL='0.5*5' FALL=1
.MEASURE TRAN Period TRIG v(vout) VAL='0.5*5' RISE=1 TARG v(vout) VAL='0.5*5' RISE=2


.CONTROL
  OP
  TRAN 10p 40n
.ENDC
.GLOBAL GND
.END

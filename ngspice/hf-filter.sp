Title: Simple Highpass filter

** High pass element
Cbyp    vin     n1      4.7u
Rhp     n1      vcm     5.08k


** Stimuli
Vsin    vin     0       0 AC 1
Vscm    vcm     0       0.5

.OP

.CONTROL
  save all
  AC DEC 100 1 10e6

  plot vdb(n1)
  meas ac gain_db MAX vdb(n1) FROM=1 TO=10e6
  LET f3db = gain_db - 3
  print f3db
  MEAS AC fzero WHEN vdb(n1)=f3db RISE=1

.ENDC

.END

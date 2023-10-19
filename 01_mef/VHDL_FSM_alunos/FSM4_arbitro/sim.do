if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work p_arb.vhd
vcom -work work arbitro.vhd
vcom -work work arbitro_tb.vhd

vsim -voptargs=+acc=lprn -t ns work.tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do 

run 1100 ns


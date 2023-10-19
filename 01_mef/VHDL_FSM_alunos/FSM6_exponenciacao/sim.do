if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work multiplicador_serial.vhd
vcom -work work exponenciacao.vhd
vcom -work work exponenciacao_tb.vhd

vsim -voptargs=+acc=lprn -t ps work.tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do 

run 10 ms


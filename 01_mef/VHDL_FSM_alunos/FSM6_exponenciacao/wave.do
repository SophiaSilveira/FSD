onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/mu/reset
add wave -noupdate /tb/mu/clock
add wave -noupdate -divider ENTRADAS
add wave -noupdate /tb/mu/A
add wave -noupdate /tb/mu/B
add wave -noupdate -divider CONTOLE
add wave -noupdate -color Yellow /tb/mu/start
add wave -noupdate -color Yellow /tb/mu/end_mul
add wave -noupdate -divider RESULTADO
add wave -noupdate /tb/mu/produto
add wave -noupdate -divider {sinais internos}
add wave -noupdate -radix unsigned /tb/mu/cont
add wave -noupdate /tb/mu/regP
add wave -noupdate /tb/mu/EA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {926 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {2100 ns}

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/DUT/reset
add wave -noupdate /tb/DUT/clock
add wave -noupdate -expand -subitemconfig {/tb/DUT/req(0) {-color {Dark Orchid}} /tb/DUT/req(1) {-color {Dark Orchid}} /tb/DUT/req(2) {-color {Dark Orchid}} /tb/DUT/req(3) {-color {Dark Orchid}}} /tb/DUT/req
add wave -noupdate -expand -subitemconfig {/tb/DUT/grant(0) {-color Red} /tb/DUT/grant(1) {-color Red} /tb/DUT/grant(2) {-color Red} /tb/DUT/grant(3) {-color Red}} /tb/DUT/grant
add wave -noupdate /tb/DUT/grant(0)
add wave -noupdate -expand /tb/DUT/release
add wave -noupdate -divider -height 22 seletor
add wave -noupdate /tb/DUT/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {123 ns} 0}
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
WaveRestoreZoom {0 ns} {1155 ns}

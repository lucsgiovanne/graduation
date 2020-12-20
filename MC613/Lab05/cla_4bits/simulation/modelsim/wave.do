onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand /cla_4bits/x
add wave -noupdate -expand /cla_4bits/y
add wave -noupdate /cla_4bits/cin
add wave -noupdate -expand /cla_4bits/sum
add wave -noupdate /cla_4bits/cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {2027 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern counter -startvalue 0000 -endvalue 1111 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 3 0 -starttime 0ps -endtime 1600ps sim:/cla_4bits/x 
WaveExpandAll -1
wave create -driver freeze -pattern counter -startvalue 0000 -endvalue 1111 -type Range -direction Up -period 100ps -step 1 -repeat forever -range 3 0 -starttime 0ps -endtime 1600ps sim:/cla_4bits/y 
WaveExpandAll -1
wave create -driver freeze -pattern random -initialvalue 0 -period 100ps -random_type Uniform -seed 5 -starttime 0ps -endtime 1600ps sim:/cla_4bits/cin 
wave modify -driver freeze -pattern counter -startvalue 0 -endvalue 1 -type Range -direction Up -period 100ps -step 1 -repeat forever -starttime 0ps -endtime 1600ps Edit:/cla_4bits/cin 
WaveCollapseAll -1
wave clipboard restore

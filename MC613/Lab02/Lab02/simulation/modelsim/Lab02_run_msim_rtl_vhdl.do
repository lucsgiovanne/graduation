transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/ec2018-ceb/ra216047/Documents/MC613/lab02/original.vhd}


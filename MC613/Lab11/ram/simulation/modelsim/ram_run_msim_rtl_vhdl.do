transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/intelFPGA_lite/17.1/ram/ram.vhd}
vcom -93 -work work {C:/intelFPGA_lite/17.1/ram/ram_block.vhd}

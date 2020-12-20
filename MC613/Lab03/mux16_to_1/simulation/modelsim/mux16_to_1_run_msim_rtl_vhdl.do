transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/intelFPGA_lite/17.1/mux16_to_1/mux16_to_1.vhd}
vcom -93 -work work {C:/intelFPGA_lite/17.1/mux16_to_1/mux4_to_1.vhd}
vcom -93 -work work {C:/intelFPGA_lite/17.1/mux16_to_1/dec2_to_4.vhd}
vcom -93 -work work {C:/intelFPGA_lite/17.1/mux16_to_1/extra_logic.vhd}


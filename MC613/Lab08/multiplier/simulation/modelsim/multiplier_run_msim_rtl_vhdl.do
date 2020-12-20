transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/intelFPGA_lite/17.1/multiplier/multiplier.vhd}
vcom -93 -work work {C:/intelFPGA_lite/17.1/multiplier/shift_register.vhd}
vcom -93 -work work {C:/intelFPGA_lite/17.1/multiplier/reg.vhd}
vcom -93 -work work {C:/intelFPGA_lite/17.1/multiplier/ripple_carry.vhd}
vcom -93 -work work {C:/intelFPGA_lite/17.1/multiplier/full_adder.vhd}

vlib work
vlog tb_top.sv +acc
vsim -voptargs=+acc tb_top +UVM_TESTNAME=mux_test
#do wave.do
run -all

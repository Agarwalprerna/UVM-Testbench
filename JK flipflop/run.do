vlib work
vlog testbench.sv +acc
vsim -voptargs=+acc tb_top +UVM_TESTNAME=JK_test
#do wave.do
run -all


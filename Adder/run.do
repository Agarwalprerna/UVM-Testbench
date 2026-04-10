vlib work
vlog tb_top.sv +acc
vsim -voptargs=+acc tb_top +UVM_TESTNAME=test
#do wave.do
run -all

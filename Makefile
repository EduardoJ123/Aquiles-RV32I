verilate: rtl/alu.v
	/home/eduardo/repos/verilator/bin/verilator -cc rtl/alu.v

build: rtl/alu.v aquilesv_tb.cpp
	/home/eduardo/repos/verilator/bin/verilator -Wall --trace -cc rtl/alu.v --exe aquilesv_tb.cpp

compile: obj_dir/Valu.mk
	make -C obj_dir -f Valu.mk Valu

simulate: obj_dir/Valu
	./obj_dir/Valu

aquilesv: verilate build compile simulate
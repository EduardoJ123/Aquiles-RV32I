GREEN = '\033[0;32m'
NC = '\033[0m'
create_output:
	@[ -d output ] || mkdir -p output

verilate: create_output rtl/alu.v
	@/home/eduardo/repos/verilator/bin/verilator -cc rtl/alu.v > output/verilate.log
	@echo -e verilate stage ----- ${GREEN}PASS${NC}

build: create_output rtl/alu.v tb/aquilesv_tb.cpp
	@/home/eduardo/repos/verilator/bin/verilator -Wall --trace -cc rtl/alu.v --exe tb/aquilesv_tb.cpp > output/build.log
	@echo -e build stage -------- ${GREEN}PASS${NC}

compile: create_output obj_dir/Valu.mk
	@make -C obj_dir -f Valu.mk Valu > output/compile.log
	@echo -e compile stage ------ ${GREEN}PASS${NC}

simulate: create_output obj_dir/Valu
	@./scripts/create_tests_dir.sh
	@./obj_dir/Valu > output/simulate.log
	@echo -e simulate stage ----- ${GREEN}PASS${NC}

clean:
	rm -rf output obj_dir test_results

aquilesv: verilate build compile simulate
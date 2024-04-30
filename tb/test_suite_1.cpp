#include <stdlib.h>
#include <iostream>
#include <cstdio>
#include <random>
#include <thread>

#define MAX_SIM_TIME 20
int basic_alu_test()
{
    std::random_device seed;
    std::mt19937 gen{seed()}; // seed the generator
    std::uniform_int_distribution<> dist{0, 5}; // Number of functions supported by ALU
    int funct_num;
    vluint64_t sim_time = 0;
    Valu *dut = new Valu;
    freopen("test_results/test_suite_1/basic_alu_test/basic_alu_test.log", "w", stdout);
    printf("Starting basic_alu_test...");
    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("test_results/test_suite_1/basic_alu_test/waveform.vcd");
    dut->clk ^= 1;
    dut->op_in = 0;
    dut->a_in = 0;
    dut->b_in = 0;
    dut->eval();
    m_trace->dump(sim_time);
    sim_time++;
    //TODO: Need to implement init and run phases
    while (sim_time < MAX_SIM_TIME) {
        dut->clk ^= 1;
        funct_num = dist(gen);
        //dut->op_in = dist(gen);     //Pick a random function from ALU and pass it to op type input
        dut->op_in = 0;     //Pick a random function from ALU and pass it to op type input
        //Leverage from random number generator to randomize inputs
        //dut->a_in = dist(gen);
        //dut->b_in = dist(gen);
        dut->a_in = 2;
        dut->b_in = 1;
        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }
    m_trace->close();
    delete dut;
    fclose(stdout);
    return 0;
}

int basic_alu_random_test()
{
    freopen("test_results/test_suite_1/basic_alu_random_test/basic_alu_random_test.log", "w", stdout);
    printf("Starting basic_alu_random_test...");
    fclose(stdout);
    return 0;
}

int test_suite_1()
{
    using namespace std;
    std::thread thread_test1(basic_alu_test);
    std::thread thread_test2(basic_alu_random_test);
    thread_test1.join();
    thread_test2.join();
    return 0;
}
/*
*   AquilesV
*   Testbench top
*/
#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Valu.h"
#include "Valu___024unit.h"
//Tests suites
#include "test_suite_1.cpp"

int main(int argc, char** argv, char** env) {
    test_suite_1();
    exit(EXIT_SUCCESS);
}
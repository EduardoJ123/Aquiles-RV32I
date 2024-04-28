#include <stdlib.h>
#include <iostream>
#include <cstdio>
#include <thread>

int basic_alu_test()
{
    freopen("test_results/test_suite_1/basic_alu_test/basic_alu_test.log", "w", stdout);
    printf("Starting basic_alu_test...");
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
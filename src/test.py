import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


segments = [ 63, 6, 91, 79, 102, 109, 125, 7, 127, 111 ]

@cocotb.test()
async def test_bnnn(dut):
    
    CONSTANT_CURRENT = 100 # For example, injecting some current
    
    dut._log.info("start simulation")

    # initialize clock
    clock = Clock(dut.clk, 1, units="ns")
    cocotb.start_soon(clock.start())

    # reset ckt to a pre-defined state before doing anything
    dut.rst_n.value = 0 # low to reset
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1 # take out of reset

    dut.ui_in.value = CONSTANT_CURRENT
    dut.ena.value = 1 # enable design

    for _ in range(100):  # run for 100 clock cycles
        await RisingEdge(dut.clk)
    
    dut._log.info("Finished the test, Done !!! ")

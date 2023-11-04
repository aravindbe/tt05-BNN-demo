import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


segments = [ 63, 6, 91, 79, 102, 109, 125, 7, 127, 111 ]

@cocotb.test()
async def test_bnnn(dut):
    CURRENT = 300
    dut._log.info("start of simulation")
    clock = Clock(dut.clk, 1, units="ns")
    cocotb.start_soon(clock.start())

    # reset
    dut._log.info("reset")
    dut.rst_n.value = 0
    # set the compare value
    dut.ui_in.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 10)
    dut.ui_in.value = CURRENT
    for i in range(100):
        if (i%2 == 0):
            dut.ui_in.value = 125
        else:
            dut.ui_in.value = CURRENT
        await ClockCycles(dut.clk, 10)
    dut._log.info("test done")

do e:/project/msystem/msystem/soft_fpga/vu/vunit_out/tests/lib.buffer_control_1603_tb.all/modelsim/common.do
quietly set failed [vunit_load]
if {$failed} {quit -f -code 1}
quietly set failed [vunit_run]
if {$failed} {quit -f -code 1}
quit -f -code 0
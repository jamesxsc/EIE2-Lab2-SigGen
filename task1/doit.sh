rm -rf obj_dir/
rm -f sinegen.vcd

verilator -Wall --cc sinegen.sv --exe sinegen_tb.cpp

make -j -C obj_dir/Vsinegen -f Vsinegen.mk Vsinegen

./obj_dir/Vsinegen

gtkwave sinegen.vcd

rm -rf obj_dir/
rm -f sinegen.vcd

? Only the top level SV file is required here
verilator -Wall --cc --trace sinegen.sv --exe sinegen_tb.cpp

make -j -C obj_dir/ -f Vsinegen.mk Vsinegen

./obj_dir/Vsinegen

gtkwave sinegen.vcd

## Installation
```
sudo apt install iverilog
sudo apt install gtkwave
```

## Compiling
```
iverilog -o name_wav name.v name_tb.v
vvp name_wav
gtkwave name.vcd
```

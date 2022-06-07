# SKKU_TermProject  

# Repository Owner  : sg05060(박상현)  

# Collaborator      
- gju06051(최보열)  
- skklnventor(장재성)  
- nakyung0305(홍나경)  

# Version
1. First version     : SKKU_TermProject/RTL         - 2022/05/24  
2. Second version    : SKKU_TermProject/FINAL       - 2022/05/26  (Verification finished)  
3. Recent version    : SKKU-TermProject/FINAL_2     - 2022/06/03  (Verification finished)  

# Enviroment
1. Github/Git(Collaboration)
2. Vivado21.2(Simulation, Synthesis, FPGA porting)
3. Diagrams.net(Block diagram, https://app.diagrams.net/)
4. Vscode(Verilog code editor)

# Directory(FINAL_2)
1. If you need simulation on Vivado, checking directory :SKKU_TERMPROJECT/SIM/
2. If you want to check some block diagram, checking directory : SKKU_TERMPROJECT/DOC/
3. If you need to check some discussion, checking Github open/closed issue

# Increment
- PE module rebuilding(we use serial, systolic type series module, but PE just need one multiplier and one accumulator for activation)
- Custom module address control signal rebuilding(weight and feature get from series, if using two counter each domain feature and weight, we can delete much signal)
- Parameterizing(There are many state in moore machine, we can parameterize it for resource saving)
- Adder, multiplier modify(We use basic adder-ripple, basic multiplier-adder tree, we can increament these with many algorithm)
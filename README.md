# Power analysis in approximate computing

_This repository has been created as part of the "Digital Systems Design Methodologies" course at [Politecnico di Milano](https://www.polimi.it "Learn more about Politecnico di Milano")._

The aim of the project was to synthesize different arithmetic components of approximate computing and study their power consumption.  
The tools used are _AUGER_ to generate Verilog code and Error Rate metric and _OpenROAD_ for synthesis and report. All analysis was made on WSL2 on a Windows 10 machine.

In `Review.pdf`, the conclusions of the analysis can be read.

## Execution

For each approximate component there is a TCL script for linking _AUGER_'s file generation and _OpenROAD_ systhensis. Each script needs some parameter to be pass by command line - read each file for better infos.  
For _AMA_, _AXA_ and _InXA_, where there are different versions of the same design, the design version can be specified as last command line parameter. If the parameter is ommitted, all the versions are generated and synthetized.  

| Script | Required parameter       | Description                                                           |
| ------ | ------------------------ | --------------------------------------------------------------------- |
| ama    | bw <br> l <br> version   | Units bit-width <br> Bits to approximate <br> AMA version (optional)  |
| axa    | bw <br> l <br> version   | Units bit-width <br> Bits to approximate <br> AXA version (optional)  |
| inxa   | bw <br> l <br> version   | Units bit-width <br> Bits to approximate <br> InXA version (optional) |
| gear   | bw <br> r <br> p         | Units bit-width <br> R bits <br> P bits                               |
| rca    | bw                       | Units bit-width                                                       |
| drum   | bw <br> l                | Units bit-width <br> Bits to approximate                              |
| roba   | bw                       | Units bit-width                                                       |
| mult   | bw                       | Units bit-width                                                       |

> Parameters must be passed in the **exact** order  
> Change _AUGER_ and _OpenROAD_ directories in each script

## References

### Approximate Adders

- **AMA**: V. Gupta, D. Mohapatra, A. Raghunathan, and K. Roy, _"Low-Power Digital Signal Processing Using Approximate Adders”_, IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems, Jan 2013.
- **AXA**: Z. Yang, A. Jain, J. Liang, J. Han and F. Lombardi, _"Approximate XOR/XNOR-based adders for inexact computing"_, 2013 13th IEEE International Conference on Nanotechnology (IEEE-NANO 2013), Beijing, 2013.
- **InXA**: H. A. F. Almurib, T. N. Kumar and F. Lombardi, _"Inexact designs for approximate low power addition by cell replacement_", 2016 Design, Automation & Test in Europe Conference & Exhibition (DATE), Dresden, 2016.
- **GeAr**: M. Shafique, W. Ahmad, R. Hafiz and J. Henkel, _"A low latency generic accuracy configurable adder"_, 2015 52nd ACM/EDAC/IEEE Design Automation Conference (DAC), San Francisco, CA, 2015

### Approximate Multipliers

- **DRUM**: S. Hashemi, R. I. Bahar and S. Reda, _"DRUM: A Dynamic Range Unbiased Multiplier for Approximate Applications"_, 2015 IEEE/ACM International Conference on Computer-Aided Design (ICCAD), Austin, TX, 2015.
- **RoBA**: R. Zendegani, M. Kamal, M. Bahadori, A. Afzali-Kusha, and M. Pedram, _“RoBA Multiplier: A Rounding-Based Approximate Multiplier for High-Speed yet Energy-Efficient Digital Signal Processing"_, IEEE Transactions on Very Large Scale Integration (VLSI) Systems, Feb 2017.

### Tools

- **AUGER** ([GitLab](https://git.scc.kit.edu/CES/AUGER)): Deykel Hernández-Araya, Jorge Castro-Godínez, Muhammad Shafique and Jörg Henkel, _"AUGER: A Tool for Generating Approximate Arithmetic Circuits"_, IEEE Latin American Symposium on Circuits and Systems – LASCAS 2020, San José, Costa Rica, February 25 - 28, 2020.
- **OpenROAD**: https://openroad.readthedocs.io/en/latest/index.html

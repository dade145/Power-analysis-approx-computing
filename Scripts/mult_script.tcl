#!/usr/bin/tclsh
#source  /mnt/c/Users/dgall/OpenROAD-flow/setup_env.sh

# Command line parameter: bw - bit width

#ToDO: CONFIGURE THESE PARAMETERS!
set OpenROAD_DIRECTORY "/mnt/c/Users/dgall/OpenROAD-flow"
set PLATFORM "nangate45"

# #########################################################

puts "Starting"

set DESIGN_TYPE "MULT"
set DIR_NAME "mult"

set bw [lindex $argv 0]

cd $OpenROAD_DIRECTORY/flow/designs

puts "Creating directoris"
file mkdir ./src/$DESIGN_TYPE/${DIR_NAME}-$bw
file mkdir ./$PLATFORM/$DESIGN_TYPE/${DIR_NAME}-$bw

puts "Crating Verilog file"
cd ./src/$DESIGN_TYPE
set fp [open ./$DIR_NAME-$bw/$DESIGN_TYPE.v w]
puts $fp "module MULT #(parameter N=$bw) "
puts $fp "(input \[N-1:0] a, input \[N-1:0] b, output \[((2*N)-1):0] r);"
puts $fp "assign r=a*b;"
puts $fp "endmodule"
close $fp

cd ../../$PLATFORM/$DESIGN_TYPE

puts "Coping config"
# Copy costraints.sdc and area data from jepg design
foreach f [glob -directory ../jpeg -nocomplain *] {
    file copy -force $f ./$DIR_NAME-$bw
}
set fp [open ./$DIR_NAME-$bw/config.mk w]
puts $fp "export DESIGN_NICKNAME = ${DIR_NAME}-$bw"
puts $fp "export DESIGN_NAME = MULT"
puts $fp "export PLATFORM = $PLATFORM"
puts $fp "export VERILOG_FILES = \$(wildcard ./designs/src/$DESIGN_TYPE/\$(DESIGN_NICKNAME)/*.v)"
puts $fp "export SDC_FILE = ./designs/\$(PLATFORM)/$DESIGN_TYPE/\$(DESIGN_NICKNAME)/constraint.sdc"

puts $fp "export DIE_AREA = 0 0 1200.04 1199.8"
puts $fp "export CORE_AREA = 10.07 9.8 1189.97 1190"
close $fp

cd $OpenROAD_DIRECTORY/flow

# Exec openROAD flow
puts "Runnig openROAD... 1/1"
try {exec make DESIGN_CONFIG=./designs/$PLATFORM/$DESIGN_TYPE/$DIR_NAME-$bw/config.mk} on error {msg} {
    puts $msg
}
puts "Finish"

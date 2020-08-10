#!/usr/bin/tclsh
#source  /mnt/c/Users/dgall/OpenROAD-flow/setup_env.sh

# Command line parameters: bw - bit width, l - n° approximate bits

#ToDO: CONFIGURE THESE PARAMETERS!
set AUGER_DIRECTORY "/mnt/c/Users/dgall/AUGER"
set OpenROAD_DIRECTORY "/mnt/c/Users/dgall/OpenROAD-flow"
set PLATFORM "nangate45"

# #########################################################

puts "Starting"

set DESIGN_TYPE "DRUM"
set DESIGN_AUGER_NAME "DRUM"
set DIR_NAME "drum"

set bw [lindex $argv 0]
set l [lindex $argv 1]

cd $AUGER_DIRECTORY

puts "Runnig AUGER for $DESIGN_TYPE -bw $bw -l $l"
# Exec Auger
try {exec ./AUGER -m ${DESIGN_AUGER_NAME} -bw $bw -l $l -gen} on error {msg} {puts $msg}

puts "Creating directoris"
file mkdir $OpenROAD_DIRECTORY/flow/designs/src/$DESIGN_TYPE/${DIR_NAME}-$bw-$l
file mkdir $OpenROAD_DIRECTORY/flow/designs/$PLATFORM/$DESIGN_TYPE/${DIR_NAME}-$bw-$l

puts "Coping src"
# Copy all files generated by AUGER in the correct openROAD directory
foreach f [glob -directory ./ALGO/MULTIPLIERS/${DESIGN_AUGER_NAME}/SRC -nocomplain *] {
    file copy -force $f $OpenROAD_DIRECTORY/flow/designs/src/$DESIGN_TYPE/${DIR_NAME}-$bw-$l
}

cd $OpenROAD_DIRECTORY/flow/designs/$PLATFORM/$DESIGN_TYPE

puts "Coping config"
# Create all configuration files for openROAD
# Copy costraints.sdc and area data from jepg design
foreach f [glob -directory ../jpeg -nocomplain *] {
    file copy -force $f ./$DIR_NAME-$bw-$l
}
set fp [open ./$DIR_NAME-$bw-$l/config.mk w]
puts $fp "export DESIGN_NICKNAME = ${DIR_NAME}-$bw-$l"
puts $fp "export DESIGN_NAME = DRUM"
puts $fp "export PLATFORM = $PLATFORM"
puts $fp "export VERILOG_FILES = \$(wildcard ./designs/src/$DESIGN_TYPE/\$(DESIGN_NICKNAME)/*.v)"
puts $fp "export SDC_FILE = ./designs/\$(PLATFORM)/$DESIGN_TYPE/\$(DESIGN_NICKNAME)/constraint.sdc"

puts $fp "export DIE_AREA = 0 0 1200.04 1199.8"
puts $fp "export CORE_AREA = 10.07 9.8 1189.97 1190"
close $fp

cd $OpenROAD_DIRECTORY/flow


# Exec openROAD flow
puts "Runnig openROAD... 1/1"
try {exec make DESIGN_CONFIG=./designs/$PLATFORM/$DESIGN_TYPE/$DIR_NAME-$bw-$l/config.mk} on error {msg} {
    puts $msg
}

puts "Finish"
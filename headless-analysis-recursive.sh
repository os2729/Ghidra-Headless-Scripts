#!/bin/bash
# A script to run headless analysis on a directory of binaries in a folder, outputs to a new file in the output directory with the name of the binary.
# Author: Ollie S (GitHub: os2729)
# Usage: bash test-bash.sh <path to directory of binaries> <path to output directory>

# Check if the user has provided a directory of binaries
if [ -z "$1" ]
then
    echo "Please provide a directory of binaries"
    echo "Recursive Headless Analysis Script Usage: 
    bash headless-analysis-recursive.sh <path to directory of binaries> <path to output directory> "
    exit 1
fi

# If directory exists but is empty, exit with message notifying the folder is empty
if [ -d "$1" ] && [ -z "$(ls -A $1)" ]
then
    echo "The directory is empty"
    exit 1
fi

# Check to see if the user has provided an output directory
if [ -z "$2" ]
then
    echo "Please provide an output directory"
    exit 1
fi

HeadlessScriptPath="" # Path to the scripts you want to run
AnalysisScriptDirectory="" # Path to the Ghidra analysis script, normally in .../Ghidra/support

# Iterate through binaries to analyse from a directory
for file in $1/*
do
    # Binary name
    filename=$(basename -- "$file")
    # Strips file extension
    filename="${filename%.*}"
    # Run the headless analysis script on the binary, outputting to a new folder
    mkdir $2/$filename
    touch $2/analysed_binaries.txt
    # Note you need to replace the ScriptName with the name of the script in your path (e.g. dissassembler.py if using the scripts by @galoget)
    $AnalysisScriptDirectory/analyzeHeadless $2 $filename -import $file -scriptPath $HeadlessScriptPath -postscript ScriptName $2/$filename/$filename'filename.txt'
    $AnalysisScriptDirectory/analyzeHeadless $2 $filename+1 -import $file -scriptPath $HeadlessScriptPath -postscript ScriptName $2/$filename/$filename'filename.txt'
    # Remove Ghidra project files and directories as well as restore point files
    rm $2/*.gpr
    rm $2/*.rep
    rm -r $2/*.rep
    # Creates a text file in the output directory with time and date stamp the analysis was run
    echo $filename time: $(date +"%T") date: $(date +"%D") >> $2/analysed_binaries.txt
done
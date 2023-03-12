# Headless-recursive
A repository of bash scripts to run various tasks such as recursive analysis of binaries in [Ghidra](https://github.com/NationalSecurityAgency/ghidra). 

## headless-analysis-recursive
This script will run two seperate scripts in headless mode. It can easily be modified by copying the line with analyzeHeadless to run more scripts on each binary. The script is recursive so will perform the tasks from each script on a binary before moving to the next binary from the input directory.

## Before you run the script
Before you run the script you will need to make some changes to tailor it to your application. 
1. Fill in the `HeadlessScriptPath` field to list the directory where the scripts you want to run are located. 
2. Fill in the `AnalysisScriptDirectory` field to the location of your Ghidra analyzeHeadless script, this is most likely in a directory called /Ghidra/support
3. replace `ScriptName` to reflect the scripts you want to recursively run.
4. replace `filename.txt` to a relevant name to be appended to the binary name to represent what the output is.

## Usage 
```
bash test-bash.sh <path to directory of binaries> <path to output directory>
```
## Useful links
I originally wrote this script to run some disassembly and decompilation on some binaries I had, but this could be done with any analysis scripts. For this I used the scripts that [galoget](https://github.com/galoget) wrote. These scripts can be found in his repository [ghidra-headless-scripts](https://github.com/galoget/ghidra-headless-scripts).
> **Note**
> Their seems to be an issue of running recursive scripts on the same binary multiple times in headleass analysis mode. Therefor the +1 is used to circumvent this issue on the second script analysis. If you add more analysis, you will need to increment this everytime. 


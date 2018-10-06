# dbEvaluationScripts
Scripts used for automated evaluation of CS-387 Database and Information Systems Lab, CSE IIT-Bombay

The Particulrly useful script is : Lab07-spark/outlab/myFormat.sh

* The script assumes that all source files are either directly compresses or are present inside a folder which is then compressed.
* Name of folder is assumed to be same as that of archive.
* Archive must be in tar.gz or zip format and contain rollnumber as substring in name ( variable full regex asserts this )
* Full Regex appropriately groups and extracts filename, rollnumber and archive extension.
* Function extractArchive takes extension and file name as argument and extracts it to current directory.
* When ran, script goes to each submission extracts submissions and checks format specific to that assignment.
* Script puts failed cases to stderr.

The script for automated grading : Lab07-spark/outlab/doGrade.sh
* When ran, script goes to each submission extracts submissions and checks format specific to that assignment.
* After validating format, it copies source file to projectDirectory, builds and runs project.
* At successfull execution, scripts crafts output format for automated difference check. 


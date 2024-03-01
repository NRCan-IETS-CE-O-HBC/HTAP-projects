@ECHO OFF
ECHO -
ECHO This batch file will run cz4, cz5, cz6, cz7a, cz7b, and cz8.
ECHO It will also copy the output files to files with appropriate suffixes
ECHO between runs.
ECHO -
ECHO Please select the number of threads you'd like to use.
set /p threads= Number of Threads: 
ECHO -
ECHO Running with %threads% threads. If this is incorrect, please press CTRL-C and try again.
ECHO -
ECHO If ready to proceed, please press any key.
ECHO -
PAUSE

htap-prm.rb -r cz4.run -t %threads%
copy HTAP-prm-output.csv HTAP-prm-output-cz4.csv

htap-prm.rb -r cz5.run -t %threads%
copy HTAP-prm-output.csv HTAP-prm-output-cz5.csv

htap-prm.rb -r cz6.run -t %threads%
copy HTAP-prm-output.csv HTAP-prm-output-cz6.csv

htap-prm.rb -r cz7a.run -t %threads%
copy HTAP-prm-output.csv HTAP-prm-output-cz7a.csv

htap-prm.rb -r cz7b.run -t %threads%
copy HTAP-prm-output.csv HTAP-prm-output-cz7b.csv

htap-prm.rb -r cz8.run -t %threads%
copy HTAP-prm-output.csv HTAP-prm-output-cz8.csv
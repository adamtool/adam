dependencies:
=============
For saving nets as a pdf-file, there is the need for dot in version >= 2.36.0.
todo: BuDDy, otherwise the plain javaversion of javaBDD is used.

build:
======
ant jar

Possible modules:
=================
pg2dot		- Converts a Petri game in APT-format to a dot-file.
pg2pdf		- Converts a Petri game in APT-format to a pdf-file by using GraphViz (dot has to be executable).
ex_win_strat	- Returns true if there is a deadlock-avoiding winning strategy (system players) for the in APT-format given Petri game.
win_strat_graph - Creates a deadlock-avoiding winning strategy (system players) in the finite graph game of the in APT-format
		  given Petri game if existent. Saves strategy in the given folder as dot, and if dot is executable, as pdf.
win_strat_pg 	- Creates a deadlock-avoiding winning  strategy (system players) for the in APT-format given Petri game if existent.

Usage:
======
sh pg.sh pg2dot <path2PetriGame/filename.apt> <path2DesiredOutputFolder/filename>
sh pg.sh pg2pdf <path2PetriGame/filename.apt> <path2DesiredOutputFolder/filename>
sh pg.sh ex_win_strat <path2PetriGame/filename.apt>
sh pg.sh win_strat_graph <path2PetriGame/filename.apt> <path2DesiredOutputFolder/filename>
sh pg.sh win_strat_pg <path2PetriGame/filename.apt> <path2DesiredOutputFolder/filename>

Cleanup:
========
ant clean		- deletes folders: ./classes, ./test-classes, ./doc/javadoc
				and files: pg.jar, testng.xml
ant clean-strategies	- deletes all *_strategy.apt, *_strategy.dot, *_strategy.pdf files in ./nets/ and its subfolders
ant clean-all		- uses clean and clean-strategies and additionally deletes the ./reports/ folder.

Testing:
========

ant test 	- runs the whole test-suite
ant test-method - runs one method of one test class, i.g.:
		  ant test-method -Dtest.name=testOneWinningStrategyGraph -Dclass.name=uniolunisaar.petrigames.TestingFirstExamplePaper
ant test-class 	- runs one test class separately, i.g.: 
		  ant test-class -Dclass.name=uniolunisaar.petrigames.TestingBurglar

Format:
=======
Section 6.3 and Section 6.4.1 of APT.pdf from: https://github.com/renke/apt/tree/master/doc

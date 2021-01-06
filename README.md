Adam - Analyzing Distributed Asynchronous Models 
================================================
A command-line tool for ***model checking*** asynchronous distributed systems modeled with ***Petri nets with transits*** against ***Flow-LTL*** and ***Flow-CTL***
and for the ***synthesis*** of asynchronous distributed systems modeled with ***Petri games with transits***.
It combines the tools [AdamMC](https://github.com/adamtool/adammc) and [AdamSYNT](https://github.com/adamtool/adamsynt).


Dependencies:
-------------
This module depends on the 
- the repository as submodules: [libs](https://github.com/adamtool/libs), [examples](https://github.com/adamtool/examples), [framework](https://github.com/adamtool/framework), [logics](https://github.com/adamtool/logics), [modelchecker](https://github.com/adamtool/modelchecker), [synthesizer](https://github.com/adamtool/synthesizer), [high-level](https://github.com/adamtool/high-level), [webinterface-backend](https://github.com/adamtool/webinterface-backend).
- the external tools: [McHyper](https://github.com/reactive-systems/MCHyper), [AigerTools](http://fmv.jku.at/aiger/), [ABC](https://people.eecs.berkeley.edu/~alanmi/abc/).

# Checkout with all submodules
 git clone --recursive git@github.com:adamtool/adam.git <foldername>
 make checkout_branch_all

Create a file ADAM.properties

It uses
[McHyper](https://github.com/reactive-systems/MCHyper) for generating a circuit from a circuit for the system and an LTL formula and
[ABC](https://people.eecs.berkeley.edu/~alanmi/abc/) for model checking the resulting circuit.

Contains:
---------
- data structures for
  * alternating Büchi automata,
  * Kripke structures
- transformer for an alternating Büchi tree automaton and a Kripke structure to an alternating Büchi automaton
- transformer for an alternating Büchi automaton to a nondeterministic automaton
- The reduction methods for
  * Petri nets with transits / Flow-LTL to Petri nets and LTL
  * Petri nets with transits / Flow-CTL to Petri nets and LTL
  * Petri nets to Circuit
  
Integration:
------------
This module can be used as separate library and
- is integrated in: [adam](https://github.com/adamtool/adam), [adammc](https://github.com/adamtool/adammc),
- contains the packages: modelchecking,
- depends on the repos: [libs](https://github.com/adamtool/libs), [framework](https://github.com/adamtool/framework), [logics](https://github.com/adamtool/logics).

Related Publications:
---------------------
For Flow-LTL
- _Bernd Finkbeiner, Manuel Gieseking, Jesko Hecking-Harbusch, Ernst-Rüdiger Olderog:_
  [Model Checking Data Flows in Concurrent Network Updates](https://doi.org/10.1007/978-3-030-31784-3_30). ATVA 2019: 515-533 [(Full Version)](http://arxiv.org/abs/1907.11061).
  
For Flow-CTL
- _Bernd Finkbeiner, Manuel Gieseking, Jesko Hecking-Harbusch, Ernst-Rüdiger Olderog:_
  [Model Checking Branching Properties on Petri Nets with Transits](
https://doi.org/10.1007/978-3-030-59152-6_22). ATVA 2020: 394-410 [(Full Version)](https://arxiv.org/abs/2007.07235). 

AdamMC:
- _Bernd Finkbeiner, Manuel Gieseking, Jesko Hecking-Harbusch, Ernst-Rüdiger Olderog:_
  [AdamMC: A Model Checker for Petri Nets with Transits against Flow-LTL](https://doi.org/10.1007/978-3-030-53291-8_5). CAV (2) 2020: 64-76 [(Full Version)](https://arxiv.org/abs/2005.07130).

------------------------------------

How To Build
------------
A __Makefile__ is located in the main folder.
First, pull a local copy of the dependencies with
```
make pull_dependencies
```
then build the whole framework with all the dependencies with
```
make
```
To build a single dependencies separately, use, e.g,
```
make tools
```
To delete the build files and clean-up
```
make clean
```
To also delete the files generated by the test and all temporary files use
```
make clean-all
```
Some of the algorithms depend on external libraries or tools. To locate them properly create a file in the main folder
```
touch ADAM.properties
```
and add the absolute paths of the necessary libraries or tools:
```
libraryFolder=<path2repo>/dependencies/libs
aigertools=
dot=dot
time=/usr/bin/time
```
You may leave some of the properties open if you don't use the corresponding libraries/tools.

Tests
-----
You can run all tests for the module by just typing
```
ant test
```
For testing a specific class use for example
```
ant test-class -Dclass.name=uniolunisaar.adam.tests.mc.circuits.TestingIngoingLTL
```
and for testing a specific method use for example
```
ant test-method -Dclass.name=uniolunisaar.adam.tests.mc.circuits.TestingModelcheckingFlowLTLParallel -Dmethod.name=exampleToolPaper
```

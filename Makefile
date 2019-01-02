# the build target
CORE_TARGETS = tools pnwithtransits petrigames logics bounded symbolic modelchecker
t=jar

# should be executed no matter what
.PHONY: clean
.PHONY: clean-all
.PHONY: tools
.PHONY: pnwithtransits
.PHONY: petrigames
.PHONY: logics
.PHONY: bounded
.PHONY: symbolic
.PHONY: bdd
.PHONY: core
.PHONY: server
.PHONY: client
.PHONY: javadoc
.PHONY: examples

# the content of the excution script
ADAM_BASHSCRIPT = "\#!/bin/bash\n\nBASEDIR=\"\044(dirname \044\060)\"\n\nif [ ! -f \"\044BASEDIR/adam_ui.jar\" ] ; then\n\techo \"adam_ui.jar not found! Run 'ant jar' first!\" >&2\n\texit 127\nfi\n\njava -DPROPERTY_FILE=./ADAM.properties -jar \"\044BASEDIR/adam_ui.jar\" \"\044@\""

# functions
define generate_src
	mkdir -p adam_src
	if [ $(1) = true ]; then\
		cp -R ./lib ./adam_src/lib/; \
		cp -R --parent ./test/lib ./adam_src/; \
	fi
	for i in $$(find . -type d \( -path ./benchmarks -o -path ./test/lib -o -path ./lib -o -path ./adam_src \) -prune -o -name '*' -not -regex ".*\(class\|qcir\|pdf\|tex\|apt\|dot\|jar\|ods\|txt\|tar.gz\|aux\|log\|res\|aig\|aag\|lola\|cex\|properties\|json\|xml\|out\|pnml\|so\)" -type f); do \
		echo "cp" $$i; \
		cp --parent $$i ./adam_src/ ;\
	done
	tar -zcvf adam_src.tar.gz adam_src
	rm -r -f ./adam_src
endef

# targets
all: deploy

tools: 
	ant -buildfile ./tools/build.xml $(t)

petrigames: 
	ant -buildfile ./petriGames/build.xml $(t)

pnwithtransits: 
	ant -buildfile ./petrinetWithTransits/build.xml $(t)

logics: 
	ant -buildfile ./logics/build.xml $(t)

modelchecker: 
	ant -buildfile ./modelchecking/build.xml $(t)

bounded: 
	ant -buildfile ./boundedalgorithms/build.xml $(t)

bdd: 
	ant -buildfile ./symbolicalgorithms/bddapproach/build.xml $(t)

mtbdd: 
	ant -buildfile ./symbolicalgorithms/mtbddapproach/build.xml $(t)

symbolic: bdd mtbdd

core:
	ant -buildfile ./core/build.xml $(t)

server: 
	ant -buildfile ./server/build.xml $(t)

client: 
	ant -buildfile ./client/ui/build.xml $(t)

setClean:
	$(eval t=clean)

setCleanAll:
	$(eval t=clean-all)

setDeploy:
	$(eval t=deploy)

setStandalone:
	$(eval t=jar-standalone)

clean: setClean tools petrigames pnwithtransits logics modelchecker bounded symbolic core server client
	rm -r -f deploy 
	rm -r -f javadoc

clean-all: setCleanAll tools petrigames pnwithtransits logics modelchecker bounded symbolic core server client
	rm -r -f deploy
	rm -r -f javadoc

javadoc: 
	ant javadoc

core_deploy: $(CORE_TARGETS) setStandalone core
	mkdir -p deploy
	cp ./core/adam_core-standalone.jar ./deploy/adam_core.jar

deploy: $(CORE_TARGETS) setDeploy server client
	mkdir -p deploy
	mkdir -p deploy/lib
	echo  $(ADAM_BASHSCRIPT) > ./deploy/adam
	chmod +x ./deploy/adam
	cp ./client/ui/adam_ui.jar ./deploy/adam_ui.jar
	cp ./server/adam_server.jar ./deploy/adam_server.jar
	cp ./server/adam_protocol.jar ./deploy/adam_protocol.jar
	cp ./ADAM.properties ./deploy/ADAM.properties
	cp ./lib/quabs_mac ./deploy/lib/quabs_mac
	cp ./lib/quabs_unix ./deploy/lib/quabs_unix
	cp ./lib/javaBDD/libcudd.so ./deploy/lib/libcudd.so
	cp ./lib/javaBDD/libbuddy.so ./deploy/lib/libbuddy.so

src_withlibs: clean-all
	$(call generate_src, true)

src: clean-all
	$(call generate_src, false)

examples:
	mkdir -p examples_tmp
	for i in $$(find ./examples -regex '.*\.\(apt\|${withSuff}\)' ); do \
		echo "cp" $$i; \
		cp --parent $$i ./examples_tmp/ ;\
	done
	tar -zcf adam_examples.tar.gz examples_tmp/examples
	rm -r -f ./examples_tmp

# the build target
CORE_TARGETS = tools petrinetwithtransits
MC_TARGETS = logics modelchecker
SYNT_TARGETS = petrigames
BOUNDED_TARGETS = bounded
SYMBOLIC_TARGETS = symbolic
HL_TARGETS = highlevel
SYNT_ALL_TARGETS = $(SYNT_TARGETS)  $(BOUNDED_TARGETS)  $(SYMBOLIC_TARGETS) $(HL_TARGETS)
BACKEND_TARGETS = $(CORE_TARGETS) $(MC_TARGETS) $(SYNT_ALL_TARGETS)
UI_TARGETS = server adammc adamsynt adam
t=jar

# should be executed no matter what
.PHONY: clean
.PHONY: clean-all
.PHONY: tools
.PHONY: petrinetwithtransits
.PHONY: petrigames
.PHONY: logics
.PHONY: bounded
.PHONY: symbolic
.PHONY: bdd
.PHONY: core
.PHONY: server
.PHONY: ui
.PHONY: adammc
.PHONY: adamsynt
.PHONY: adam
.PHONY: javadoc
.PHONY: examples
.PHONY: test
.PHONY: highlevel

# functions
create_bashscript = \#!/bin/bash\n\nBASEDIR=\"\044(dirname \044\060)\"\n\nif [ ! -f \"\044BASEDIR/Adam$(strip $(1)).jar\" ] ; then\n\techo \"Adam$(strip $(1)).jar not found! Run 'ant jar' first!\" >&2\n\texit 127\nfi\n\njava -DPROPERTY_FILE=./ADAM.properties -jar \"\044BASEDIR/Adam$(strip $(1)).jar\" \"\044@\"

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

petrinetwithtransits:
	ant -buildfile ./petrinetWithTransits/build.xml $(t)

petrigames:
	ant -buildfile ./petriGames/build.xml $(t)

highlevel:
	ant -buildfile ./highLevel/build.xml $(t)

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

interface:
	ant -buildfile ./core/build.xml $(t)

server:
	ant -buildfile ./server/build.xml $(t)

ui:
	ant -buildfile ./ui/build.xml $(t)

adammc:
	ant -buildfile ./adammc/build.xml $(t)

adamsynt:
	ant -buildfile ./adamsynt/build.xml $(t)

adam:
	ant -buildfile ./adam/build.xml $(t)

setClean:
	$(eval t=clean)

setCleanAll:
	$(eval t=clean-all)

setDeploy:
	$(eval t=deploy)

setDeployMC:
	$(eval t=deploy_mc)

setDeploySynt:
	$(eval t=deploy_synth)

setDeployBounded:
	$(eval t=deploy_bounded)

setStandalone:
	$(eval t=jar-standalone)

clean: setClean $(BACKEND_TARGETS) $(UI_TARGETS) interface
	rm -r -f deploy
	rm -r -f javadoc

clean-all: setCleanAll $(BACKEND_TARGETS) $(UI_TARGETS) interface
	rm -r -f deploy
	rm -r -f javadoc

javadoc:
	ant javadoc

core_deploy: $(BACKEND_TARGETS) setDeploy interface
	mkdir -p deploy
	cp ./core/adam_core.jar ./deploy/adam_core.jar

#test:
#	echo "$(call create_bashscript)" > ./deploy/adam

mc_deploy: $(CORE_TARGETS) $(MC_TARGETS) setDeploy adammc
	mkdir -p deploy
	echo "$(call create_bashscript, MC)" > ./deploy/AdamMC
	chmod +x ./deploy/AdamMC
	cp ./adammc/adam_mc.jar ./deploy/AdamMC.jar
	cp ./ADAM.properties ./deploy/ADAM.properties

synt_deploy: $(CORE_TARGETS) $(SYNT_ALL_TARGETS) setDeploy server adamsynt
	mkdir -p deploy
	mkdir -p deploy/lib
	echo "$(call create_bashscript, SYNT)" > ./deploy/AdamSYNT
	chmod +x ./deploy/AdamSYNT
	cp ./adamsynt/adam_synt.jar ./deploy/AdamSYNT.jar
	cp ./server/adam_server.jar ./deploy/adam_server.jar
	cp ./adamsynt/adam_protocol.jar ./deploy/adam_protocol.jar
	cp ./ADAM.properties ./deploy/ADAM.properties
	cp ./lib/quabs_mac ./deploy/lib/quabs_mac
	cp ./lib/quabs_unix ./deploy/lib/quabs_unix
	cp ./lib/javaBDD/libcudd.so ./deploy/lib/libcudd.so
	cp ./lib/javaBDD/libbuddy.so ./deploy/lib/libbuddy.so

deploy: $(BACKEND_TARGETS) setDeploy $(UI_TARGETS)
	mkdir -p deploy
	mkdir -p deploy/lib
	echo "$(call create_bashscript)" > ./deploy/Adam
#	echo  $(ADAM_BASHSCRIPT) > ./deploy/adam
	chmod +x ./deploy/Adam
	cp ./adam/adam_adam.jar ./deploy/Adam.jar
	cp ./server/adam_server.jar ./deploy/adam_server.jar
	cp ./adamsynt/adam_protocol.jar ./deploy/adam_protocol.jar
	cp ./ADAM.properties ./deploy/ADAM.properties
	cp ./lib/quabs_mac ./deploy/lib/quabs_mac
	cp ./lib/quabs_unix ./deploy/lib/quabs_unix
	cp ./lib/javaBDD/libcudd.so ./deploy/lib/libcudd.so
	cp ./lib/javaBDD/libbuddy.so ./deploy/lib/libbuddy.so

# The noUI targets are kind of hacky because they take the core package with the complete Adam and 
# tries to filter out unrelated classes.
mc_deploy_noUI: $(BACKEND_TARGETS) setDeployMC interface
	mkdir -p deploy
	echo "$(call create_bashscript, _mc)" > ./deploy/adam_mc
	chmod +x ./deploy/adam_mc
	cp ./core/adam_mc.jar ./deploy/Adam_mc.jar
	cp ./ADAM.properties ./deploy/ADAM.properties

synt_deploy_noUI: $(BACKEND_TARGETS) setDeploySynt interface
	mkdir -p deploy
	mkdir -p deploy/lib
	echo "$(call create_bashscript, _synt)" > ./deploy/adam_synt
	chmod +x ./deploy/adam_synt
	cp ./core/adam_synt.jar ./deploy/Adam_synt.jar
	cp ./ADAM.properties ./deploy/ADAM.properties
	cp ./lib/quabs_mac ./deploy/lib/quabs_mac
	cp ./lib/quabs_unix ./deploy/lib/quabs_unix
	cp ./lib/javaBDD/libcudd.so ./deploy/lib/libcudd.so
	cp ./lib/javaBDD/libbuddy.so ./deploy/lib/libbuddy.so

bounded_deploy_noUI: $(BACKEND_TARGETS) setDeployBounded interface
	mkdir -p deploy
	echo "$(call create_bashscript, _bounded)" > ./deploy/adam_bounded
	chmod +x ./deploy/adam_bounded
	cp ./core/adam_bounded.jar ./deploy/Adam_bounded.jar
	cp ./ADAM.properties ./deploy/ADAM.properties

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

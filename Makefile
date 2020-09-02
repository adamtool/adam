##### @author Manuel Gieseking
# the folders of all submodules. This is used for all the pull, commit, merge, etc. commands of git
DEPENDENCIES_FOLDERS="libs,framework,logics,modelchecker,examples,synthesizer,boundedSynthesis,synthesisDistrEnv,high-level,server-command-line-protocol,server-command-line,webinterface-backend,ui,adammc,adamsynt"
# if you only want to consider a subset of the submodules for pulling (e.g., stay on another branch). Used by pull_subset.
DEPENDENCIES_SUBSET=""
# the build target
FRAMEWORK_TARGETS = tools petrinetwithtransits
MODELCHECKING_TARGETS = logics mc
SYNTHESIZER_TARGETS = petrigames symbolic bounded distrEnv highlevel
UI_TARGETS = protocol server ui adammc adamsynt adam
t=jar

# should be executed no matter if a file with the same name exists or not
.PHONY: tools
.PHONY: petrinetwithtransits
.PHONY: logics
.PHONY: mc
.PHONY: petrigames
.PHONY: bounded
.PHONY: symbolic
.PHONY: bdd
.PHONY: mtbdd
.PHONY: distrEnv
.PHONY: highlevel
.PHONY: backend
.PHONY: server
.PHONY: ui
.PHONY: adammc
.PHONY: adamsynt
.PHONY: adam
.PHONY: backend_deploy
.PHONY: mc_deploy_noUI
.PHONY: synt_deploy_noUI
.PHONY: bounded_deploy_noUI
#.PHONY: javadoc
.PHONY: examples
# git targets
.PHONY: status_all
.PHONY: checkout_branch_all
.PHONY: close_branch_all
.PHONY: pull_all
.PHONY: pl
.PHONY: pull_subset
.PHONY: commit_all
.PHONY: co
.PHONY: merge_all
.PHONY: push_all
.PHONY: ph

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

######################## git commands for all submodules
status_all:
	./status_all.sh $(DEPENDENCIES_FOLDERS)

# branch=<name> specifies the branch which should be checked out. Default: branch=master.
# new=<name> creates a new branch with the name
checkout_branch_all:
	./checkout_branch_all.sh

# branch=<name> must be set and specifies the branch which should be closed.
# tag=<tag> can be set to name the tag which is given the closing commit.
#Attention: the branch is deleted and only a tag links to the commit.
close_branch_all:
	./close_branch_all.sh $(DEPENDENCIES_FOLDERS)

pull_all:
# the following command leaves the submodule with detached heads. Thus, we use an own script
#	git submodule update --remote
#	git pull
	./pull_all.sh $(DEPENDENCIES_FOLDERS)

pl: pull_all

pull_subset:
	./pull_all.sh $(DEPENDENCIES_SUBSET)

# msg="<msg>" must be set to define a commit message.
commit_all:
	./commit_all.sh $(DEPENDENCIES_FOLDERS)

# msg="<msg>" must be set to define a commit message.
co: commit_all

# branch=<name> must be set and specifies the branch which should be merged.
merge_all:
	./merge_all.sh $(DEPENDENCIES_FOLDERS)

# options="<options>" allows to add options to the git push command, e.g.,
# make push_all options="--set-upstream origin test" to push the first time into a new branch test and link this to remote branch.
push_all:
	./push_all.sh $(DEPENDENCIES_FOLDERS)

ph: push_all

tools:
	ant -buildfile ./framework/tools/build.xml $(t)

petrinetwithtransits:
	ant -buildfile ./framework/petrinetWithTransits/build.xml $(t)

logics:
	ant -buildfile ./logics/build.xml $(t)

mc:
	ant -buildfile ./modelchecker/build.xml $(t)

petrigames:
	ant -buildfile ./synthesizer/petriGames/build.xml $(t)

bounded:
	ant -buildfile ./boundedSynthesis/build.xml $(t)

bdd:
	ant -buildfile ./synthesizer/symbolicalgorithms/bddapproach/build.xml $(t)

mtbdd:
	ant -buildfile ./synthesizer/symbolicalgorithms/mtbddapproach/build.xml $(t)

symbolic: bdd mtbdd

distrEnv:
	ant -buildfile ./synthesisDistrEnv/build.xml $(t)

highlevel:
	ant -buildfile ./high-level/build.xml $(t)

backend:
	ant -buildfile ./webinterface-backend/build.xml $(t)

protocol:
	ant -buildfile ./server-command-line-protocol/build.xml $(t)

server:
	ant -buildfile ./server-command-line/build.xml $(t)

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

javadoc:
	ant javadoc

backend_deploy: $(FRAMEWORK_TARGETS) $(MODELCHECKING_TARGETS) $(SYNTHESIZER_TARGETS) setDeploy backend
	mkdir -p deploy
	cp ./adam_core.jar ./deploy/adam_core.jar


mc_deploy: $(FRAMEWORK_TARGETS) $(MODELCHECKING_TARGETS) ui setDeploy adammc
	mkdir -p deploy
	echo "$(call create_bashscript, MC)" > ./deploy/AdamMC
	chmod +x ./deploy/AdamMC
	cp ./adammc/adam_mc.jar ./deploy/AdamMC.jar
	cp ./ADAM.properties ./deploy/ADAM.properties

synt_deploy: $(FRAMEWORK_TARGETS) $(SYNTHESIZER_TARGETS) ui protocol setDeploy server adamsynt
	mkdir -p deploy
	mkdir -p deploy/lib
	echo "$(call create_bashscript, SYNT)" > ./deploy/AdamSYNT
	chmod +x ./deploy/AdamSYNT
	cp ./synthesizer/adamsynt/adam_synt.jar ./deploy/AdamSYNT.jar
	cp ./server-command-line/adam_server.jar ./deploy/adam_server.jar
	cp ./ADAM.properties ./deploy/ADAM.properties
	cp ./libs/quabs_mac ./deploy/lib/quabs_mac
	cp ./libs/quabs_unix ./deploy/lib/quabs_unix
	cp ./libs/javaBDD/libcudd.so ./deploy/lib/libcudd.so
	cp ./libs/javaBDD/libbuddy.so ./deploy/lib/libbuddy.so

deploy: $(FRAMEWORK_TARGETS) $(MODELCHECKING_TARGETS) $(SYNTHESIZER_TARGETS) ui protocol setDeploy server adamsynt adammc adam
	mkdir -p deploy
	mkdir -p deploy/lib
	echo "$(call create_bashscript)" > ./deploy/Adam
#	echo  $(ADAM_BASHSCRIPT) > ./deploy/adam
	chmod +x ./deploy/Adam
	cp ./adam/adam_adam.jar ./deploy/Adam.jar
	cp ./server-command-line/adam_server.jar ./deploy/adam_server.jar
	cp ./ADAM.properties ./deploy/ADAM.properties
	cp ./libs/quabs_mac ./deploy/lib/quabs_mac
	cp ./libs/quabs_unix ./deploy/lib/quabs_unix
	cp ./libs/javaBDD/libcudd.so ./deploy/lib/libcudd.so
	cp ./libs/javaBDD/libbuddy.so ./deploy/lib/libbuddy.so

# The noUI targets are kind of hacky because they take the core package with the complete Adam and 
# tries to filter out unrelated classes.
mc_deploy_noUI: $(FRAMEWORK_TARGETS) $(MODELCHECKING_TARGETS) setDeployMC backend
	mkdir -p deploy
	echo "$(call create_bashscript, _mc)" > ./deploy/adam_mc
	chmod +x ./deploy/adam_mc
	cp ./webinterface-backend/adam_mc.jar ./deploy/Adam_mc.jar
	cp ./ADAM.properties ./deploy/ADAM.properties

synt_deploy_noUI: $(FRAMEWORK_TARGETS) $(SYNTHESIZER_TARGETS) setDeploySynt backend
	mkdir -p deploy
	mkdir -p deploy/lib
	echo "$(call create_bashscript, _synt)" > ./deploy/adam_synt
	chmod +x ./deploy/adam_synt
	cp ./webinterface-backend/adam_synt.jar ./deploy/Adam_synt.jar
	cp ./ADAM.properties ./deploy/ADAM.properties
	cp ./libs/quabs_mac ./deploy/lib/quabs_mac
	cp ./libs/quabs_unix ./deploy/lib/quabs_unix
	cp ./libs/javaBDD/libcudd.so ./deploy/lib/libcudd.so
	cp ./libs/javaBDD/libbuddy.so ./deploy/lib/libbuddy.so

bounded_deploy_noUI: $(FRAMEWORK_TARGETS) petrigames bounded setDeployBounded backend
	mkdir -p deploy
	echo "$(call create_bashscript, _bounded)" > ./deploy/adam_bounded
	chmod +x ./deploy/adam_bounded
	cp ./webinterface-backend/adam_bounded.jar ./deploy/Adam_bounded.jar
	cp ./ADAM.properties ./deploy/ADAM.properties

clean: setClean$(FRAMEWORK_TARGETS) $(MODELCHECKING_TARGETS) $(SYNTHESIZER_TARGETS) $(UI_TARGETS)
	rm -r -f deploy
	rm -r -f javadoc

clean-all: setCleanAll $(FRAMEWORK_TARGETS) $(MODELCHECKING_TARGETS) $(SYNTHESIZER_TARGETS) $(UI_TARGETS)
	rm -r -f deploy
	rm -r -f javadoc

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

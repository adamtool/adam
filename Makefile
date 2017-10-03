# the build target
CORE_TARGETS = tools ds logic generators bounded symbolic
t=jar

# should be executed no matter what
.PHONY: clean
.PHONY: clean-all
.PHONY: tools
.PHONY: ds
.PHONY: logic
.PHONY: generators
.PHONY: bounded
.PHONY: symbolic
.PHONY: core
.PHONY: server
.PHONY: client
.PHONY: javadoc

all: deploy

tools: 
	ant -buildfile ./tools/build.xml $(t)

ds: 
	ant -buildfile ./ds/build.xml $(t)

logic: 
	ant -buildfile ./logic/build.xml $(t)

generators: 
	ant -buildfile ./generators/build.xml $(t)

bounded: 
	ant -buildfile ./boundedalgorithms/build.xml $(t)

symbolic: 
	ant -buildfile ./symbolicalgorithms/build.xml $(t)

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

clean: setClean tools ds logic generators bounded symbolic core server client
	rm -r -f deploy 
	rm -r -f javadoc

clean-all: setCleanAll tools ds logic generators bounded symbolic core server client
	rm -r -f deploy 
	rm -r -f javadoc

javadoc: 
	ant javadoc

core_deploy: $(CORE_TARGETS) setStandalone core
	mkdir -p deploy
	cp ./core/adam_core-standalone.jar ./deploy/adam_core.jar

deploy: $(CORE_TARGETS) setDeploy server client
	mkdir -p deploy
	cp ./client/ui/adam ./deploy/adam
	cp ./client/ui/adam_ui.jar ./deploy/adam_ui.jar
	cp ./server/adam_server.jar ./deploy/adam_server.jar
	cp ./server/adam_protocol.jar ./deploy/adam_protocol.jar

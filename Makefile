# the build target
t=jar

# should be executed no matter what
.PHONY: clean
.PHONY: tools
.PHONY: ds
.PHONY: logic
.PHONY: generators
.PHONY: bounded
.PHONY: symbolic
.PHONY: server
.PHONY: client

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

server: 
	ant -buildfile ./server/build.xml $(t)

client: 
	ant -buildfile ./client/ui/build.xml $(t)

setClean:
	$(eval t=clean)

setDeploy:
	$(eval t=deploy)

clean: setClean tools ds logic generators bounded symbolic server client
	rm -r deploy 

deploy: tools ds logic generators bounded symbolic setDeploy server client
	mkdir -p deploy
	cp ./client/ui/adam ./deploy/adam
	cp ./client/ui/adam_ui.jar ./deploy/adam_ui.jar
	cp ./server/adam_server.jar ./deploy/adam_server.jar
	cp ./server/adam_protocol.jar ./deploy/adam_protocol.jar

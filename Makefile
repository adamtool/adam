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

all: pdf

call: 

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

deploy: tools ds logic generators bounded symbolic setDeploy server client

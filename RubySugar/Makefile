PROJECT_NAME=RubySugar
WORKSPACE=$(PROJECT_NAME).xcworkspace
DEFAULT_SCHEME=$(PROJECT_NAME)
DEFAULT_FLAGS=-sdk iphonesimulator
TESTING_TOOL=xcodebuild

DEFAULT_TASK=$(TESTING_TOOL) -workspace $(WORKSPACE) -scheme $(DEFAULT_SCHEME) $(DEFAULT_FLAGS)

all:	clean build test
		
clean:
		$(DEFAULT_TASK) clean | xcpretty -c

build:
		$(DEFAULT_TASK) build | xcpretty -c

test:
		$(DEFAULT_TASK) clean build test | xcpretty -tc
		# $(DEFAULT_TASK) test | xcpretty -c

ci:
		$(DEFAULT_TASK) clean build test | xcpretty -c
FORMAT_ARGS=--maxwidth 120 --swiftversion 5 --exclude RatoNet/Integrations/Tesla/Protobuf
LINT_ARGS=--strict --quiet

all:
	$(MAKE) style
	$(MAKE) lint

style:
	swiftformat $(FORMAT_ARGS) "Common"
	swiftformat $(FORMAT_ARGS) "RatoNet"
	swiftformat $(FORMAT_ARGS) "RatoNet Watch"
	swiftformat $(FORMAT_ARGS) "RatoNet Widget"
	swiftformat $(FORMAT_ARGS) "RatoNet Screen Recording"
	swiftformat $(FORMAT_ARGS) "RatoNetTests"

style-check:
	swiftformat $(FORMAT_ARGS) --lint "Common"
	swiftformat $(FORMAT_ARGS) --lint "RatoNet"
	swiftformat $(FORMAT_ARGS) --lint "RatoNet Watch"
	swiftformat $(FORMAT_ARGS) --lint "RatoNet Widget"
	swiftformat $(FORMAT_ARGS) --lint "RatoNet Screen Recording"
	swiftformat $(FORMAT_ARGS) --lint "RatoNetTests"

lint:
	swiftlint lint $(LINT_ARGS) "Common"
	swiftlint lint $(LINT_ARGS) "RatoNet"
	swiftlint lint $(LINT_ARGS) "RatoNet Watch"
	swiftlint lint $(LINT_ARGS) "RatoNet Widget"
	swiftlint lint $(LINT_ARGS) "RatoNet Screen Recording"
	swiftlint lint $(LINT_ARGS) "RatoNetTests"

machine-translate:
	python3 utils/translate.py Common/Localizable.xcstrings

pack-exported-localizations:
	cd RatoNet\ Localizations && \
	for f in * ; do \
	    python3 ../utils/xliff.py $$f/Localized\ Contents/*.xliff && \
	    zip -qr $$f.zip $$f && \
	    rm -rf $$f ; \
	done

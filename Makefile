DEV_TAGS = dev
LOG_TAGS =
TEST_FLAGS =

GOTEST := GO111MODULE=on go test -v
GOLIST := go list $(PKG)/...

UNIT_RACE := xargs -I{} sh -c '$(GOTEST) -tags="$(DEV_TAGS) $(LOG_TAGS)" $(TEST_FLAGS) -race -gcflags=all=-d=checkptr=0 {} || exit 255' <<< `$(GOLIST)`

unit-race:
	@$(call print, "Running unit race tests.")
	env CGO_ENABLED=1 GORACE="history_size=7 halt_on_errors=1" $(UNIT_RACE)


.PHONY: unit-race

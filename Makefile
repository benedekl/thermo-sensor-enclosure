SCAD?=openscad

BUILD_DIR = build
STL_TARGETS = $(patsubst %.scad,$(BUILD_DIR)/%.stl,$(wildcard *.scad))
PNG_TARGETS = $(patsubst %.scad,$(BUILD_DIR)/%.png,$(wildcard *.scad))

all: models

include $(wildcard $(BUILD_DIR)/*.deps)

.PHONY: all models clean
models: $(STL_TARGETS) $(PNG_TARGETS)

.PRECIOUS: $(BUILD_DIR)/. $(BUILD_DIR)%/.

$(BUILD_DIR)/.:
	mkdir -p -- $@

$(BUILD_DIR)%/.:
	mkdir -p -- $@

.SECONDEXPANSION:

$(BUILD_DIR)/%.stl: %.scad | $$(@D)/.
	$(SCAD) -m make -o "$@" -d "$@.deps" "$<"

$(BUILD_DIR)/%.png: %.scad | $$(@D)/.
	$(SCAD) -m make -o "$@" -d "$@.deps" "$<" --render

clean:
	rm -r $(STL_TARGETS) $(PNG_TARGETS) $(BUILD_DIR)/*.deps
	rmdir $(BUILD_DIR)

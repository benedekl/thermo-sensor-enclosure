SCAD?=openscad

BUILD_DIR = build
STL_TARGETS = $(patsubst %.scad,$(BUILD_DIR)/%.stl,$(wildcard *.scad))
PNG_TARGETS = $(patsubst %.scad,$(BUILD_DIR)/%.png,$(wildcard *.scad))

all: models

.PHONY: all models clean
models: $(STL_TARGETS) $(PNG_TARGETS)

.PRECIOUS: $(BUILD_DIR)/. $(BUILD_DIR)%/.

$(BUILD_DIR)/.:
	mkdir -p -- $@

$(BUILD_DIR)%/.:
	mkdir -p -- $@

.SECONDEXPANSION:

$(BUILD_DIR)/%.stl: %.scad | $$(@D)/.
	$(SCAD) -o "$@" "$<"

$(BUILD_DIR)/%.png: %.scad | $$(@D)/.
	$(SCAD) -o "$@" "$<" --render

clean:
	rm -r $(STL_TARGETS) $(PNG_TARGETS)
	rmdir $(BUILD_DIR)

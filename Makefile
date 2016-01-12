HEKA_DIR ?= /home/elemoine/src/go-workspace/src/github.com/elemoine/heka
NUM_LOG_FILES ?= 500

HEKA_BUILD_DIR := $(HEKA_DIR)/build
HEKA_SHARE_DIR := $(HEKA_BUILD_DIR)/_CPack_Packages/Linux/DEB/heka_0.11.0_amd64/usr/share/heka/

.PHONY: run
run: logs/kern$(NUM_LOG_FILES).log .share_dir.timestamp
	rm -f output.log
	$(HEKA_DIR)/build/heka/bin/hekad -config=heka.conf

logs/kern$(NUM_LOG_FILES).log: kern.log
	mkdir -p $(dir $@)
	for i in $$(seq 1 $(NUM_LOG_FILES)); do cp kern.log logs/kern$${i}.log; done

.share_dir/rsyslog.lua: $(HEKA_DIR)/sandbox/lua/decoders/rsyslog.lua
	mkdir -p $(dir $@)
	cp $< $@

.share_dir.timestamp:
	cp -r $(HEKA_SHARE_DIR) .share_dir
	touch $@

.PHONY: clean
clean:
	rm -f .share_dir.timestamp
	rm -f output.log
	rm -rf logs
	rm -rf .share_dir .base_dir

default: install

INSTALL_DIR = $(HOME)
CONFIG_DIR = $(INSTALL_DIR)/.config
BIN_DIR = $(INSTALL_DIR)/.local/bin
FILES = \
	$(INSTALL_DIR)/.bashrc \
	$(INSTALL_DIR)/.gitconfig \
	$(INSTALL_DIR)/.inputrc \
	$(INSTALL_DIR)/.profile \
	$(INSTALL_DIR)/.tmux.conf \

CONFIG_FILES = \
	$(CONFIG_DIR)/i3 \
	$(CONFIG_DIR)/i3blocks\
	$(CONFIG_DIR)/nvim \
	$(CONFIG_DIR)/picom \

BIN_FILES = \
	$(BIN_DIR)/powerctl \
	$(BIN_DIR)/git-clone-bare.sh \

$(INSTALL_DIR):
	mkdir -p $(INSTALL_DIR)

$(CONFIG_DIR):
	mkdir -p $(CONFIG_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(INSTALL_DIR)/.%: .% $(INSTALL_DIR)
	ln -fs $(PWD)/$< $@

$(CONFIG_DIR)/%: .config/% $(CONFIG_DIR)
	ln -fs $(PWD)/$< $@

$(BIN_DIR)/%: .local/bin/% $(BIN_DIR)
	ln -fs $(PWD)/$< $@

install: $(FILES) $(CONFIG_FILES) $(BIN_FILES)
	git submodule update --init

uninstall:
	for F in $(FILES) $(CONFIG_FILES); do find $$F -type l -delete; done

.PHONY: install uninstall

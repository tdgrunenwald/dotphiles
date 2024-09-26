default: install

INSTALL_DIR = $(HOME)
CONFIG_DIR = $(INSTALL_DIR)/.config
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

$(INSTALL_DIR):
	mkdir -p $(INSTALL_DIR)

$(CONFIG_DIR):
	mkdir -p $(CONFIG_DIR)

$(INSTALL_DIR)/.%: .% $(INSTALL_DIR)
	ln -bfs $(PWD)/$< $@

$(CONFIG_DIR)/%: .config/% $(CONFIG_DIR)
	ln -bfs $(PWD)/$< $@

install: $(FILES) $(CONFIG_FILES)
	git submodule update --init

uninstall:
	for F in $(FILES) $(CONFIG_FILES); do find $$F -type l -delete; done

.PHONY: install uninstall

INSTALL_DIR = $(HOME)/.local/bin
SCRIPT = dhakerni

.PHONY: install uninstall

install:
	chmod +x $(SCRIPT)
	mkdir -p $(INSTALL_DIR)
	cp $(SCRIPT) $(INSTALL_DIR)/$(SCRIPT)
	@echo "✅ Installed to $(INSTALL_DIR)/$(SCRIPT)"
	@echo "   Run: dhakerni --help"

uninstall:
	dhakerni uninstall 2>/dev/null || true
	rm -f $(INSTALL_DIR)/$(SCRIPT)
	@echo "✅ Removed $(INSTALL_DIR)/$(SCRIPT)"
	@echo "   Config kept at ~/.config/dhakerni/"
	@echo "   To remove config: rm -rf ~/.config/dhakerni"

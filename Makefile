# EzRe v1.0.1 GNUMakefile for Linux/Windows by Alex Free

include variables.mk

COMPILER_FLAGS+=-DVERSION=\"$(VERSION)\"

$(PROGRAM): clean
	mkdir -p $(BUILD_DIR)
ifeq ($(strip $(EXECUTABLE_NAME)),)
	$(COMPILER) $(COMPILER_FLAGS) $(SOURCE_FILES) -o $(BUILD_DIR)/$(PROGRAM)
else
	$(COMPILER) $(COMPILER_FLAGS) $(SOURCE_FILES) -o $(BUILD_DIR)/$(EXECUTABLE_NAME)
endif

.PHONY: deps-apt
deps-apt:
	sudo apt update
	sudo apt install --yes $(BUILD_DEPENDS_APT)

.PHONY: deps-dnf
deps-dnf:
	sudo dnf update
	sudo dnf -y install  $(BUILD_DEPENDS_DNF)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)/$(PROGRAM).exe $(BUILD_DIR)/$(PROGRAM)

.PHONY: clean-build
clean-build:
	rm -rf $(BUILD_DIR)

.PHONY: linux-i386
linux-i386: clean
	make $(PROGRAM) COMPILER_FLAGS='$(COMPILER_FLAGS_LINUX_X86) $(COMPILER_FLAGS)' EXECUTABLE_NAME='$(PROGRAM).i386'

.PHONY: linux-x86_64
linux-x86_64: clean
	make $(PROGRAM) EXECUTABLE_NAME='$(PROGRAM).x86_64'

.PHONY: windows-i686
windows-i686: clean
	make $(PROGRAM) COMPILER=$(WINDOWS_X86_COMPILER) EXECUTABLE_NAME='$(PROGRAM).i686.exe'

.PHONY: windows-x86_64
windows-x86_64: clean
	make $(PROGRAM) COMPILER=$(WINDOWS_X86_64_COMPILER) EXECUTABLE_NAME='$(PROGRAM).x86_64.exe'

.PHONY: release
release:
	rm -rf $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(PLATFORM) $(BUILD_DIR)/$(PROGRAM)-$(VERSION)-$(PLATFORM).zip
	mkdir $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(PLATFORM)
ifeq ($(strip $(WINDOWS_RELEASE)),)
	cp $(BUILD_DIR)/$(EXECUTABLE_NAME) $(BUILD_DIR)/$(PROGRAM)
	cp -r $(BUILD_DIR)/$(PROGRAM) $(RELEASE_FILES) $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(PLATFORM)
else
	cp $(BUILD_DIR)/$(EXECUTABLE_NAME) $(BUILD_DIR)/$(PROGRAM).exe
	cp -r $(BUILD_DIR)/$(PROGRAM).exe $(RELEASE_FILES) $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(PLATFORM)
endif
	chmod -R 777 $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(PLATFORM)
	cd $(BUILD_DIR) && zip -rq $(RELEASE_BASE_NAME)-$(VERSION)-$(PLATFORM).zip $(RELEASE_BASE_NAME)-$(VERSION)-$(PLATFORM)
	rm -rf $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(PLATFORM)

.PHONY: linux-i386-release
linux-i386-release: linux-i386
ifeq ($(strip $(LINUX_SPECIFIC_RELEASE_FILES)),)
	make release PLATFORM='$(LINUX_I386_RELEASE_NAME_SUFFIX)' EXECUTABLE_NAME='$(PROGRAM).i386'
else
	make release PLATFORM='$(LINUX_I386_RELEASE_NAME_SUFFIX)' RELEASE_FILES='$(LINUX_SPECIFIC_RELEASE_FILES) $(RELEASE_FILES)' EXECUTABLE_NAME='$(PROGRAM).i386'
endif

.PHONY: linux-x86_64-release
linux-x86_64-release: linux-x86_64
ifeq ($(strip $(LINUX_SPECIFIC_RELEASE_FILES)),)
	make release PLATFORM='$(LINUX_X86_64_RELEASE_NAME_SUFFIX)' EXECUTABLE_NAME='$(PROGRAM).x86_64'
else
	make release PLATFORM='$(LINUX_X86_64_RELEASE_NAME_SUFFIX)' RELEASE_FILES='$(LINUX_SPECIFIC_RELEASE_FILES) $(RELEASE_FILES)' EXECUTABLE_NAME='$(PROGRAM).x86_64'
endif

.PHONY: windows-i686-release
windows-i686-release: windows-i686
ifeq ($(strip $(WINDOWS_SPECIFIC_RELEASE_FILES)),)
	make release PLATFORM='$(WINDOWS_I686_RELEASE_NAME_SUFFIX)' EXECUTABLE_NAME='$(PROGRAM).i686.exe' WINDOWS_RELEASE=true
else
	make release PLATFORM='$(WINDOWS_I686_RELEASE_NAME_SUFFIX)' RELEASE_FILES='$(WINDOWS_SPECIFIC_RELEASE_FILES) $(RELEASE_FILES)' EXECUTABLE_NAME='$(PROGRAM).i686.exe' WINDOWS_RELEASE=true
endif

.PHONY: windows-x86_64-release
windows-x86_64-release: windows-x86_64
ifeq ($(strip $(WINDOWS_SPECIFIC_RELEASE_FILES)),)
	make release PLATFORM='$(WINDOWS_X86_64_RELEASE_NAME_SUFFIX)' EXECUTABLE_NAME='$(PROGRAM).x86_64.exe' WINDOWS_RELEASE=true
else
	make release PLATFORM='$(WINDOWS_X86_64_RELEASE_NAME_SUFFIX)' RELEASE_FILES='$(WINDOWS_SPECIFIC_RELEASE_FILES) $(RELEASE_FILES)' EXECUTABLE_NAME='$(PROGRAM).x86_64.exe' WINDOWS_RELEASE=true
endif

.PHONY: linux-i386-deb
linux-i386-deb: linux-i386
	rm -rf $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_I386_RELEASE_NAME_SUFFIX)
	mkdir -p $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_I386_RELEASE_NAME_SUFFIX)/usr/bin
	mkdir -p $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_I386_RELEASE_NAME_SUFFIX)/DEBIAN
	cp $(BUILD_DIR)/$(EXECUTABLE_NAME) $(BUILD_DIR)/$(PROGRAM)
	cp -r $(BUILD_DIR)/$(PROGRAM) $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_I386_RELEASE_NAME_SUFFIX)/usr/bin
	cp control-i386 $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_I386_RELEASE_NAME_SUFFIX)/DEBIAN/control
	dpkg-deb --build $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_I386_RELEASE_NAME_SUFFIX)
	rm -rf $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_I386_RELEASE_NAME_SUFFIX)

.PHONY: linux-x86_64-deb
linux-x86_64-deb: linux-x86_64
	rm -rf $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_X86_64_RELEASE_NAME_SUFFIX)
	mkdir -p $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_X86_64_RELEASE_NAME_SUFFIX)/usr/bin
	mkdir -p $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_X86_64_RELEASE_NAME_SUFFIX)/DEBIAN
	cp $(BUILD_DIR)/$(EXECUTABLE_NAME) $(BUILD_DIR)/$(PROGRAM)
	cp -r $(BUILD_DIR)/$(PROGRAM) $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_X86_64_RELEASE_NAME_SUFFIX)/usr/bin
	cp control-x86_64 $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_X86_64_RELEASE_NAME_SUFFIX)/DEBIAN/control
	dpkg-deb --build $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_X86_64_RELEASE_NAME_SUFFIX)
	rm -rf $(BUILD_DIR)/$(RELEASE_BASE_NAME)-$(VERSION)-$(LINUX_X86_64_RELEASE_NAME_SUFFIX)

.PHONY: all
all:
	make clean-build
	
	make linux-i386-release 
	make linux-i386-deb EXECUTABLE_NAME='$(PROGRAM).i386'
	
	make linux-x86_64-release 
	make linux-x86_64-deb EXECUTABLE_NAME='$(PROGRAM).x86_64'
	
	make windows-i686-release 
	make windows-x86_64-release
	
	make clean

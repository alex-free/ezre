Name:           ezre
Version:        1.0.3
Summary:        A simple and sane build system for Linux (i386 and x86_64) and Windows (i686 and x86_64) targets.
Release:        1%{?dist}
License:        3-BSD
URL:            https://github.com/alex-free/ezre
Packager:       Alex Free

%description
A simple and sane build system for Linux (i386 and x86_64) and Windows (i686 and x86_64) targets.

%install
mkdir -p %{buildroot}/usr/bin
mkdir -p %{buildroot}/usr/share/ezre
cp %{_sourcedir}/ezre %{buildroot}/usr/bin/
cp -r %{_sourcedir}/template-files/* %{buildroot}/usr/share/ezre

%files
/usr/bin/ezre
/usr/share/ezre

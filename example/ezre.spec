Name:           hello-world
Version:        1.0
Summary:        EzRe hello world example.
Release:        1%{?dist}
License:        3-BSD
URL:            https://github.com/alex-free/ezre
Packager:       Alex Free

%description
EzRe hello world example.

%install
mkdir -p %{buildroot}/usr/bin
cp %{_sourcedir}/hello %{buildroot}/usr/bin/

%files
/usr/bin/hello

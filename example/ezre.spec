Name: hello-world       
Version: 1.0
Summary: Hello world example using EzRe.
Release: 1
License: NOASSERTION
URL: https://github.com/alex-free/ezre       
Packager: Alex Free

%description
Hello world example using EzRe.

%install
mkdir -p %{buildroot}/usr/bin
cp %{_sourcedir}/hello %{buildroot}/usr/bin/

%files
/usr/bin/hello

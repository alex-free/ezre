Name: hello-world       
Version: v1.0
Summary: Hello world example for EzRe.
Release: 1
License: NOASSERTION
URL: https://github.com/alex-free/ezre       
Packager: Alex Free
Group: Unspecified

%description
Hello world example for EzRe.

%install
mkdir -p %{buildroot}/usr/bin
cp %{_sourcedir}/hello %{buildroot}/usr/bin/

%files
/usr/bin/hello

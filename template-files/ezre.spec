Name:       
Version:
Summary:
Release: 1
License:
URL:       
Packager:
Group: Unspecified

%description

%install
mkdir -p %{buildroot}/usr/bin
cp %{_sourcedir}/your_executable %{buildroot}/usr/bin/

%files
/usr/bin/your_executable

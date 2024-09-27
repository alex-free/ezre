Name:           your_program
Version:        1.0
Summary:        Your description.
Release:        1%{?dist}
License:        NOASSERTION
URL:            your_website
Packager:       your_name

%description
Your description.

%install
mkdir -p %{buildroot}/usr/bin
cp %{_sourcedir}/your_executable %{buildroot}/usr/bin/

%files
/usr/bin/your_executable

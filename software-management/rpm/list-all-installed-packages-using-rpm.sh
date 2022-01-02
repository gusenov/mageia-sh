rpm -qa --queryformat '(%{INSTALLTIME:date}): %{GROUP}/%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n'

```
$ ls -1 /etc/xdg/autostart/gnome-keyring*
/etc/xdg/autostart/gnome-keyring-pkcs11.desktop
/etc/xdg/autostart/gnome-keyring-secrets.desktop
/etc/xdg/autostart/gnome-keyring-ssh.desktop

$ cat /etc/pam.d/passwd | grep keyring
password   optional	pam_gnome_keyring.so use_authtok
```

# gdm

```
$ ls -1 /etc/pam.d/gdm*
/etc/pam.d/gdm-autologin
/etc/pam.d/gdm-fingerprint
/etc/pam.d/gdm-launch-environment
/etc/pam.d/gdm-password
/etc/pam.d/gdm-pin
/etc/pam.d/gdm-smartcard

$ cat /etc/pam.d/gdm-autologin  | grep keyring
-auth      optional    pam_gnome_keyring.so
session    optional    pam_gnome_keyring.so auto_start

$ cat /etc/pam.d/gdm-password  | grep keyring
auth        optional      pam_gnome_keyring.so
password   optional       pam_gnome_keyring.so use_authtok
session     optional      pam_gnome_keyring.so auto_start

$ cat /etc/pam.d/gdm-pin  | grep keyring
auth        optional      pam_gnome_keyring.so
session     optional      pam_gnome_keyring.so auto_start

$ cat /etc/pam.d/gdm-fingerprint  | grep keyring
$ cat /etc/pam.d/gdm-launch-environment  | grep keyring
$ cat /etc/pam.d/gdm-smartcard  | grep keyring
```

# lightdm

```
$ ls -1 /etc/pam.d/lightdm*
/etc/pam.d/lightdm
/etc/pam.d/lightdm-autologin
/etc/pam.d/lightdm-greeter

$ cat /etc/pam.d/lightdm  | grep keyring
-auth       optional    pam_gnome_keyring.so
-session    optional    pam_gnome_keyring.so auto_start

$ cat /etc/pam.d/lightdm-autologin  | grep keyring
$ cat /etc/pam.d/lightdm-greeter  | grep keyring
```


# refind-dreary - [My Custom Configs - FORKED]

## Quick Start

1. Clone this repository:
```sh
$   git clone https://github.com/jhwshin/refind-dreary.git
```

2. Run installation `install.sh` as `sudo`:
```sh
$   sudo ./refind-dreary.git/install.sh <RESOLUTION> <REFIND_DIR>
```

> __RESOLUTION:__
* `lowres`  - [32x32]
* `highres` - [64x64]

> __REFIND_DIR:__
* e.g - `/boot/efi/EFI/refind`

3. Add in custom configs and entry to `refind.conf`:
```sh
...


# Global Settings
timeout 10                          #   [-1, 0, 0+]
log_level 0                         #   [0-4]
enable_touch
#enable_mouse
dont_scan_volumes "Linux"           #   Prevent duplicate non-custom Linux entries using <LABEL>
default_selection +                 #   Microsoft, Arch, + (most recently boot)


# UI Settings
# hideui banner, label, singleuser, arrows, hints, editor, badges
hideui singleuser, hints, arrows, label, badges
# shell, memtest, mok_tool, hidden_tags, shutdown, reboot, firmware
showtools mok_tool, hidden_tags, reboot, shutdown, firmware


# OS Entry
menuentry "Arch" {
    icon            /EFI/refind/themes/refind-dreary/icons/<OS_ICON>.png
    volume          "<LABEL>"
    loader          /boot/vmlinuz-linux
    initrd          /boot/initramfs-linux.img
    options         "root=UUID=<UUID> initrd=boot\<CPU_MICROCODE>.img"
    add_options     "rw add_efi_memmap resume=UUID=<UUID> resume_offset=<RESUME_OFFSET>"

    submenuentry "Boot using Linux Fallback" {
        loader          /boot/vmlinuz-linux
        initrd          /boot/initramfs-linux-fallback.img
    }

    submenuentry "Boot to terminal" {
        add_options "systemd.unit=multi-user.target"
    }
}


# Apply the refind-dreary theme
include themes/refind-dreary/theme.conf
```

---

# refind-dreary - [ORIGINAL]
![screenshot](https://i.redditmedia.com/-LCobqYiQ4kLaLS3pmqPjcdnLa2MruQoINa3KDbKVzo.jpg?s=f4cd6834507dd0dfd046684745ab7954)

A gloomy rEFInd theme (as seen in [this Reddit thread](https://www.reddit.com/r/unixporn/comments/6370xc/i_present_to_you_refinddreary_a_gloomy_elegant/)) based on rEFInd-minimal and rEFInd-ambience, taking the best of both themes.

This is a fork with an added readme for a description, as well as instructions for how to install the theme.

### Author's description
    This theme is based on /u/Evan-Purkhiser's rEFInd-minimal, and /u/dyslexiccoder's refind-ambience.
    I just wanted to extend credit where credit is due, and thank you both for making those awesome themes.
    This one is not much more than a mashup of my favorite parts of each.

### Automatic installation instructions (Unix based OS only, like Mac and Linux)
<b>1.</b> Locate your rEFInd EFI directory. This is commonly <code>/boot/EFI/refind</code>, though it will depend on where you mount your ESP and where rEFInd is installed. <code>fdisk -l</code> and <code>mount</code> may help you find it.

<b>2.</b> Copy this repository on your system and execute the installation script(it takes the resolution and the rEFInd directory as arguments). For example you can:

<code>
    git clone https://github.com/dheishman/refind-dreary.git
    sudo ./refind-dreary/install.sh -resolution- -rEFInd_directory-
</code>

> Probably you will need to execute the installation script as root.

### Manual installation instructions
<b>1.</b> Locate your rEFInd EFI directory. This is commonly <code>/boot/EFI/refind</code>, though it will depend on where you mount your ESP and where rEFInd is installed. <code>fdisk -l</code> and <code>mount</code> may help you find it.

<b>2.</b> Create a folder called "themes" inside it, if it doesn't already exist.

<b>3.</b> Clone this repository somewhere temporarily, then copy the appropriate theme folder (highres, lowres, clover) into the rEFInd <code>themes</code> folder, renaming it to <code>refind-dreary</code>.

<b>4.</b> To enable the theme, add <code>include themes/refind-dreary/theme.conf</code> at the end of <code>refind.conf</code>.

Here's an example menuentry configuration:

    menuentry "Arch Linux" {
        icon /EFI/refind/themes/refind-dreary/icons/os_arch.png
        loader vmlinuz-linux
        initrd initramfs-linux.img
        options "rw root=UUID=dfb2919d-ff78-48db-a8a7-23f7542c343a loglevel=3"
    }

    menuentry "Windows" {
        icon /EFI/refind/themes/refind-dreary/icons/os_win.png
        loader /EFI/Microsoft/Boot/bootmgfw.efi
    }

    menuentry "OSX" {
        icon /EFI/refind/themes/refind-dreary/icons/os_mac.png
        loader /EFI/Apple/Boot/bootmgfw.efi
    }

    include themes/refind-dreary/theme.conf

Entries that are autodetected should also show the proper icons.

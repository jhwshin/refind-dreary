"${NVIDIA}" && NVIDIA_KERNEL_PARAMS="nvidia-drm.modeset=1 nvidia.NVreg_PreserveVideoMemoryAllocations=1"
# nvidia-drm.fbdev=1
# nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1
# nvidia.NVreg_UsePageAttributeTable=1
# nvidia.NVreg_TemporaryFilePath=/var/tmp

REFIND_CONFIG="
timeout 10                          #   [-1, 0, 0+] (skip, no timeout, x seconds)
log_level 0                         #   [0-4]
# enable_touch
# enable_mouse
# dont_scan_volumes ""
default_selection +                 #   Microsoft, Arch, + (most recently boot)
resolution max

# UI Settings
# hideui banner, label, singleuser, arrows, hints, editor, badges
hideui singleuser, hints, badges
# shell, memtest, mok_tool, hidden_tags, shutdown, reboot, firmware
showtools mok_tool, hidden_tags, reboot, shutdown, firmware

menuentry \"Arch Linux\" {
    icon                /EFI/refind/themes/refind-dreary/icons/os_arch.png
    volume              \"CRYPTROOT\"
    loader              /vmlinuz-linux
    initrd              /initramfs-linux.img

    # Splash screen kernel parameters - 'quiet', 'loglevel=3', 'systemd.log_level=debug'\

    options             \"rd.luks.name=${UUID}=crypt root=/dev/mapper/crypt rootflags=subvol=@ rw resume=UUID=${UUID} resume_offset=${RESUME_OFFSET} ${NVIDIA_KERNEL_PARAMS}\"

    # options           \"root=${UUID}=<UUID> rw resume=UUID=${UUID} resume_offset=${RESUME_OFFSET} ${NVIDIA_KERNEL_PARAMS}\"

    # add_options       \"rw add_efi_memmap\"

    submenuentry \"Linux Fallback\" {
        loader          /vmlinuz-linux
        initrd          /initramfs-linux-fallback.img
    }

    submenuentry \"Linux LTS\" {
        loader          /vmlinuz-linux-lts
        initrd          /initramfs-linux-lts.img
    }

    submenuentry \"Linux LTS Fallback\" {
        loader          /vmlinuz-linux-lts
        initrd          /initramfs-linux-lts-fallback.img
    }

    submenuentry \"Linux Zen\" {
        loader          /vmlinuz-linux-zen
        initrd          /initramfs-linux-zen.img
    }

    submenuentry \"Linux Zen Fallback\" {
        loader          /vmlinuz-linux-zen
        initrd          /initramfs-linux-zen-fallback.img
    }
    
    submenuentry \"Boot to Terminal\" {
        add_options \"systemd.unit=multi-user.target\"
    }
}
"
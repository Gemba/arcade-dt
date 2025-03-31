# Patch for any Amiberry from v5.7.1 Onwards

To be able to fully use Arcade DT with amiberry you have to apply this patch, as
long as [this issue](https://github.com/BlitterStudio/amiberry/issues/1493) is
not merged into the amiberry mainline and/or backported to amiberry-lite main.

## Steps for RetroPie Amiberry Builds

1. Transfer this patch to your RetroPie setup.
2. Logon to your RetroPie setup via SSH as user `pi`.
2. Then run these commands:
    ```bash
    cd RetroPie-Setup
    sudo ./retropie_packages.sh amiberry clean
    sudo ./retropie_packages.sh amiberry depends
    sudo ./retropie_packages.sh amiberry sources
    sudo cp <path-to>/amiberry-fix-*.patch tmp/build/amiberry/
    cd tmp/build/amiberry/
    sudo git apply amiberry-fix-gamepads-with-lt-15-buttons.patch
    cd -
    sudo ./retropie_packages.sh amiberry build
    sudo ./retropie_packages.sh amiberry install
    sudo ./retropie_packages.sh amiberry configure
    ```
4. That's it.

## Steps for Generic Amiberry Builds

1. Clone Amiberry and change into the `amiberry/`
2. Copy this patch into `amiberry/` and change into that directory
3. Run: `git apply amiberry-fix-gamepads-with-lt-15-buttons.patch`
4. Follow the Amiberry [source build
   instructions](https://github.com/BlitterStudio/amiberry/wiki/Compile-from-source)
   as usual
5. That's it.

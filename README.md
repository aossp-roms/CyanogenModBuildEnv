# Quick Start

To get up and running, install vagrant and then:

    git clone https://github.com/farproc/CyanogenModBuildEnv.git
    cd CyanogenModBuildEnv
    vagrant up

This will create you a VM with all the required packages installed to build CyanogenMod for yourself.

I personally just follow the steps on http://wiki.cyanogenmod.org/ to build for my devices.

Another neat trick so save you faffing around with USB forwarding etc. is to run a ''adb'' server on your host and forward that (over TCP) though to the VM. Its actually pretty simple.

On the VM

    adb kill-server # make sure the server isn't already running

Then on the host

    adb devices # you should see your device
    vagrant ssh -- -nNR127.0.0.1:5037:127.0.0.1:5037

Now back on the VM you should beable to exec ''adb'' commands :D

# Useful Links

* https://wiki.cyanogenmod.org/w/Build_for_d850
* https://wiki.cyanogenmod.org/w/Development
* https://wiki.cyanogenmod.org/w/Doc:_Building_Basics
* https://wiki.cyanogenmod.org/w/After_You_Build
* https://wiki.cyanogenmod.org/w/Doc:_porting_intro
* https://wiki.cyanogenmod.org/w/Doc:_using_virtual_machines 
* https://github.com/CyanogenMod?utf8=%E2%9C%93&query=G3
* http://code-chronicle.blogspot.com/2014/08/connect-usb-device-through-vagrant.html





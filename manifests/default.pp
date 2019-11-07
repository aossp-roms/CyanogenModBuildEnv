
class prep-android-build {
    Exec {
        path      => [
            '/usr/local/bin',
            '/opt/local/bin',
            '/usr/bin',
            '/usr/sbin',
            '/bin',
            '/sbin',
            ],
        logoutput => false,
    }

    exec { "apt-get update":
	    command => "/usr/bin/apt-get update",
    }

    Package {
        ensure  => present,
        require => Exec['apt-get update'],
    }

    package { "android-tools-adb": }
    package { "android-tools-fastboot": }
    package { "bc": }
    package { "bison": }
    package { "bsdmainutils": }
    package { "build-essential": }
    package { "curl": }
    package { "flex": }
    package { "gcc-multilib": }
    package { "g++-multilib": }
    package { "git": }
    package { "gnupg": }
    package { "gperf": }
    package { "lib32ncurses5-dev": }
    package { "lib32readline-gplv2-dev": }
    package { "lib32z1-dev": }
    package { "libesd0-dev": }
    package { "libncurses5-dev": }
    package { "libsdl1.2-dev": }
    package { "libwxgtk2.8-dev": }
    package { "libxml2": }
    package { "libxml2-utils": }
    package { "lzop": }
    package { "openjdk-6-jdk": }
    package { "openjdk-6-jre": }
    package { "pngcrush": }
    package { "schedtool": }
    package { "squashfs-tools": }
    package { "wget": }
    package { "xsltproc": }
    package { "zip": }
    package { "zlib1g-dev": }

    exec { 'install repo':
        cwd     => '/usr/local/bin/',
        command => 'bash -c "wget http://commondatastorage.googleapis.com/git-repo-downloads/repo && chmod a+x repo"',
        creates => '/usr/local/bin/repo',
        require => [ Package['wget'], Package['git'] ]
    }

    file { "/home/vagrant/.gitconfig" :
        source  => "/vagrant/gitconfig",
        owner   => 'vagrant',
        group   => 'vagrant'
    }

    # android SDK (only really needed if you're 'extracting' the proprietary blobs directly from the device
    exec { 'download and install android sdk':
        user    => 'vagrant',
        cwd     => '/home/vagrant',
        command => 'bash -c "mkdir -p sdk && cd sdk && wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20131030.zip && unzip adt-bundle-linux-x86_64-20131030.zip"',
        timeout => 600,
        creates => '/home/vagrant/sdk/adt-bundle-linux-x86_64-20131030/sdk/platform-tools/adb',
        require => [ Package['zip'], Package['wget'] ],
    }

    exec { 'update path':
        user    => 'vagrant',
        cwd     => '/home/vagrant',
        command => 'bash -c "echo export PATH=\"\${PATH}:~/sdk/adt-bundle-linux-x86_64-20131030/sdk/platform-tools\" >> .bashrc"',
    }

    # repo init/sync:
    # repo init -u git://github.com/CyanogenMod/android.git -b cm-11.0
    # repo sync

    # get prebuilt
    # cd ~/android/system/vendor/cm
    # ./get-prebuilts

}

include prep-android-build

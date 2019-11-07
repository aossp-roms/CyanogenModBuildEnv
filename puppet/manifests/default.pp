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
        require => Exec['apt-get update']
    }

    package { "build-essential": }
    package { "git-core": }
    package { "curl": }
    package { "wget": }
    package { "gnupg": }
    package { "flex": }
    package { "bison": }
    package { "gperf": }
    package { "libsdl1.2-dev": }
    package { "libesd0-dev": }
    package { "libwxgtk2.8-dev": }
    package { "squashfs-tools": }
    package { "zip": }
    package { "libncurses5-dev": }
    package { "zlib1g-dev": }
    package { "openjdk-7-jre": }
    package { "openjdk-7-jdk": }
    package { "pngcrush": }
    package { "schedtool": }
    package { "libxml2": }
    package { "xsltproc": }
    package { "g++-multilib": }
    package { "lib32z1-dev": }
    package { "lib32ncurses5-dev": }
    package { "lib32readline-gplv2-dev": }
    package { "gcc-4.6-multilib": } # would ideally like 4.7
    package { "g++-4.5-multilib": }
    package { "libxml2-utils": }

    exec { 'install repo':
        cwd     => '/usr/local/bin/',
        command => 'bash -c "wget http://commondatastorage.googleapis.com/git-repo-downloads/repo && chmod a+x repo"',
        creates => '/usr/local/bin/repo',
        require => [ Package['wget'], Package['git-core'] ],
    }

    # android SDK (only really needed if you're 'extracting' the proprietary blobs directly from the device
    exec { 'download and install android sdk':
        user    => 'vagrant',
        cwd     => '/home/vagrant',
        command => 'bash -c "mkdir -p sdk && cd sdk && wget https://dl.google.com/android/adt/adt-bundle-linux-x86-20140702.zip && unzip adt-bundle-linux-x86-20140702.zip"',
        timeout => 600,
        creates => '/home/vagrant/sdk/adt-bundle-linux-x86_64-20131030/sdk/platform-tools/adb',
        require => [ Package['zip'], Package['wget'] ],
    }

    exec { 'update path':
        user    => 'vagrant',
        cwd     => '/home/vagrant',
        command => 'bash -c "echo export PATH=\"\${PATH}:~/sdk/adt-bundle-linux-x86_64-20140702/sdk/platform-tools\" >> .bashrc"',
    }

    exec { 'chown':
        command => '/bin/chown -R vagrant:vagrant /media/cyanogenmod/',
        path => '/bin',
        user => 'root'
    }

    # cd /media/cyanogenmod

    # repo init/sync:
    # repo init -u git://github.com/CyanogenMod/android.git -b cm-11.0
    # repo sync

    # get prebuilt
    # ./vendor/cm/get-prebuilts

}

include prep-android-build


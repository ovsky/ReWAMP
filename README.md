

# ![logo](./icon/icon_small.png) REWAMP

  

> Zero install WAMP built with Golang.

[Latest REWAMP releases](https://github.com/ovsky/REWAMP/releases)

  
  

The goal of REWAMP is to provide a simple executable to run web developments tools with one click. It's packed with Apache / MySQL / PHP / Mongo and administration tools pre-configured.

  

Based on abandoned XWAMP project, which was heavily inspired by the also defunct ZWAMP.

  
  

![screenshot](./screenshot.png)

  

## Getting started

  

Grab the latest release [here](https://github.com/romualdr/rewamp/releases), unzip and run the file `rewamp.exe`.


## Building REWAMP
### Easy way:

Include the precompiled [2goarray](https://github.com/cratonica/2goarray) package binary in Golang default directory (`%gopath%/bin`). 
The simplest way to do it is installation from source by command line:

    go install github.com/cratonica/2goarray@latest

If you run into any problems, you can clone the repository and compile it on your own and then copy the `2goarray.exe` binary to the directory metioned above.

Now you can build the project using automatic `build_initialize.bat` or follow the next steps and use `build.bat`. Script will pack the project into `rewamp.exe` binary.

### Complex way:
Follow the easy way step, and then:

#### Make package reference list:
Now open the command line at project directory, and type:

    go mod init rewamp
    go mod tidy
    
First command will create  `go.mod` file (that defines the references for all required packages), the next one will find all the needed packages and put them into this list.

If you want, you can upgrade dependencies to the latest packages, using standard: `go get -u all` command, or recursive way: `go get -u ./...`.  This will update the `go.mod` file and now it will include latest available versions of the packages. 

Now you can build the project using `build.bat` file, or by raw command: `go build -ldflags="-H windowsgui"`. It will pack the project into `rewamp.exe` binary. 

 #### Installing packages:
To install all required packages, you can simply invoke the global command: `go install` - that will install the packages defined in `go.mod` globally or in-repository command: `go get`, that will put these packages especially into your current project. 

If by some reason, you want to install the packages that are necessary for REWAMP by yourself you can type:

    go get golang.org/x/sys/windows
    go get github.com/lxn/win
    go get github.com/mitchellh/go-ps
    go get github.com/getlantern/systray
    go get github.com/sqweek/dialog
    
 

## Where do i put my code?

  

You can add your PHP files or your web application in the `vdrive\web` folder.

  

## Tools and versions

  
[Apache 2.4.41](http://httpd.apache.org/)

  
[MySQL 8.0.18](https://www.mysql.com/fr/products/community/) (username: root / password: password)

  
[MongoDB 4.2.1](https://www.mongodb.com/what-is-mongodb)
  

[PHP 7.4.0](https://www.php.net/) with extensions:
- [Pear 2](https://pear2.php.net/)
- [APCu 5.1.18](https://pecl.php.net/package/APCu)
- [GeoIP 1.1.1](https://pecl.php.net/package/geoip)
- [YAML 2.0.1](https://pecl.php.net/package/yaml)
- [MongoDB 1.6.1](https://pecl.php.net/package/mongodb)
- curl, gd2, openssl, pdo_mysql, pdo_sqlite, sqlite3, tidy, xmlrpc, opcache, mbstring

  

[Memcached 1.5.20](http://memcached.org/)

[MemCache Admin by kn007](https://github.com/kn007/memcache.php)

[Adminer 4.7.5](https://www.adminer.org/)

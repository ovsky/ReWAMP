

# ![logo](./icon/icon_small.png) XWAMP

  

> Zero install WAMP built with Golang.

[Download 0.1.0 now](https://github.com/romualdr/xwamp/releases/download/v0.1.0-alpha/xwamp-0.1.0-alpha.zip)

  
  

The goal of XWAMP is to provide a simple executable to run web developments tools with one click. It's packed with Apache / MySQL / PHP / Mongo and administration tools pre-configured.

  

Heavily inspired by the now defunct ZWAMP.

  
  

![screenshot](./screenshot.png)

  

## Getting started

  

Grab the latest release [here](https://github.com/romualdr/xwamp/releases), unzip and run the file `xwamp.exe`.


## How to Build XWAMP
### Building from XWAMP base repository.

> At first, we need to adapt the XWAMP to actual state of Golang language.
The last XWAMP commit was made in 2019, so the project includes many outdated solutions and references. This instruction was written in the Q4 2022, references Golang 1.19, and will be updated. 
 
####  Fix outdated solutions:
At first, replace every: `github.com/romualdr/systray` in project, by: `github.com/getlantern/systray`, to use the correct package path.

In `main.go` you need to fix the reference of the local `icon` package, by replacing deprecated includement: `"./icon"` by the modern way `"xwamp/icon"`. The `xwamp` here is defined by the name of your module, you can find and change it in `go.mod` file. 

Now, include the precompiled [2goarray](https://github.com/cratonica/2goarray) package binary in Golang default directory (`%gopath%/bin`). 
The simplest way to do it is invocation installation from source by command line:
`go install github.com/cratonica/2goarray@latest`

If you run into any problems, you can clone the repository and compile it on your own and then copy the `2goarray.exe` binary to the directory metioned above.
 
 #### Make package reference list:
Now open the command line at project directory, and type:
`go mod tidy`
    
This command will find all the packages used in project and create  `go.mod` file, that defines the references for all required packages.

If you want, you can upgrade dependencies to the latest packages, using standard: `go get -u all` command, or recursive way: `go get -u ./...`.  This will regenerate the `go.mod` file and now it will include latest available versions of the packages. 

 #### Installing packages:
To install all required packages, you can simply invoke the global command: `go install` - that will install the packages defined in `go.mod` globally or in-repository command: `go get`, that will put these packages especially into your current project. 

If, by some reason, you want to install the packages that are necessary for XWAMP by yourself, you can type:

    go get golang.org/x/sys/windows
    go get github.com/lxn/win
    go get github.com/mitchellh/go-ps
    go get github.com/romualdr/systray
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

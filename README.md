# mongo

mongodb3 cookbook uses the package installation of mongodb3 such as yum or apt. and these attributes are used for setting default values in order to provide the correct installation of mongodb3. typically, you can modify cookbook attributes if you need. however, I do not recommend to modify these attributes if you want to use package that is provided from MongoDB.

## Cookbook version

This cookbook installs Mongo version 3.2.19.

## Usage

Install the correct version of chef at https://downloads.chef.io/chef-server.

Run the following commands in your terminal

```bash
kitchen create
kitchen converge
```

To verify the installation ran correctly, run ```kitchen verify```

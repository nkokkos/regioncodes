Regioncodes
======

What this gem currenly does:

It inserts a table/model into your application called "regioncodes" and
provides class methods to retrieve geographical regions, municipalities
,towns. communes  within your controller.

It also provides tasks for inserting/migrating the table and importing 
the region data from the data folder.

Regioncodes depends on fastercsv plugin (you need it in order to parse
the csv file in data folder)


Example
=======

How to install this plugin within your Ruby on Rails application:


> ruby script/plugin install git://github.com/nkokkos/regioncodes.git



How to create/migrate the regioncodes table:

At the root of your application do :

> rake db:migrate:regioncodes


How to insert the data (about 20,000+ records) into the table 
(it will take some time (15 mins) depending on the version of ruby you have. Ruby version 1.9 should be fast): 

> rake regioncodes:insertdata


If you want to test the insertdata task, go to the tasks folder and modify the
task command, in order to import a different smaller file from the 
data folder (e.g test_data_csv)


How to unistall this plugin:
At the root of your rails app do:

> rake db:migrate:regioncodes version=0
(this will delete the regioncodes table)

and then manually delete the plugin from the vendor folder


Demo
=====

There is a demo application that uses this plugin at 

> http://github.com/nkokkos/demo_app_for_regioncodes_plugin


Copyright (c) 2010 [Nick Kokkos], released under the MIT license

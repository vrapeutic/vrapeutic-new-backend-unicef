# README

# [Project Doc](https://github.com/vrapeutic/vrapeutic-new-backend-unicef/blob/main/docs/README.md)

# Setup The App Locally

### First, you will need to install ruby and rails on you local machine

- install ruby with version 3.0.6
- install rails with version 7.0.7

## Install the gems

- Any rails project has many dependencies called `gems` these gems are typically packages that you use in your project, and you must run this command to download them in your machine
  > `bundle install`

As you can see here rails uses the _bundler_ as a package manager

To add more gems to you project you can define it in the `Gemfile` file and then install them by `bundle install`

## Setup the database

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04

- This project os configured to run on Postgres in the development the production (check the `config/database.yml` file if you need to change that)
  so make sure you installed the db server that you need
- Check the development section in the `config/database.yml` file to know/change the db `user/password` that the app needs to connect to the db
- After preparing the db `user/password` with the needed privileges, you can now create the development database your self or by running the command
  > `rails db:create`
- After creating the development db you can now run the migrations to create all tables for our models
  > `rails db:migrate`

To insert the initial data defined in the `db/seed.rb` file just run this command

> `rails db:seed`

**NOTE**: Whenever you need to modify the db you have to do so through a migration

Check the rails generator here to know more commands about creating models,controllers, migrations and much more
https://guides.rubyonrails.org/command_line.html#bin-rails-generate

## Running the app locally

If everything above went well you can now run the app server locally using the command

> `rails server` or simply `rails s`

this will run that app locally on the `localhost:3000` by default

If you need to test anything related to the models such as insert/update/select/delete records you can use the rails console

> `rails c`

# deployment

## we use elastic beanstalk to deploy and you have to install cli to make deployment easy

### to install elastic beanstalk cli , follow these steps

- https://github.com/aws/aws-elastic-beanstalk-cli-setup ---> to install elastic beanstalk cli
- get security credentials
- do (`eb init`) inside rails project & choose existing app in eu-west-1 (Ireland)
- provide your _access key_ and _secret key_ to the EB CLI
- when you want to deploy you can type `eb deploy`

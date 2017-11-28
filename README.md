#### Developer Installation

##  I. Clone the git repository:
```
git clone https://github.com/edurange/edurange-refactor.git
```

##  II. Install RVM (Ruby Version Manager), rails, rubygems, and bundler

  Note: If you have Ruby installed through your package manager, it might conflict with this installation. If necessary perge it first.
```
sudo apt-get remove --purge ruby
```

  Follow this guide to install RVM: (https://rvm.io/rvm/install#installation). Single-user instructions recommended.
  This project uses Ruby 2.3.1 so use RVM to install and select the correct version of Ruby:
```
rvm install [ruby version number eg 2.3.1]  - rvm install 2.3.1
rvm use [ruby version number eg 2.3.1]      - rvm use 2.3.1
```

You may have to do something like: `bin/bash --login` in order to set the RVM ruby version (which doens't refer to the system ruby version).

Also, install bundler (to take care of gem dependencies) and the rails framework:
```
gem install bundler
```
In the edurange-server directory, yank and update all the gem dependencies:
```
bundle update
bundle install
```



##  III. Database and User setup

Edit the file "config/secrets.yml". Under 'development:' edit the "admin\_name", "admin\_email" and "admin\_password" fields. These are the default user settings. Avoid using any spaces in those fields.

Now run ```rake db:setup```. This will create the database and admin account.

##  IV. Run the server
  
Now bootup the developement server:
```
rails server
```
If you get a ruby version error, you might need to type 'rvm 2.3.1 [or current ruby version in Gemfile]'.
Point your web browser to localhost:3000


After you pull changes from the github repository, if the database was changed you'll need to rake the database:
```
rake db:migrate
```

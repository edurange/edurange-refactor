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

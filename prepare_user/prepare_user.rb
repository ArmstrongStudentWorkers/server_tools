#!/usr/bin/env ruby
# encoding: utf-8

user = ARGV[0]

# Add a user
`useradd -m #{user}`
puts "User #{user} created."

# Change user password
puts "Create a temporary password for #{user}."
`passwd #{user}`

# Change user shell
`chsh -s /bin/zsh #{user}`
puts 'Shell set to zsh.'

# Install Oh My Zsh
`git clone git://github.com/robbyrussell/oh-my-zsh.git /home/#{user}/.oh-my-zsh`
`cp /home/#{user}/.oh-my-zsh/templates/zshrc.zsh-template /home/#{user}/.zshrc`
puts 'Installed Oh My Zsh.'

# Install rbenv
`git clone https://github.com/sstephenson/rbenv.git /home/#{user}/.rbenv`
`echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/#{user}/.zshrc`
`echo 'eval "$(rbenv init -)"' >> /home/#{user}/.zshrc`
puts 'Installed rbenv for Ruby version control'

# Install ruby-build as a rbenv plugin
`git clone https://github.com/sstephenson/ruby-build.git /home/#{user}/.rbenv/plugins/ruby-build`
puts 'Installed ruby-build.'

# Install vim
`git clone --recursive https://github.com/ATNI/vimpire.git /home/#{user}/.vim`
`cp /home/#{user}/.vim/etc/vimrc /home/#{user}/.vimrc`
puts 'Installed vimpire, a suite of vim plugins and settings.'

# Create projects directory
`mkdir /home/#{user}/projects`
puts 'Created projects directory'

# Changing owner from root to user
`chown -R #{user}:#{user} /home/#{user}`
puts 'Changed owner and group of user files.'

# Install ruby
`sudo -u #{user} -i /home/#{user}/.rbenv/bin/rbenv install 1.9.3-p484`
puts 'Installed Ruby version 1.9.3-p484'

# Set global ruby version in rbenv
`sudo -u #{user} -i /home/#{user}/.rbenv/bin/rbenv global 1.9.3-p484`

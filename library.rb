require 'yaml'
require './books_list.rb'

class Library
  def initialize()
    @config = YAML.load(File.read('./settings.yml'))
    @users = File.readlines(@config['registered_users'], mode:"a+", chomp: true)

    @user = user_login
    @books_list = Books_list.new(@config['books_list'])

    user_loop
  end

  def user_loop
    while true
      puts "Choose your action:"
      puts "[L]ist available books"
      puts "[B]orrow a book (not implemented)"
      puts "[R]eturn a book (not implemented)"
      puts "[E]xit (not implemented)"

      input = gets.chomp.downcase

      case input
      when "l"
        @books_list.list_books
      else
        puts "Goodbye!"
        break
      end
    end
  end

  def user_login
    username = nil

    while username == nil
      puts "Enter your username: "
      input = gets.chomp

      username = input if validate_user? input
    end

    puts "Welcome, #{username}!"
    return username
  end

  def user_register(name)
    File.write(@config['registered_users'], name + "\n", mode: 'a+')
    puts "Succesfully registered #{name}!"
  end

  def validate_user?(name)
    if name == ""
      puts "Username cannot be blank!"
      return false
    end

    if !(@users.include? name)
      puts "User not found! Repeat your username to register it! (press enter to try again)"
      name_confirm = gets.chomp

      if name == name_confirm
        user_register name
        return true
      end
      return false
    end

    return true
  end
end

library = Library.new
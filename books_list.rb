require 'csv'

class Books_list
  def initialize(file_path) # Is it better to pass file_path (saved in settings.yml) or just import it here?
    @books_list = read_books file_path
  end

  def read_books(file_path)
    books_by_id = {}

    books = CSV.read file_path
    books.shift
    books.each {
      |book|
      books_by_id[book[0]] = {
        "name" => book[1],
        "author" => book[2],
        "year" => book[3]
      }
    }

    return books_by_id
  end

  def list_books
    @books_list.each {
      |key, value|
      puts "#{key}:
    Name: #{value["name"]}
    Author: #{value["author"]}
    Year: #{value["year"]}"
    }
  end
end
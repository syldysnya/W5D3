require 'sqlite3'
require 'singleton'

class QuestionsDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question

    def self.find_by_id(id)
        # raise "#{id} not found in DB" unless self.id
        question = QuestionsDBConnection.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL

    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @associated_other = options['associated_author']
    end
end
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

    attr_accessor :id, :title, :body, :associated_author

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

class Reply
    
    def self.find_by_user_id(author_id)
        reply = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
        SELECT
            *
        FROM
            replies
        WHERE
            author_id = ?
        SQL
    end
    
    def self.find_by_question_id(question_id)
        question = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            replies
        WHERE
            question_id = ?
        SQL
    end

    attr_accessor :id, :question_id, :author_id, :body, :parent_id

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @author_id = options['author_id']
        @body = options['body']
        @parent_id = options['parent_id']
    end
end

class User

    attr_accessor :id, :fname, :lname

    def initialize(options)
         @id = options['id']
         @fname = options['fname']
         @lname = options['lname']
    end

    # def self.find_by_name(fname, lname)
end
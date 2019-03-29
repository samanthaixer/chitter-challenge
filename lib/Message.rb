class Message
  attr_reader :text
  def initialize(id:, text:, date:, user_id:)
    @id = id
    @text = text
    @date = date
    @user_id = user_id
  end

  def self.create(text:, user_id: 1)
    results = DatabaseConnection.query("INSERT INTO messages (text, user_id) VALUES ('#{text}', '#{user_id}') RETURNING id, text, date, user_id;")
    Message.new(id: results[0]['id'], text: results[0]['text'], date: results[0]['date'], user_id: results[0]['user_id'])
  end

  def self.all
    results = DatabaseConnection.query("SELECT * FROM messages;")
    results.map { |message| Message.new(id: message['id'], text: message['text'], date: message['date'], user_id: message['user_id']) }
  end
end
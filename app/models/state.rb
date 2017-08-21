class State < ActiveRecord::Base
  # should I set a class variable @@default and update it
  # each time make_default is called to get a better performance?
  def self.default
    find_by(default: true)
  end

  def to_s
    name
  end

  def make_default!
    State.update_all(default: false)
    update!(default: true)
  end
end

class Song < ActiveRecord::Base
  belongs_to :artist

  def name=(new_name)
    self[:name]            = new_name
    self[:normalized_name] = normalize(name)
  end

  def normalized_name=
    raise "Just set the name dude"
  end

  private

  def normalize(name_string)
    name_string.gsub(/[^a-zA-Z0-9 ]/,"").downcase
  end
end

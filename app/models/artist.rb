class Artist < ActiveRecord::Base
  has_many :songs

  def self.find_or_create(name)
    find_by_normalized_name(normalize(name)) || create(:name => name)
  end

  def name=(new_name)
    self[:name]            = new_name
    self[:normalized_name] = normalized_name
  end

  def normalized_name
    self.class.normalize(name)
  end

  def normalized_name=
    raise "Just set the name dude"
  end

  private

  def self.normalize(name_string)
    name_string.gsub(/[^a-zA-Z0-9 ]/,"").downcase
  end
end

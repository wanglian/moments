class Note < ApplicationRecord
  has_rich_text :content
  belongs_to :user

  validates_presence_of :content
end

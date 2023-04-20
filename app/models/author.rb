class Author < ApplicationRecord
    has_many :books

    validates :name, presence: true, uniqueness: true
    validates :birthday, presence: true
    validates :main_genre, presence: true
end

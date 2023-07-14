class Category < ApplicationRecord
  enum parent: { emotion: 0, genre: 1, year: 2 }
end

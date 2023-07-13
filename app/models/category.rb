class Category < ApplicationRecord
  enum variety: { emotion: 0, genre: 1, year: 2 }
end

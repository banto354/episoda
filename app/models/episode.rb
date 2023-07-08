class Episode < ApplicationRecord
  
  belongs_to :user
  
  enum visibility: { to_public: 0, to_group: 1, to_myself: 2 }
  
end

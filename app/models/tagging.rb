class Tagging < ApplicationRecord
  belongs_to :user, dependents: :destroy
  belongs_to :tag, dependents: :destroy
end

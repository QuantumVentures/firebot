class ModelComposition < ActiveRecord::Base
  belongs_to :composition
  belongs_to :model
end

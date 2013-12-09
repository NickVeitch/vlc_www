module Refinery
  module AddPages
    class AddPage < Refinery::Core::BaseModel
      self.table_name = 'refinery_add_pages'

      attr_accessible :name, :description, :position

      acts_as_indexed :fields => [:name, :description]

      validates :name, :presence => true, :uniqueness => true
    end
  end
end

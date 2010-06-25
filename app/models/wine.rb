class Wine < ActiveRecord::Base
  belongs_to :grape_variety
  insta_search do |insta|
  end
end

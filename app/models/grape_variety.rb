class GrapeVariety < ActiveRecord::Base
  insta_search do |insta|
  end
  insta_export do |insta|
  end
  
  def to_s
    name
  end
end

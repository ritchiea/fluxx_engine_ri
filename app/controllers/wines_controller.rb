class WinesController < ApplicationController
  insta_index Wine do |insta|
    insta.template = 'wine_list'
  end
  insta_show Wine do |insta|
    insta.template = 'wine_show'
  end
  insta_new Wine do |insta|
    insta.template = 'wine_form'
  end
  insta_edit Wine do |insta|
    insta.template = 'wine_form'
  end
  insta_post Wine do |insta|
    insta.template = 'wine_form'
  end
  insta_put Wine do |insta|
    insta.template = 'wine_form'
  end
  insta_delete Wine do |insta|
    insta.template = 'wine_form'
  end
  insta_related Wine do |insta|
    insta.add_related do |related|
      related.display_name = 'Grapes'
      related.related_class = GrapeVariety
      related.search_id = :grape_variety
      related.extra_condition = nil
      related.max_results = 20
      related.order = 'name asc'
      #related.display_template = 'template'
      related.display_fields = [:name]
    end
  end  
end

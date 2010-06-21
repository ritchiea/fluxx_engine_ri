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
  
end

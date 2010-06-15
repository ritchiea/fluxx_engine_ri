class WinesController < ApplicationController
  insta_index Wine, :template => 'wine_list'
  insta_show Wine, :template => 'wine_show'
  insta_new Wine, :template => 'wine_form'
  insta_edit Wine, :template => 'wine_form'
  insta_post Wine, :template => 'wine_form'
  insta_put Wine, :template => 'wine_form'
  insta_delete Wine
  
end

class WinesController < ApplicationController
  VIEW_ATTRS = 
  [
    { :class => 'fluxx-card-listing-entry-line1', :type => 'span',
      :fields => [:name]
    },
  ]
  
  insta_index Wine, :view_attrs => VIEW_ATTRS
end

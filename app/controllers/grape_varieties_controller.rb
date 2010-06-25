class GrapeVarietiesController < ApplicationController
  insta_index GrapeVariety do |insta|
    insta.template = 'grape_variety_list'
  end
  insta_show GrapeVariety do |insta|
    insta.template = 'grape_variety_show'
  end
  insta_new GrapeVariety do |insta|
    insta.template = 'grape_variety_form'
  end
  insta_edit GrapeVariety do |insta|
    insta.template = 'grape_variety_form'
  end
  insta_post GrapeVariety  do |insta|
    insta.template = 'grape_variety_form'
  end
  insta_put GrapeVariety do |insta|
    insta.template = 'grape_variety_form'
  end
  insta_delete GrapeVariety do |insta|
    insta.template = 'grape_variety_form'
  end
end

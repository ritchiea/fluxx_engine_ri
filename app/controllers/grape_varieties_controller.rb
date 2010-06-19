class GrapeVarietiesController < ApplicationController
  insta_index GrapeVariety, :template => 'grape_variety_list'
  insta_show GrapeVariety, :template => 'grape_variety_show'
  insta_new GrapeVariety, :template => 'grape_variety_form'
  insta_edit GrapeVariety, :template => 'grape_variety_form'
  insta_post GrapeVariety, :template => 'grape_variety_form'
  insta_put GrapeVariety, :template => 'grape_variety_form'
  insta_delete GrapeVariety
end

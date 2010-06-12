class Wine < ActiveRecord::Base
  # TODO ESH: remove after done testing
  def self.model_search request_params, results_per_page=25, options={}, really_delete=false
    Wine.paginate :page => request_params[:page]
    
  end
end

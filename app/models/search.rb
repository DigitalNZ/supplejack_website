class Search < Supplejack::Search
  def initialize(params = {})
    params = params.dup
    params[:i] ||= {}
    params[:or] ||= {}
    self.and ||= {}
    self.or ||= {}

    super(params)

    params = params.to_unsafe_hash if params.is_a? ActionController::Parameters
    self.or.merge!(params[:or])
  end
end

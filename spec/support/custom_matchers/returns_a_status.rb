# frozen_string_literal: true

module CustomMatchers
  HTTP_METHODS = %w[get put post delete].freeze

  class ReturnsAStatus
    def initialize(http_method, action, params, expected_status, cause)
      @http_method = http_method
      @action = action
      @params = params
      @expected_status = expected_status
      @cause = cause
    end

    def matches?(controller_test)
      @controller_test = controller_test
      @response_status = @controller_test.send(@http_method, @action, @params).status
      @expected_status == @response_status
    end

    def failure_message
      "expected #{@http_method.upcase}##{@action} with #{@params} to return #{@expected_status}, was #{@response_status},when #{@cause}"
    end

    def description
      description = "return #{@expected_status} for #{@http_method.upcase}##{@action} "
      if @cause.present?
        description << "when #{@cause}"
      else
        description
      end
    end
  end

  # dynamically generate helperfunctions, e.g return_400_for_get(:action, params)
  [200, 201, 302, 400, 401, 403, 404, 409].each do |status_code|
    HTTP_METHODS.each do |http_method|
      method = "return_#{status_code}_for_#{http_method}".to_sym
      define_method(method) do |action, params, cause|
        ReturnsAStatus.new(http_method, action, params, status_code, cause)
      end
    end
  end
end

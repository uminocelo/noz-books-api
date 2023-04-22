# frozen_string_literal: true

require_relative '../../../test_helper'
require 'rspec/mocks'

class Api::V1::AuthorsControllerDestroyTest < ActionDispatch::IntegrationTest
  setup do
    @author = FactoryBot.create(:author)
  end

  test 'should delete author and return 204 response' do
    assert_difference('Author.count', -1) do
      delete api_v1_author_path(id: @author.id)
    end
    assert_response :no_content
  end

  test 'should return not found error when author does not exist' do
    assert_no_difference('Author.count') do
      delete api_v1_author_path(id: 999)
    end

    assert_response :not_found
  end
end

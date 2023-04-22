# frozen_string_literal: true

require_relative '../../../test_helper'

class Api::V1::AuthorsControllerIndexTest < ActionDispatch::IntegrationTest
  setup do
    Book.destroy_all
    Author.destroy_all
  end

  test 'should return success and list of authors' do
    FactoryBot.create_list(:author, 3)

    get api_v1_authors_path

    assert_response :success
    assert_equal 3, JSON.parse(response.body).size
  end

  test 'should return success and empty list when no authors exist' do
    get api_v1_authors_path

    assert_response :success
    assert_empty JSON.parse(response.body)
  end
end

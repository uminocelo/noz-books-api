require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  setup do
    @author = authors(:one)
  end

  test 'should not save author without name' do
    author = Author.new
    assert_not author.save, 'Saved author without name'
  end

  test 'should not save author with short name' do
    author = Author.new(name: 'a')
    assert_not author.save, 'Saved author with short name'
  end

  test 'should not save author with long name' do
    author = Author.new(name: 'a' * 51)
    assert_not author.save, 'Saved author with long name'
  end

  test 'should save author with valid attributes' do
    author = Author.new(name: 'J.K. Rowling', birthday: Date.new(1965, 7, 31), main_genre: 'Fantasy')
    assert author.save, 'Could not save author with valid attributes'
  end
end

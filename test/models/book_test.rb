require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    @author = authors(:one)
    @book = Book.new(
      title: 'The Lord of the Rings',
      description: 'An epic high-fantasy novel',
      genre: 'Fantasy',
      publication_date: '1954-07-29',
      publisher: 'George Allen & Unwin',
      author_id: @author
    )
  end

  test 'should not save book without title' do
    @book.title = nil
    assert_not @book.save, 'Saved the book without a title'
  end

  test 'should not save book with title length less than 2' do
    @book.title = 'a'
    assert_not @book.save, 'Saved the book with title length less than 2'
  end

  test 'should not save book without genre' do
    @book.genre = nil
    assert_not @book.save, 'Saved the book without a genre'
  end

  test 'should not save book with invalid genre' do
    @book.genre = 'invalid'
    assert_not @book.save, 'Saved the book with an invalid genre'
  end

  test 'should not save book without publication date' do
    @book.publication_date = nil
    assert_not @book.save, 'Saved the book without a publication date'
  end

  test 'should not save book with publication date in the future' do
    @book.publication_date = Date.today + 1.day
    assert_not @book.save, 'Saved the book with publication date in the future'
  end

  test 'should save book with valid attributes' do
    assert @book.save, 'Could not save book with valid attributes'
  end

  test 'should have a description' do
    assert_not_nil @book.description, 'Book should have a description'
  end

  test 'should belong to an author' do
    assert_equal @book.author_id, authors(:one).id, 'Book should belong to author'
  end
end

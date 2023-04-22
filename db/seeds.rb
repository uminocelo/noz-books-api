author = FactoryBot.create(:author)
book = FactoryBot.build(:book, author: author)
author.save
book.save

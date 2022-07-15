library(dplyr)
library(ggplot2)
books_data = read.csv("GoodReads_100k_books.csv")
successful_books <- filter(books_data, totalratings>10000)
successful_books <- mutate(successful_books, totalRatingsAndReviews = totalratings + reviews)
successful_books <- mutate(successful_books, words = pages * 300)
View(successful_books)
successful_books %>% group_by(author) %>% filter( n() > 1 )
multi_book_authors = arrange(successful_books, desc(author))
multi_book_authors %>% 
  group_by(author) %>% 
  summarize(mean = mean(rating),
            sum = sum(totalratings))

 
  #label(title = 'Book Format vs Popularity', x = 'Book Format', y = 'Total Ratings and Reviews on Goodreads')

ggplot(data= multi_book_authors, aes(x=bookformat, y=totalRatingsAndReviews))+
    geom_bar(stat="summary",fill="lightblue")+
    theme_dark()

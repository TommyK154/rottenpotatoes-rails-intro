class Movie < ActiveRecord::Base
    #@all_ratings = ['G', 'PG', 'PG-13', 'R']
    def self.all_ratings 
        ['G', 'PG', 'PG-13', 'R']
    end
    
    def self.sort_by_and_rating(sort, rating)
        case sort
            when nil
                Movie.where('rating IN (?)', rating)
            when 'title' then
                Movie.where('rating IN (?)', rating).order('title')
            when 'release_date' then
                Movie.where('rating IN (?)', rating).order('release_date')
        end
    end
        
end

class Movie < ActiveRecord::Base
    #@all_ratings = ['G', 'PG', 'PG-13', 'R']
    def self.all_ratings 
        ['G', 'PG', 'PG-13', 'R']
    end
    
    def self.sort_by_and_rating(sort, rating)
        case sort
            when nil
                Movie.where('rating in (?)', rating)
            when 'title' then
                Movie.where('rating in (?)', rating).order('title')
            when 'release_date' then
                Movie.where('rating in (?)', rating).order('release_date')
        end
    end
        
end

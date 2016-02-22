class Movie < ActiveRecord::Base
    def self.all_rating 
        ['G', 'PG', 'PG-13', 'R']
    end
end

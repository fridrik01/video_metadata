module VideoMetadata
  module TMDBLookup
    @@tmdb = TMDBParty::Base.new('a8df8bdbbae42107275d71aac1361c17')
    
    def tmdb( value )
      return nil if value == nil
      begin
        info = @@tmdb.get_info( value )
        return nil if info == nil
        return nil if info.id.to_s != value.to_s          
      rescue
        return nil
      end
      
      begin
        if info.released.class == Date
          year = info.released.year
        end
        
        if info.posters.size > 0
          coverart = info.posters.first['cover'] 
        end
      rescue
      end
       
      return {
        :value => info.id.to_s,
        :title => info.name,
        :plot => info.overview,
        :year => year.to_s,
        :coverart => coverart,
        :imdbid => info.imdb_id
      }
    end
  end
end
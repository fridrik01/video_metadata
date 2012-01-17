module VideoMetadata
  module TMDBLookup
    @@tmdb = TMDBParty::Base.new('a8df8bdbbae42107275d71aac1361c17')
    
    def tmdb( value )      
      return nil if value == nil
      begin        
        info = @@tmdb.get_info( value )        
        return nil if info == nil
        return nil if info.id.to_s != value.to_s
        return tmdb_to_metadata_hash(info)
      rescue
        return nil
      end
    end
    
    def imdb_lookup(imdbid)
      return nil if imdbid == nil
      begin
        info = @@tmdb.imdb_lookup(imdbid)
        return nil if info == nil
        return nil if info.imdb_id.to_s != imdbid.to_s
        return tmdb_to_metadata_hash(info)
      rescue
        return nil
      end      
    end
    
    private
      def tmdb_to_metadata_hash(info)
        return nil if info == nil
        
        year = nil
        coverart = nil
        begin
          if info.released.class == Date
            year = info.released.year.to_s
          end
          
          if info.posters.size > 0
            coverart = info.posters.first.thumb_url 
          end       
        rescue       
        end
       
        return {
          :value => info.id.to_s,
          :title => info.name,
          :plot => info.overview,
          :year => year,
          :coverart => coverart,
          :imdbid => info.imdb_id,
          :runtime => info.runtime,
          :raw => info
        }
      end
  end
end
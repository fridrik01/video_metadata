module VideoMetadata
  module TVDBLookup
    @@tvdb = TvdbParty::Search.new('4513D93B180F7C15')
    
    def tvdb_series(tvdbid)
      return nil if tvdbid.class != Fixnum
      tv_show = @@tvdb.get_series_by_id(tvdbid)      
      season_to_hash(tv_show)      
    end
    
    def tvdb_episode(tvdbid, season, episode)      
      [tvdbid, season, episode].each do |value|
        return nil if value.class != Fixnum
      end
      
      tv_show = @@tvdb.get_series_by_id(tvdbid)
      return nil if tv_show == nil
      episode = @@tvdb.get_episode(tv_show, season, episode)      
      return nil if episode == nil
      episode_to_hash(episode)
    end
  
    def tvdb_episodes(tvdbid)      
      return nil if tvdbid == nil
      tv_show = @@tvdb.get_series_by_id(tvdbid)
      return nil if tv_show == nil
      episodes = tv_show.get_all_episodes
      return nil if episodes == nil
          
      result = []
      episodes.each do |episode|
        next if episode.name.blank?
        result << episode_to_hash(episode)
      end
      return result
    end
    
    private
      def season_to_hash(season)        
        return nil if season == nil
        
        if season.posters('en').size > 0
          coverart = season.posters('en').first.url 
        end
        
        begin          
          year = season.first_aired.year          
        rescue          
        end
        return {
          :is_parent => true,
          :value => season.id,
          :title => season.name,
          :plot => season.overview,
          :year => year.to_s,
          :coverart => coverart,
          :runtime => season.runtime.to_i,
          :raw => season
        }        
      end
      
      def episode_to_hash(episode)
        return nil if episode == nil
        begin
          year = Date.parse(episode.air_date).year
        rescue
        end  
        
        return {
          :value => episode.id,
          :title => episode.name,
          :plot => episode.overview,
          :year => year.to_s,
          :season => episode.season_number,
          :episode => episode.number, 
          :coverart => episode.thumb,
          :imdbid => episode.imdb_id
        }
      end
  end
end



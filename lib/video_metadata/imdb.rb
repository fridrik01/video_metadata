module VideoMetadata  
  module IMDBLookup
    require 'yay_imdbs'
    
    def imdb( value )
      return nil if value == nil
      return nil unless /tt(\d){7}/.match(value)

      info = nil
      begin
        info = YayImdbs.scrap_movie_info( value.gsub(/^tt/, "") )              
      rescue
        return nil
      end
      return nil if info[:title].blank?
      
      {        
        :value => value,
        :title => info[:title],
        :plot => info[:plot],
        :year => info[:year].to_s,
        :coverart => info[:small_image],
        :imdbid => value
      }        
    end    
  end
end
module VideoMetadata
  module MALLookup
    require 'rest_client'
    def mal( value )              
      return nil if value == nil
      begin
        resp = RestClient.get("http://mal-api.com/anime/#{value}")        
        return mal_to_metadata_hash(JSON.parse(resp.body))        
      rescue
        return nil
      end
    end
        
    private
      def mal_to_metadata_hash(info)
        return nil if info == nil                  
        return {
          :value => info['id'].to_s,
          :title => info['title'],
          :plot => info['synopsis'],
          :year => nil,
          :coverart => info['image_url'],
          :url => "http://mal-api.com/anime/#{info['id']}"
        }        
      end
  end
end
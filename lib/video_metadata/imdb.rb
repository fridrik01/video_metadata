module VideoMetadata
  module IMDBLookup
    def imdb( value )
      return nil if value == nil
      h = keyValueStringToHash(%x{imdb-get -l #{value} -a 2>/dev/null})
      [:title, :plot, :tagline, :cast].each do |v| 
        h[v] = HTMLEntities.new.decode(h[v]) # remove html entities, mapping to UTF-8 
      end
      return nil unless h[:id] == value # be sure that imdb-get succeeded    
      
      return {        
        :value => h[:id],
        :title => h[:title],
        :plot => h[:plot],
        :year => h[:year].to_s,
        :coverart => h[:coverart],
        :imdbid => h[:id]
      }      
    end
    
    private
      def keyValueStringToHash(str)  
        res = {}
        str.split("\n").each do |line|    
          pos = line.index(':')
          if( pos != nil and pos > 0)
            key = line[0..pos-1].strip
            value = line[pos+1..-1].strip    
            res[key.to_sym] = value
          end
        end
        res  
      end
  end
end
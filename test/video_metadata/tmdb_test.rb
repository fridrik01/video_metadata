require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'video_metadata'

class TMDBTest < Test::Unit::TestCase
  context "tmdb" do
    setup do      
    end
          
    context "get titanic movie" do
      setup do
        @metadata = VideoMetadata::Lookup::tmdb(2699)
      end
            
      should "contains valid metadata" do                
        assert_equal "tt0115392", @metadata[:imdbid]
        assert_equal "2699", @metadata[:value]
        assert_equal "Titanic.", @metadata[:title]
        assert_equal "1996", @metadata[:year]        
      end
      
      should "contain nil metadata" do
        assert_equal nil, VideoMetadata::Lookup::tmdb(348739478)
        assert_equal nil, VideoMetadata::Lookup::tmdb("")
        assert_equal nil, VideoMetadata::Lookup::tmdb(nil)
      end
      
      should "be able to fetch by imdb id" do
        assert_equal "tt0115392", VideoMetadata::Lookup::imdb_lookup("tt0115392")[:imdbid]
      end
    end
    
    context "get avatar movie" do
      setup do
        @metadata = VideoMetadata::Lookup::tmdb(19995)
      end
            
      should "contain valid metadata" do                
        assert_equal "tt0499549", @metadata[:imdbid]
        assert_equal "19995", @metadata[:value]
        assert_equal "Avatar", @metadata[:title]
        assert_equal "2009", @metadata[:year]        
      end
    end 
  end  
end


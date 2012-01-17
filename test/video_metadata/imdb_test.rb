require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'video_metadata'

class IMDBTest < Test::Unit::TestCase
  context "imdb" do
    setup do      
    end
          
    context "get titanic movie" do
      setup do
        @metadata = VideoMetadata::Lookup::imdb("tt0115392")        
      end
            
      should "contain valid metadata" do                
        assert_equal "tt0115392", @metadata[:imdbid]
        assert_equal "tt0115392", @metadata[:value]
        assert_equal "Titanic", @metadata[:title]                
      end
      
      should "contain invalid  metadata" do
        assert_equal nil, VideoMetadata::Lookup::imdb("")
        assert_equal nil, VideoMetadata::Lookup::imdb(nil)   
      end
    end
    
    context "get avatar movie" do
      setup do
        @metadata = VideoMetadata::Lookup::imdb("tt0499549")        
      end
      
      should "contain valid metadata" do
        assert_equal "tt0499549", @metadata[:imdbid]
        assert_equal "tt0499549", @metadata[:value]
        assert_equal "IMDb - Avatar", @metadata[:title]
        assert_equal "2009", @metadata[:year]
        assert_equal 162, @metadata[:runtime]
      end
    
      should "contain nil metadata" do
        assert_equal nil, VideoMetadata::Lookup::imdb("tt04995491")
        assert_equal nil, VideoMetadata::Lookup::imdb("")
        assert_equal nil, VideoMetadata::Lookup::imdb(nil)
      end
    end
  end  
end
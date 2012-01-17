require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'video_metadata'

class TVDBTest < Test::Unit::TestCase
  context "tvdb" do
    setup do      
    end
  
    context "get a single tvshow" do
      setup do
        @series = VideoMetadata::Lookup::tvdb_series(83232)        
      end
      
      should "contain valid metadata" do
        assert_equal "83232", @series[:value]
        assert_equal "Little Britain USA", @series[:title]
        assert_equal "2008", @series[:year]
        assert_equal true, @series[:is_parent]
        assert_equal "http://thetvdb.com/banners/posters/83232-1.jpg", @series[:coverart]
        assert_equal 30, @series[:runtime]
      end
      
       should "contain invalid valid metadata" do
         assert_equal nil, VideoMetadata::Lookup::tvdb_series("83232")
         assert_equal nil, VideoMetadata::Lookup::tvdb_series(nil)
         assert_equal nil, VideoMetadata::Lookup::tvdb_series(8273628736)
       end
    end
          
    context "get a single episode for little britain (US)" do
      setup do
        @metadata = VideoMetadata::Lookup::tvdb_episode(83232, 1,1)
      end
            
      should "contain valid metadata" do        
        assert_equal "tt1068789", @metadata[:imdbid]
        assert_equal "392018", @metadata[:value]
        assert_equal "Episode 1", @metadata[:title]
        assert_equal "1", @metadata[:episode]
        assert_equal "1", @metadata[:season]        
      end
      
      should "contains nil metadata" do
        assert_equal nil, VideoMetadata::Lookup::tvdb_episode(83232, 1234,1)
        assert_equal nil, VideoMetadata::Lookup::tvdb_episode(83231422, 1,1)
        assert_equal nil, VideoMetadata::Lookup::tvdb_episode("", 1, 1)
        assert_equal nil, VideoMetadata::Lookup::tvdb_episode(nil, 1, 1)
      end
    end
    
    context "get all episodes for little britain (US)" do
      setup do
        @metadata = VideoMetadata::Lookup::tvdb_episodes(83232)
      end
            
      should "contain at least 7 episodes" do        
        assert @metadata.size >= 7
      end
      
      should "contains nil metadata" do
        assert_equal nil, VideoMetadata::Lookup::tvdb_episodes(83231422)
        assert_equal nil, VideoMetadata::Lookup::tvdb_episodes("")
        assert_equal nil, VideoMetadata::Lookup::tvdb_episodes(nil)
      end
    end    
  end  
end

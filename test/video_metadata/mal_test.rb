require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'video_metadata'

class MALTest < Test::Unit::TestCase
  context "mal" do
    setup do      
    end
    
    context "fetch Akikan" do
       setup do
         @metadata = VideoMetadata::Lookup::mal('5112')         
       end
       
       should "contain valid metadata" do 
         assert_equal "5112", @metadata[:value]
         assert_equal "Akikan!", @metadata[:title]
       end       
     end
  end  
end
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ArrayGroupings" do
  it "should be able to do groupings of arrays" do
    arr = [1, 2, 4, 5, 6, 9, 10, 11, 12, 13, 14]
    res = Array_groupings.new(:arr => arr, :debug => true).parse do |a, b|
      if (b - a) > 2
        false
      else
        true
      end
    end
    
    res = res.to_a
    print "Res: #{res}\n"
    raise "Expected length of 7 but it wasnt: #{res.length}" if res.length != 7
    
    
    arr = [1, 1, 2, 3, 5, 6, 7]
    res = Array_groupings.new(:arr => arr, :debug => true).parse do |a, b|
      if (b - a) > 4
        false
      else
        true
      end
    end
    
    res = res.to_a
    print "Res: #{res}\n"
  end
end

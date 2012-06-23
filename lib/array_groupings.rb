class Array_groupings
  def initialize(args)
    @args = args
    @arr = @args[:arr]
    @debug = @args[:debug]
  end
  
  def parse
    return Enumerator.new do |yielder|
      prev_ele = @arr.shift
      chunk = [prev_ele]
      chunks = [chunk]
      print "First ele: #{prev_ele}\n" if @debug
      
      @arr.each do |ele|
        print "Ele: '#{ele}'\n" if @debug
        deletes = []
        adds = []
        
        chunks.each do |chunk_i|
          res_last = yield(chunk_i.last, ele)
          res_first = yield(chunk_i.first, ele)
          
          if res_first and res_last
            chunk_i << ele
          elsif !res_last and !res_first
            yielder << chunk_i
            deletes << chunk_i
            adds << [ele]
          elsif res_last and !res_first
            new_add = []
            chunk_i.each do |chunk_i_ele|
              if yield(chunk_i_ele, ele)
                new_add << chunk_i_ele
              end
            end
            new_add << ele
            
            yielder << chunk_i
            adds << new_add
            deletes << chunk_i
          else
            raise "Dont know what to do here..."
          end
        end
        
        chunks -= deletes
        chunks += adds
      end
      
      chunks.each do |chunk|
        yielder << chunk
      end
    end
  end
end
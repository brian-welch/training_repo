module ElapsedTimeHelper

  def elapsed_time(sesh)
    ElapsedTime.new(sesh)
  end

  class ElapsedTime
    def initialize(sesh)
      @total_seconds = (Time.now - sesh.created_at).round.to_i
    end
    def hour
      @total_seconds / 3600
    end
    def min
      (@total_seconds % 3600) / 60
    end
    def sec
      (@total_seconds % 3600) % 60
    end
  end #end of class

end #end of module

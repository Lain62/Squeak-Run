module RatGame
    class CatTimer
        attr_reader :time, :time_max
        def initialize(level)
            @level = level
            @time_max = 6 * 60
            @time_increase = 4
            @time = @time_max
            @status = :stop
        end

        def reset
            @time = @time_max
        end

        def start
            @status = :start
        end

        def stop
            @status = :stop
        end

        def pause
            @status = :paused
        end

        def rise
            @status = :rise
        end

        def update
            case @status
            when :start
                @time -= 1 if @time > 0
                reset if @time <= 0
            when :stop
                reset if @time != @time_max
            when :paused
            when :rise
                @time += @time_increase if @time < @time_max
                reset if @time > @time_max
            end
            Globals.outputs.debug << "#{@time}"
        end
    end
end
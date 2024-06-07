class AudioManager
    attr_gtk
    def initialize
        @args = $args
    end

    def update
        if state.tick_count == 0
            audio[:bg_music] = {
                input: "sounds/funkysuspense.mp3",
                looping: true
            }
        end
    end
end
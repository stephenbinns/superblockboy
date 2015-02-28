class Music
  def self.play
    @@index ||= 1
    @@song ||= nil
    
    if @@song.nil? || @@song.playing? == false
      @@song = Song["media/0#{@@index}.ogg"]
      @@song.play
      @@index += 1
      if @@index == 4
        @@index = 1
      end
    end
  end
end

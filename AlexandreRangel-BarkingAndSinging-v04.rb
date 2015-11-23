# Alexandre rANGEL
# "barking and singing" (v04)
# www.quasecinema.org
# 21-Nov-2015
# Sonic Pi 2.7

use_bpm 136
clock = 0
set_volume! 1.15

t = Time.new
tx = (t.year * t.month * t.day * t.hour * t.min * t.sec)
use_random_seed tx
puts tx

live_loop :metro do
  clock = tick
  bar = clock / 4
  puts "bar : #{bar}"
  puts (ring "1 |","2 | |","3 | | |","4 | | | |")[clock]
  sleep 1
end #metro

with_fx :compressor, threshold: 0.75, mix: 0.3 do
  #trying to mix at -1.5 dB

  with_bpm 136 / 2 do # no loop here, just intro
    use_synth :mod_dsaw
    play 58, attack: 8.0,
      sustain: 72,
      release: (ring 0.8,0.8,0.8,0.8,1.2)[tick/8],
      amp: 1.0/3
  end #bpm

  live_loop :hum do
    use_synth :dsaw
    tock = tick
    tock = tick-4 if one_in(16)
    tock = rand_i(16) if one_in(21)
    with_fx :pitch_shift, pitch: rrand(-4,4),
    window_size: rrand(0.001,0.01), mix: 0.75 do
      play 60 -(ring 12,12,20,20,28)[tock/8], attack: 0.2,
        release: (ring 0.8,0.8,0.8,0.8,1.2)[tick/8],
        amp: 2.22 *0
      with_bpm 136 / 2 do
        use_synth :mod_dsaw
        play 58 -(ring 12,12,20,20,28)[tock/8], attack: 4,
          sustain: 64,
          release: (ring 0.8,0.8,0.8,0.8,1.2)[tick/8],
          amp: 1.0/3 if one_in(4)
      end #bpm

    end #fx

    sleep 1
    sleep 3 if one_in(64)
  end

  live_loop :tss do
    with_fx :pitch_shift, pitch: rrand(0,8),
    window_size: rrand(0.001,0.01), mix: 0.6 do
      with_fx :slicer,
      phase: 0.25/(ring 2,1,4,0.5)[tick/(ring 4,1,2)[tick/16]] do
        with_fx :echo, reps: 1, phase: 1.0/2 do
          sample :drum_cymbal_open,
            start: (ring 0,0,0,0,0.1,0.1)[tick],
            pan: rrand(-0.3,0.3), pan_slide: 0.1,
            amp: rrand(2.4,2.8) *0
        end #fx
      end #fx
    end #fx
    sleep 0.5
  end


  live_loop :tum do
    with_fx :pitch_shift, pitch: rrand(0.2,-4),
    window_size: rrand(0.001,0.002), mix: rrand(0.3,0.7) do
      sample :bd_haus, amp: rrand(5.0,5.2) *0
    end #fx
    sleep 1.0

  end


end # fx compressor




#

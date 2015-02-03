# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{chingu}
  s.version = "0.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["ippa"]
  s.date = %q{2011-01-08}
  s.description = %q{OpenGL accelerated 2D game framework for Ruby. Builds on Gosu (Ruby/C++) which provides all the core functionality. Chingu adds simple yet powerful game states, prettier input handling, deployment safe asset-handling, a basic re-usable game object and stackable game logic.}
  s.email = %q{ippa@rubylicio.us}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".rspec",
    "History.txt",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "benchmarks/README.txt",
    "benchmarks/array_vs_hash.rb",
    "benchmarks/arrays_bench.rb",
    "benchmarks/benchmark.rb",
    "benchmarks/benchmark3.rb",
    "benchmarks/benchmark4.rb",
    "benchmarks/benchmark5.rb",
    "benchmarks/benchmark6.rb",
    "benchmarks/game_object_list_benchmark.rb",
    "benchmarks/game_objects_benchmark.rb",
    "benchmarks/lookup_benchmark.rb",
    "benchmarks/meta_benchmark.rb",
    "benchmarks/meta_benchmark2.rb",
    "benchmarks/trait_benchmark.rb",
    "benchmarks/window_benchmark.rb",
    "chingu.gemspec",
    "examples/example10_traits_retrofy.rb",
    "examples/example11_animation.rb",
    "examples/example12_trait_timer.rb",
    "examples/example13_high_scores.rb",
    "examples/example14_bounding_box_circle.rb",
    "examples/example15_trait_timer2.rb",
    "examples/example16_online_high_scores.rb",
    "examples/example17_gosu_tutorial.rb",
    "examples/example18_animation_trait.rb",
    "examples/example19.yml",
    "examples/example19_edit_viewport.rb",
    "examples/example1_basics.rb",
    "examples/example20_trait_inheritence_test.rb",
    "examples/example21.yml",
    "examples/example21_sidescroller_with_edit.rb",
    "examples/example22_text.rb",
    "examples/example23_chipmunk.rb",
    "examples/example24_enter_name.rb",
    "examples/example25.yml",
    "examples/example25_fibers_state_machine.rb",
    "examples/example26_splash_screen.rb",
    "examples/example27_console.rb",
    "examples/example2_gamestate_basics.rb",
    "examples/example3_parallax.rb",
    "examples/example4_gamestates.rb",
    "examples/example5_gamestates_in_pure_gosu.rb",
    "examples/example6_transitional_game_state.rb",
    "examples/example7_gfx_helpers.rb",
    "examples/example8_traits.rb",
    "examples/example9_collision_detection.rb",
    "examples/game1.rb",
    "examples/game_of_life.rb",
    "examples/high_score_list.yml",
    "examples/media/Parallax-scroll-example-layer-0.png",
    "examples/media/Parallax-scroll-example-layer-1.png",
    "examples/media/Parallax-scroll-example-layer-2.png",
    "examples/media/Parallax-scroll-example-layer-3.png",
    "examples/media/Star.png",
    "examples/media/Starfighter.bmp",
    "examples/media/background1.png",
    "examples/media/battery.png",
    "examples/media/big_star.png",
    "examples/media/big_stone_wall.bmp",
    "examples/media/black_block.png",
    "examples/media/bullet.png",
    "examples/media/bullet_hit.wav",
    "examples/media/circle.png",
    "examples/media/city1.png",
    "examples/media/city2.png",
    "examples/media/cog_wheel.png",
    "examples/media/droid.bmp",
    "examples/media/droid_11x15.bmp",
    "examples/media/droid_11x15.gal",
    "examples/media/enemy_bullet.png",
    "examples/media/explosion.wav",
    "examples/media/fire_bullet.png",
    "examples/media/fireball.png",
    "examples/media/heli.bmp",
    "examples/media/heli.gal",
    "examples/media/laser.wav",
    "examples/media/particle.png",
    "examples/media/plane.png",
    "examples/media/rect.png",
    "examples/media/ruby.png",
    "examples/media/saucer.gal",
    "examples/media/saucer.png",
    "examples/media/saw.png",
    "examples/media/spaceship.png",
    "examples/media/star_25x25_default.png",
    "examples/media/star_25x25_explode.gal",
    "examples/media/star_25x25_explode.png",
    "examples/media/stone_wall.bmp",
    "examples/media/talk_bubble.png",
    "examples/media/tube.png",
    "examples/media/video_games.png",
    "examples/media/wood.png",
    "examples/tool1_input_codes.rb",
    "lib/chingu.rb",
    "lib/chingu/animation.rb",
    "lib/chingu/assets.rb",
    "lib/chingu/basic_game_object.rb",
    "lib/chingu/classic_game_object.rb",
    "lib/chingu/console.rb",
    "lib/chingu/core_ext/array.rb",
    "lib/chingu/fpscounter.rb",
    "lib/chingu/game_object.rb",
    "lib/chingu/game_object_list.rb",
    "lib/chingu/game_object_map.rb",
    "lib/chingu/game_state.rb",
    "lib/chingu/game_state_manager.rb",
    "lib/chingu/game_states/debug.rb",
    "lib/chingu/game_states/edit.rb",
    "lib/chingu/game_states/enter_name.rb",
    "lib/chingu/game_states/fade_to.rb",
    "lib/chingu/game_states/pause.rb",
    "lib/chingu/game_states/popup.rb",
    "lib/chingu/gosu_ext/image.rb",
    "lib/chingu/helpers/class_inheritable_accessor.rb",
    "lib/chingu/helpers/game_object.rb",
    "lib/chingu/helpers/game_state.rb",
    "lib/chingu/helpers/gfx.rb",
    "lib/chingu/helpers/input_client.rb",
    "lib/chingu/helpers/input_dispatcher.rb",
    "lib/chingu/helpers/options_setter.rb",
    "lib/chingu/helpers/rotation_center.rb",
    "lib/chingu/high_score_list.rb",
    "lib/chingu/inflector.rb",
    "lib/chingu/input.rb",
    "lib/chingu/named_resource.rb",
    "lib/chingu/online_high_score_list.rb",
    "lib/chingu/parallax.rb",
    "lib/chingu/particle.rb",
    "lib/chingu/rect.rb",
    "lib/chingu/require_all.rb",
    "lib/chingu/simple_menu.rb",
    "lib/chingu/text.rb",
    "lib/chingu/traits/animation.rb",
    "lib/chingu/traits/bounding_box.rb",
    "lib/chingu/traits/bounding_circle.rb",
    "lib/chingu/traits/collision_detection.rb",
    "lib/chingu/traits/effect.rb",
    "lib/chingu/traits/retrofy.rb",
    "lib/chingu/traits/simple_sprite.rb",
    "lib/chingu/traits/sprite.rb",
    "lib/chingu/traits/timer.rb",
    "lib/chingu/traits/velocity.rb",
    "lib/chingu/traits/viewport.rb",
    "lib/chingu/viewport.rb",
    "lib/chingu/window.rb",
    "spec/chingu/animation_spec.rb",
    "spec/chingu/assets_spec.rb",
    "spec/chingu/basic_game_object_spec.rb",
    "spec/chingu/console_spec.rb",
    "spec/chingu/fpscounter_spec.rb",
    "spec/chingu/game_object_list_spec.rb",
    "spec/chingu/game_object_map_spec.rb",
    "spec/chingu/game_object_spec.rb",
    "spec/chingu/game_state_manager_spec.rb",
    "spec/chingu/helpers/input_client_spec.rb",
    "spec/chingu/helpers/input_dispatcher_spec.rb",
    "spec/chingu/helpers/options_setter_spec.rb",
    "spec/chingu/images/droid_11x15.bmp",
    "spec/chingu/images/rect_20x20.png",
    "spec/chingu/inflector_spec.rb",
    "spec/chingu/input_spec.rb",
    "spec/chingu/parallax_spec.rb",
    "spec/chingu/text_spec.rb",
    "spec/chingu/window_spec.rb",
    "spec/spec_helper.rb",
    "specs.watchr"
  ]
  s.homepage = %q{http://github.com/ippa/chingu}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{chingu}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{OpenGL accelerated 2D game framework for Ruby}
  s.test_files = [
    "examples/example10_traits_retrofy.rb",
    "examples/example11_animation.rb",
    "examples/example12_trait_timer.rb",
    "examples/example13_high_scores.rb",
    "examples/example14_bounding_box_circle.rb",
    "examples/example15_trait_timer2.rb",
    "examples/example16_online_high_scores.rb",
    "examples/example17_gosu_tutorial.rb",
    "examples/example18_animation_trait.rb",
    "examples/example19_edit_viewport.rb",
    "examples/example1_basics.rb",
    "examples/example20_trait_inheritence_test.rb",
    "examples/example21_sidescroller_with_edit.rb",
    "examples/example22_text.rb",
    "examples/example23_chipmunk.rb",
    "examples/example24_enter_name.rb",
    "examples/example25_fibers_state_machine.rb",
    "examples/example26_splash_screen.rb",
    "examples/example27_console.rb",
    "examples/example2_gamestate_basics.rb",
    "examples/example3_parallax.rb",
    "examples/example4_gamestates.rb",
    "examples/example5_gamestates_in_pure_gosu.rb",
    "examples/example6_transitional_game_state.rb",
    "examples/example7_gfx_helpers.rb",
    "examples/example8_traits.rb",
    "examples/example9_collision_detection.rb",
    "examples/game1.rb",
    "examples/game_of_life.rb",
    "examples/tool1_input_codes.rb",
    "spec/chingu/animation_spec.rb",
    "spec/chingu/assets_spec.rb",
    "spec/chingu/basic_game_object_spec.rb",
    "spec/chingu/console_spec.rb",
    "spec/chingu/fpscounter_spec.rb",
    "spec/chingu/game_object_list_spec.rb",
    "spec/chingu/game_object_map_spec.rb",
    "spec/chingu/game_object_spec.rb",
    "spec/chingu/game_state_manager_spec.rb",
    "spec/chingu/helpers/input_client_spec.rb",
    "spec/chingu/helpers/input_dispatcher_spec.rb",
    "spec/chingu/helpers/options_setter_spec.rb",
    "spec/chingu/inflector_spec.rb",
    "spec/chingu/input_spec.rb",
    "spec/chingu/parallax_spec.rb",
    "spec/chingu/text_spec.rb",
    "spec/chingu/window_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gosu>, [">= 0.7.25"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
      s.add_runtime_dependency(%q<crack>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.1.0"])
      s.add_development_dependency(%q<watchr>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<gosu>, [">= 0.7.25"])
      s.add_dependency(%q<rest-client>, [">= 0"])
      s.add_dependency(%q<crack>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.1.0"])
      s.add_dependency(%q<watchr>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<gosu>, [">= 0.7.25"])
    s.add_dependency(%q<rest-client>, [">= 0"])
    s.add_dependency(%q<crack>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.1.0"])
    s.add_dependency(%q<watchr>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

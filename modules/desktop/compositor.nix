{inputs, ...}: {
  flake.modules.nixos.desktop = {
    lib,
    pkgs,
    ...
  }: let
    mango = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.mango;
  in {
    programs.mango = {
      enable = true;
      addLoginEntry = false;
    };

    programs.uwsm = {
      enable = true;
      waylandCompositors.mango = {
        prettyName = "Mango";
        comment = "MangoWM managed by UWSM";
        binPath = "${mango}/bin/mango";
      };
    };
  };
  flake.modules.homeManager.desktop = {lib, ...}: let
    tags = lib.range 1 9;

    mod = "SUPER";
    ipc = "noctalia msg ";
    uwsm = cmd: "uwsm app -- ${cmd}";

    terminal = "foot";
    browser = "brave-origin";
    file_manager = "thunar";
    notes = "obsidian";
  in {
    wayland.windowManager.mango = {
      systemd.enable = false;
      settings = {
        exec_once = [
          "runapp wl-clip-persist --clipboard regular"
        ];

        # ── Window effect ──
        blur = 0;
        blur_layer = 0;
        blur_optimized = 1;
        blur_params_num_passes = 2;
        blur_params_radius = 5;
        blur_params_noise = 0.02;
        blur_params_brightness = 0.9;
        blur_params_contrast = 0.9;
        blur_params_saturation = 1.2;
        shadows = 0;
        layer_shadows = 0;
        shadow_only_floating = 1;
        shadows_size = 10;
        shadows_blur = 15;
        shadows_position_x = 0;
        shadows_position_y = 0;
        shadows_color = "0x000000ff";
        border_radius = 6;
        no_radius_when_single = 0;
        focused_opacity = 1.0;
        unfocused_opacity = 1.0;
        dim_enable = 0;
        dim_focused_color = "0x00000000";
        dim_unfocused_color = "0x00000055";

        # ── Animation ──
        animations = 1;
        layer_animations = 1;
        animation_type_open = "slide";
        animation_type_close = "slide";
        animation_fade_in = 1;
        animation_fade_out = 1;
        tag_animation_direction = 1;
        zoom_initial_ratio = 0.4;
        zoom_end_ratio = 0.8;
        fade_in_begin_opacity = 0.5;
        fade_out_begin_opacity = 0.8;
        animation_duration_move = 500;
        animation_duration_open = 400;
        animation_duration_tag = 350;
        animation_duration_close = 800;
        animation_duration_focus = 0;
        animation_curve_open = "0.46,1.0,0.29,1";
        animation_curve_move = "0.46,1.0,0.29,1";
        animation_curve_tag = "0.46,1.0,0.29,1";
        animation_curve_close = "0.08,0.92,0,1";
        animation_curve_focus = "0.46,1.0,0.29,1";
        animation_curve_opacity_fade_out = "0.5,0.5,0.5,0.5";
        animation_curve_opacity_fade_in = "0.46,1.0,0.29,1";

        # ── Scroller layout ──
        scroller_structs = 20;
        scroller_default_proportion = 0.8;
        scroller_focus_center = 0;
        scroller_prefer_center = 0;
        edge_scroller_pointer_focus = 1;
        edge_scroller_focus_allow_speed = 0.0;
        scroller_default_proportion_single = 1.0;
        scroller_proportion_preset = "0.5,0.8,1.0";

        # ── Master-stack layout ──
        new_is_master = 1;
        default_master_factor = 0.55;
        default_master_count = 1;
        tag_num = 9;
        smart_gaps = 0;

        # ── Dwindle layout ──
        dwindle_smart_split = 0;
        dwindle_drop_simple_split = 1;
        dwindle_manual_split = 0;
        dwindle_horizontal_split = 1;
        dwindle_vertical_split = 1;
        dwindle_preserve_split = 0;

        # ── Monocle / Deck ──
        monocle_tab_mode = 1;
        monocle_no_border = 0;
        monocle_no_gap = 0;
        monocle_no_radius = 0;
        deck_tab_mode = 1;

        # ── Overview ──
        hotarea_size = 10;
        enable_hotarea = 0;
        hotarea_disable_on_fullscreen = 1;
        overview_gap_inner = 5;
        overview_gap_outer = 30;
        overcircle_center_ratio = 0.5;
        title_message_bar_height = 52;
        title_message_bar_gap = 20;

        # ── Misc ──
        no_border_when_single = 0;
        axis_bind_apply_timeout = 100;
        focus_on_activate = 1;
        idle_inhibit_ignore_visible = 0;
        idle_inhibit_when_fullscreen = 0;
        sloppy_focus = 1;
        warp_cursor = 1;
        focus_cross_monitor = 0;
        focus_direction_only_zone_overlap = 1;
        focus_cross_tag = 0;
        enable_floating_snap = 0;
        snap_distance = 30;
        float_full_to_top = 0;
        cursor_size = 24;
        drag_tile_to_tile = 1;
        drag_tile_small = 1;

        # ── Keyboard ──
        repeat_rate = 25;
        repeat_delay = 600;
        numlock_on = 0;
        xkb_rules_layout = "us";

        # ── Trackpad (needs relogin) ──
        disable_trackpad = 0;
        tap_to_click = 1;
        tap_and_drag = 1;
        drag_lock = 1;
        trackpad_natural_scrolling = 0;
        trackpad_disable_while_typing = 1;
        trackpad_left_handed = 0;
        trackpad_middle_button_emulation = 0;
        swipe_min_threshold = 1;

        # ── Mouse (needs relogin) ──
        mouse_natural_scrolling = 0;

        # ── Appearance ──
        gap_inner_horizontal = 5;
        gap_inner_vertical = 5;
        gap_outer_horizontal = 10;
        gap_outer_vertical = 10;
        scratchpad_width_ratio = 0.8;
        scratchpad_height_ratio = 0.9;
        border_px = 4;
        root_color = "0x201b14ff";
        border_color = "0x444444ff";
        drop_color = "0x8FBA7C55";
        split_color = "0xEB441EFF";
        focus_color = "0xc9b890ff";
        maximized_screen_color = "0x89aa61ff";
        urgent_color = "0xad401fff";
        scratchpad_color = "0x516c93ff";
        global_color = "0xb153a7ff";
        overlay_color = "0x14a57cff";

        bind =
          [
            # apps
            "${mod},q,spawn,${uwsm terminal}"
            "${mod},w,spawn,${uwsm browser}"
            "${mod},e,spawn,${uwsm file_manager}"
            "${mod},o,spawn,${uwsm notes}"
            "${mod},t,spawn,${uwsm "hyprpicker -a -f hex -n"}"
            "${mod},p,spawn,lock-in-erp"

            # window
            "${mod},c,killclient,"
            "${mod},v,togglefloating,"

            # noctalia
            "ALT,space,spawn,${ipc}panel-toggle launcher"
            "${mod},period,spawn,${ipc}panel-toggle control-center"
            "${mod},comma,spawn,${ipc}settings-toggle"
            "ALT,Tab,spawn,${ipc}window-switcher"

            # focus
            "${mod},h,focusdir,left"
            "${mod},j,focusdir,down"
            "${mod},k,focusdir,up"
            "${mod},l,focusdir,right"

            # resize
            "${mod},Left,resizewin,-10,+0"
            "${mod},Down,resizewin,+0,+10"
            "${mod},Up,resizewin,+0,-10"
            "${mod},Right,resizewin,+10,+0"

            # move window
            "${mod}+SHIFT,h,move_client,left"
            "${mod}+SHIFT,j,move_client,down"
            "${mod}+SHIFT,k,move_client,up"
            "${mod}+SHIFT,l,move_client,right"

            # screenshot / recording
            "NONE,Print,spawn,${ipc}screenshot-region"
            "${mod},r,spawn,${ipc}plugin noctalia/screen_recorder:service all toggle"

            # scratchpad (Hyprland's special:magic)
            "${mod},s,toggle_scratchpad"
            "${mod}+SHIFT,s,minimized"
          ]
          # SUPER+N → view tag N, SUPER+SHIFT+N → move window to tag N
          ++ map (n: "${mod},${toString n},view,${toString n},0") tags
          ++ map (n: "${mod}+SHIFT,${toString n},tag,${toString n},0") tags;

        bindl = [
          "NONE,XF86AudioRaiseVolume,spawn,${ipc}volume-up"
          "NONE,XF86AudioLowerVolume,spawn,${ipc}volume-down"
          "NONE,XF86AudioMute,spawn,${ipc}volume-mute"
          "NONE,XF86MonBrightnessUp,spawn,${ipc}brightness-up"
          "NONE,XF86MonBrightnessDown,spawn,${ipc}brightness-down"

          "NONE,XF86AudioNext,spawn,playerctl next"
          "NONE,XF86AudioPause,spawn,playerctl play-pause"
          "NONE,XF86AudioPlay,spawn,playerctl play-pause"
          "NONE,XF86AudioPrev,spawn,playerctl previous"
        ];

        mousebind = [
          "SUPER,btn_left,moveresize,curmove"
          "NONE,btn_middle,togglemaximizescreen,0"
          "SUPER,btn_right,moveresize,curresize"
        ];

        # ── Rules ──
        tag_rule = map (n: "id:${toString n},layout_name:tile") tags;
      };
    };
  };
}

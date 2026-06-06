{
  config,
  lib,
  pkgs,
  ...
}:
let
  wallpaperDir = "${config.home.homeDirectory}/Pictures/wallpapers";

  # Seed file -- noctalia rewrites it as the user tweaks things in the GUI,
  # so we copy on first run and then leave it alone instead of symlinking.
  settingsJson = pkgs.writeText "noctalia-settings.json" (builtins.toJSON {
    settingsVersion = 59;

    appLauncher = {
      autoPasteClipboard = false;
      clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
      clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
      clipboardWrapText = true;
      customLaunchPrefix = "";
      customLaunchPrefixEnabled = false;
      density = "default";
      enableClipPreview = true;
      enableClipboardChips = true;
      enableClipboardHistory = true;
      enableClipboardSmartIcons = true;
      enableSessionSearch = true;
      enableSettingsSearch = true;
      enableWindowsSearch = true;
      iconMode = "native";
      ignoreMouseInput = false;
      overviewLayer = false;
      pinnedApps = [ ];
      position = "center";
      screenshotAnnotationTool = "";
      showCategories = true;
      showIconBackground = true;
      sortByMostUsed = true;
      terminalCommand = "kitty -e";
      viewMode = "list";
    };

    audio = {
      mprisBlacklist = [ ];
      preferredPlayer = "";
      spectrumFrameRate = 30;
      spectrumMirrored = true;
      visualizerType = "linear";
      volumeFeedback = false;
      volumeFeedbackSoundFile = "";
      volumeOverdrive = false;
      volumeStep = 1;
    };

    bar = {
      autoHideDelay = 500;
      autoShowDelay = 150;
      backgroundOpacity = 0.2;
      barType = "simple";
      capsuleColorKey = "none";
      capsuleOpacity = 1;
      contentPadding = 2;
      density = "comfortable";
      displayMode = "always_visible";
      enableExclusionZoneInset = true;
      fontScale = 1;
      frameRadius = 12;
      frameThickness = 8;
      hideOnOverview = true;
      marginHorizontal = 5;
      marginVertical = 5;
      middleClickAction = "none";
      middleClickCommand = "";
      middleClickFollowMouse = false;
      monitors = [ ];
      mouseWheelAction = "none";
      mouseWheelWrap = true;
      outerCorners = true;
      position = "top";
      reverseScroll = false;
      rightClickAction = "controlCenter";
      rightClickCommand = "";
      rightClickFollowMouse = true;
      screenOverrides = [ ];
      showCapsule = true;
      showOnWorkspaceSwitch = true;
      showOutline = false;
      useSeparateOpacity = true;
      widgetSpacing = 6;

      widgets = {
        center = [
          {
            id = "Workspace";
            characterCount = 2;
            colorizeIcons = false;
            emptyColor = "secondary";
            enableScrollWheel = true;
            focusedColor = "primary";
            followFocusedScreen = false;
            fontWeight = "bold";
            groupedBorderOpacity = 1;
            hideUnoccupied = false;
            iconScale = 0.8;
            labelMode = "index";
            occupiedColor = "secondary";
            pillSize = 0.6;
            showApplications = false;
            showApplicationsHover = false;
            showBadge = true;
            showLabelsOnlyWhenOccupied = true;
            unfocusedIconsOpacity = 1;
          }
        ];

        left = [
          {
            id = "Launcher";
            colorizeSystemIcon = "none";
            colorizeSystemText = "none";
            customIconPath = "";
            enableColorization = false;
            icon = "rocket";
            iconColor = "none";
            useDistroLogo = false;
          }
          {
            id = "Clock";
            clockColor = "none";
            customFont = "";
            formatHorizontal = "HH:mm ddd, MMM dd";
            formatVertical = "HH mm - dd MM";
            tooltipFormat = "HH:mm ddd, MMM dd";
            useCustomFont = false;
          }
          {
            id = "SystemMonitor";
            compactMode = false;
            diskPath = "/";
            iconColor = "none";
            showCpuCores = false;
            showCpuFreq = false;
            showCpuTemp = false;
            showCpuUsage = true;
            showDiskAvailable = false;
            showDiskUsage = true;
            showDiskUsageAsPercent = false;
            showGpuTemp = false;
            showLoadAverage = false;
            showMemoryAsPercent = true;
            showMemoryUsage = true;
            showNetworkStats = false;
            showSwapUsage = false;
            textColor = "none";
            useMonospaceFont = true;
            usePadding = false;
          }
          {
            id = "ActiveWindow";
            colorizeIcons = false;
            hideMode = "hidden";
            maxWidth = 145;
            scrollingMode = "hover";
            showIcon = true;
            showText = true;
            textColor = "none";
            useFixedWidth = false;
          }
          {
            id = "MediaMini";
            compactMode = false;
            hideMode = "hidden";
            hideWhenIdle = false;
            maxWidth = 145;
            panelShowAlbumArt = true;
            scrollingMode = "hover";
            showAlbumArt = false;
            showArtistFirst = true;
            showProgressRing = true;
            showVisualizer = false;
            textColor = "none";
            useFixedWidth = false;
            visualizerType = "linear";
          }
        ];

        right = [
          {
            id = "NotificationHistory";
            hideWhenZero = false;
            hideWhenZeroUnread = false;
            iconColor = "none";
            showUnreadBadge = true;
            unreadBadgeColor = "primary";
          }
          {
            id = "Battery";
            deviceNativePath = "__default__";
            displayMode = "icon-always";
            hideIfIdle = false;
            hideIfNotDetected = true;
            showNoctaliaPerformance = true;
            showPowerProfiles = true;
          }
          {
            id = "Volume";
            displayMode = "alwaysShow";
            iconColor = "none";
            middleClickCommand = "pwvucontrol || pavucontrol";
            textColor = "none";
          }
          {
            id = "Brightness";
            applyToAllMonitors = false;
            displayMode = "alwaysShow";
            iconColor = "none";
            textColor = "none";
          }
          {
            id = "Tray";
            blacklist = [ ];
            chevronColor = "none";
            colorizeIcons = false;
            drawerEnabled = true;
            hidePassive = false;
            pinned = [ ];
          }
          {
            id = "ControlCenter";
            colorizeDistroLogo = false;
            colorizeSystemIcon = "none";
            colorizeSystemText = "none";
            customIconPath = "";
            enableColorization = false;
            icon = "noctalia";
            useDistroLogo = true;
          }
        ];
      };
    };

    brightness = {
      backlightDeviceMappings = [ ];
      brightnessStep = 3;
      enableDdcSupport = false;
      enforceMinimum = true;
    };

    colorSchemes = {
      darkMode = true;
      generationMethod = "tonal-spot";
      manualSunrise = "06:30";
      manualSunset = "18:30";
      monitorForColors = "";
      predefinedScheme = "Noctalia (default)";
      schedulingMode = "off";
      syncGsettings = true;
      useWallpaperColors = true;
    };

    controlCenter = {
      diskPath = "/";
      position = "close_to_bar_button";
      shortcuts = {
        left = [
          { id = "WiFi"; }
          { id = "Bluetooth"; }
          { id = "WallpaperSelector"; }
        ];
        right = [
          { id = "Notifications"; }
          { id = "PowerProfile"; }
          { id = "KeepAwake"; }
          { id = "NightLight"; }
        ];
      };
    };

    general = {
      animationDisabled = false;
      animationSpeed = 1;
      avatarImage = "";
      enableBlurBehind = true;
      enableShadows = true;
      lockOnSuspend = true;
      lockScreenAnimations = false;
      reverseScroll = false;
      shadowDirection = "bottom_right";
      shadowOffsetX = 2;
      shadowOffsetY = 3;
      showChangelogOnStartup = false;
      smoothScrollEnabled = true;
      telemetryEnabled = false;
    };

    location = {
      analogClockInCalendar = false;
      autoLocate = true;
      firstDayOfWeek = 1;
      hideWeatherCityName = false;
      hideWeatherTimezone = false;
      name = "Paris";
      showCalendarEvents = true;
      showCalendarWeather = true;
      showWeekNumberInCalendar = false;
      use12hourFormat = false;
      useFahrenheit = false;
      weatherEnabled = true;
      weatherShowEffects = true;
      weatherTaliaMascotAlways = false;
    };

    network = {
      bluetoothAutoConnect = true;
      bluetoothDetailsViewMode = "grid";
      bluetoothHideUnnamedDevices = false;
      networkPanelView = "wifi";
      wifiDetailsViewMode = "grid";
    };

    nightLight = {
      autoSchedule = true;
      dayTemp = "6500";
      enabled = false;
      forced = false;
      manualSunrise = "06:30";
      manualSunset = "18:30";
      nightTemp = "4000";
    };

    notifications = {
      backgroundOpacity = 1;
      clearDismissed = true;
      criticalUrgencyDuration = 15;
      density = "default";
      enableBatteryToast = true;
      enableKeyboardLayoutToast = true;
      enableMarkdown = false;
      enableMediaToast = false;
      enabled = true;
      location = "top_right";
      lowUrgencyDuration = 3;
      monitors = [ ];
      normalUrgencyDuration = 8;
      overlayLayer = true;
      respectExpireTimeout = false;
    };

    osd = {
      autoHideMs = 2000;
      backgroundOpacity = 1;
      enabled = true;
      enabledTypes = [ 0 1 4 3 ];
      location = "top_right";
      monitors = [ ];
      overlayLayer = true;
    };

    ui = {
      boxBorderEnabled = false;
      fontDefault = "Maple Mono NF CN";
      fontDefaultScale = 1;
      fontFixed = "Maple Mono NF CN";
      fontFixedScale = 1;
      panelBackgroundOpacity = 0.85;
      panelsAttachedToBar = true;
      scrollbarAlwaysVisible = true;
      settingsPanelMode = "attached";
      settingsPanelSideBarCardStyle = false;
      tooltipsEnabled = true;
      translucentWidgets = false;
    };

    wallpaper = {
      automationEnabled = true;
      directory = wallpaperDir;
      enableMultiMonitorDirectories = false;
      enabled = true;
      favorites = [ ];
      fillColor = "#000000";
      fillMode = "crop";
      hideWallpaperFilenames = false;
      linkLightAndDarkWallpapers = true;
      monitorDirectories = [ ];
      overviewBlur = 0.4;
      overviewEnabled = true;
      overviewTint = 0.6;
      panelPosition = "follow_bar";
      randomIntervalSec = 600;
      setWallpaperOnAllMonitors = true;
      showHiddenFiles = false;
      skipStartupTransition = false;
      solidColor = "#1a1a2e";
      sortOrder = "name";
      transitionDuration = 1500;
      transitionEdgeSmoothness = 0.05;
      transitionType = [ "fade" "disc" "stripes" "wipe" "pixelate" "honeycomb" ];
      useOriginalImages = false;
      useSolidColor = false;
      useWallhaven = false;
      viewMode = "recursive";
      wallpaperChangeMode = "random";
    };
  });
in
{
  home.packages = with pkgs; [
    noctalia-shell
    app2unit
    kdePackages.qt6ct

    # Screen recorder noctalia can hook into
    gpu-screen-recorder
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  # Seed noctalia's settings.json on first run; afterwards the GUI manages
  # the file so we don't overwrite the user's tweaks every rebuild.
  home.activation.seedNoctaliaSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    target="${config.xdg.configHome}/noctalia/settings.json"
    if [ ! -e "$target" ]; then
      mkdir -p "${config.xdg.configHome}/noctalia"
      install -m 644 ${settingsJson} "$target"
    fi
  '';

  # qt6ct -- Fusion style + Papirus icons + Maple Mono so Qt apps match the rest.
  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    custom_palette=false
    icon_theme=Papirus-Dark
    standard_dialogs=default
    style=Fusion

    [Fonts]
    fixed="Maple Mono NF CN,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
    general="Maple Mono NF CN,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid()
  '';
}

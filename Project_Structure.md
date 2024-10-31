## Project Structure

```
.
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug.yml               
│   │   ├── documentation.yml      
│   │   └── feature.yml            
│   ├── workflows/
│   │   ├── auto-comment-on-issue.yml     
│   │   ├── auto-comment-on-pr-merge.yml   
│   │   ├── auto-comment-pr-raise.yml     
│   │   ├── autocomment-iss-close.yml     
│   │   ├── close-old-pr.yml              
│   │   ├── codeql.yml                     
│   │   ├── dependabot.yml                
│   │   └── issue-assign.yml              
│   └── pull_request_template.md
│   
├── .gradle/
│   ├── 8.0.2/
│   │   ├── checksums/
│   │   │   └── checksums.lock                   
│   │   ├── fileChanges/
│   │   │   └── last-build.bin                  
│   │   ├── fileHashes/
│   │   │   └── fileHashes.lock                  
│   │   └── gc.properties                  
│   ├── 8.1.1/
│   │   ├── checksums/
│   │   │   └── checksums.lock                  
│   │   ├── dependencies-accessors/
│   │   │   ├── dependencies-accessors.lock     
│   │   │   └── gc.properties                   
│   │   ├── executionHistory/
│   │   │   └── executionHistory.lock                     
│   │   ├── fileChanges/
│   │   │   └── last-build.bin                     
│   │   ├── fileHashes/
│   │   │   └── fileHashes.lock
│   │   └── gc.properties
│   ├── buildOutputCleanup/
│   │   ├── buildOutputCleanup.lock               
│   │   └── cache.properties
│   └── vcs-1/
│       ├── gc.properties
│       └── cache.properties
│               
├── android/
│   ├── app/
│   │   └── src/
│   │       ├── debug/
│   │       │   └── AndroidManifest.xml
│   │       ├── main/
│   │       │   ├── kotlin/
│   │       │   │   └── com/
│   │       │   │       └── example/
│   │       │   │           └── opso/
│   │       │   │               └── MainActivity.kt
│   │       │   ├── res/
│   │       │   │   ├── drawable-v21/
│   │       │   │   │   └── launch_background.xml
│   │       │   │   ├── drawable/
│   │       │   │   │   └── launch_background.xml
│   │       │   │   ├── mipmap-hdpi/
│   │       │   │   │   └── ic_launcher.png
│   │       │   │   ├── mipmap-mdpi/
│   │       │   │   │   └── ic_launcher.png
│   │       │   │   ├── mipmap-xhdpi/
│   │       │   │   │   └── ic_launcher.png
│   │       │   │   ├── mipmap-xxhdpi/
│   │       │   │   │   └── ic_launcher.png
│   │       │   │   ├── mipmap-xxxhdpi/
│   │       │   │   │   └── ic_launcher.png
│   │       │   │   ├── values-night/
│   │       │   │   │   └── styles.xml
│   │       │   │   └── values/
│   │       │   │       └── styles.xml
│   │       │   └── AndroidManifest.xml
│   │       ├── profile/
│   │       │   └── AndroidManifest.xml
│   │       └── build.gradle
│   └──gradle/
│       ├── wrapper/
│       │    └── gradle-wrapper.properties
│       ├── .gitignore
│       ├── build.gradle
│       ├── gradle.properties
│       └── settings.gradle
│   
├── assets/
│   ├── projects/
│   │      ├── fossasia/
│   │      │   ├── fossasia2016.json
│   │      │   ├── fossasia2017.json
│   │      │   ├── fossasia2018.json
│   │      │   ├── fossasia2019.json
│   │      │   └── fossasia2020.json
│   │      ├── gsoc_org/
│   │      │   ├── gsoc2020org.json
│   │      │   ├── gsoc2021org.json
│   │      │   ├── gsoc2022org.json
│   │      │   ├── gsoc2023org.json
│   │      │   └── gsoc2024org.json
│   │      ├── gsoc_projects/
│   │      │   ├── gsoc2020projects.json
│   │      │   ├── gsoc2021projects.json
│   │      │   ├── gsoc2022projects.json
│   │      │   ├── gsoc2023projects.json
│   │      │   └── gsoc2024projects.json
│   │      ├── gsod/
│   │      │   ├── gsod2019.json
│   │      │   ├── gsod2020.json
│   │      │   ├── gsod2021.json
│   │      │   ├── gsod2022.json
│   │      │   └── gsod2023.json
│   │      ├── gssoc/
│   │      │   ├── gssoc2021.json
│   │      │   ├── gssoc2022.json
│   │      │   ├── gssoc2023.json
│   │      │   └── gssoc2024.json
│   │      ├── hyperledger/
│   │      │   ├── hyperledger2021.json
│   │      │   ├── hyperledger2022.json
│   │      │   ├── hyperledger2023.json
│   │      │   └── hyperledger2024.json
│   │      ├── linux_foundation/
│   │      │   └── linux_foundation.json
│   │      ├── osoc/
│   │      │   ├── osoc2021.json
│   │      │   └── osoc2022.json
│   │      ├── outreachy/
│   │      │   ├── outreachy2021.json
│   │      │   ├── outreachy2022.json
│   │      │   ├── outreachy2023.json
│   │      │   └── outreachy2024.json
│   │      ├── redux/
│   │      │   └── redux.json   
│   │      ├── sob/
│   │      │   ├── sob2021.json
│   │      │   ├── sob2022.json
│   │      │   └── sob2023.json
│   │      ├── sokde/
│   │      │   ├── sokde2022.json
│   │      │   ├── sokde2023.json
│   │      │   └── sokde2024.json
│   │      ├── swoc/
│   │      │   ├── swoc2020.json
│   │      │   ├── swoc2021.json
│   │      │   ├── swoc2022.json
│   │      │   └── swoc2023.json
│   │      ├── wob/
│   │      │   └── wob2024.json
│   │      └── woc/
│   │          └── woc.json
│   ├── Google_season_of_docs.png
│   ├── OpSo_about.png
│   ├── OpSo_main.png
│   ├── coding_ninja_swag.png
│   ├── fossasia.png
│   ├── girlscript_logo.png
│   ├── git_campus_logo.png
│   ├── github_swag.png
│   ├── gsoc_logo.png
│   ├── hacktoberfest.png
│   ├── hyperledger.png
│   ├── landing.webp
│   ├── linux_foundation_logo.png
│   ├── mlh_logo.jpg
│   ├── no-results.png
│   ├── open_summer_of_code.png
│   ├── outreachy.png
│   ├── participation_certificate.png
│   ├── redox.png
│   ├── sokde.png
│   ├── splash_main.png
│   ├── summer_of_bitcoin_logo.png
│   ├── swoc.png
│   └── xyz_domain.png
│   
├── ios/
│   ├── Flutter/
│   ├── Runner.xcodeproj/
│   │   ├── project.xcworkspace/
│   │   │   ├── xcshareddata/
│   │   │   │   ├── IDEWorkspaceChecks.plist
│   │   │   │   └── WorkspaceSettings.xcsettings
│   │   │   ├── contents.xcworkspace
│   │   ├── xcshareddata/xcschemes/
│   │   │    └── Runner.xcscheme
│   │   └── project.pbxproj
│   ├── Runner.xcworkspace/
│   │   ├── xcshareddata/
│   │   │   ├── IDEWorkspaceChecks.plist
│   │   │   └── WorkspaceSettings.xcsettings
│   │   └── contents.xcworkspace
│   ├── Runner/
│   │   ├── Assets.xcassets/
│   │   │   ├── AppIcon.appiconset/
│   │   │   └── LaunchImage.imageset/
│   │   ├── Base.lproj/
│   │   │   ├── LaunchScreen.storyboard
│   │   │   └── Main.storyboard
│   │   ├── AppDelegate.swift
│   │   ├── Info.plist
│   │   └── Runner-Bridging-Header.h
│   ├── RunnerTests/
│   │   └── RunnerTests.swift
│   ├── .gitignore
│   └── Podfile
│   
├── lib/
│   ├── modals/
│   │   ├── GSoC/
│   │   │   └── GSoc.dart
│   │   ├── gsod/
│   │   │   ├── gsod_modal_new.dart
│   │   │   └── gsod_modal_old.dart
│   │   ├── book_mark_model.dart
│   │   ├── fossasia_project_modal.dart
│   │   ├── gssoc_project_modal.dart
│   │   ├── hyperledger_modal.dart
│   │   ├── linux_foundation_modal.dart
│   │   ├── osoc_modal.dart
│   │   ├── outreachy_project_modal.dart
│   │   ├── rsoc_project_modal.dart
│   │   ├── sob_project_modal.dart
│   │   ├── sokde_project_modal.dart
│   │   └── swoc_project_modal.dart
│   ├── programs screen/
│   │   ├── fossasia.dart
│   │   ├── girl_script.dart
│   │   ├── github_campus.dart
│   │   ├── google_season_of_docs_screen.dart
│   │   ├── google_summer_of_code_screen.dart
│   │   ├── hacktoberfest_screen.dart
│   │   ├── hyperledger.dart
│   │   ├── linux_foundation.dart
│   │   ├── major_league_hacking_fellowship.dart
│   │   ├── open_summer_of_code.dart
│   │   ├── outreachy.dart
│   │   ├── redox.dart
│   │   ├── season_of_kde.dart
│   │   ├── social_winter_of_code.dart
│   │   └── summer_of_bitcoin.dart
│   ├── programs_info_pages/
│   │   ├── fossasia_info.dart
│   │   ├── gsoc_info.dart
│   │   ├── gsod_info.dart
│   │   ├── gssoc_info.dart
│   │   ├── hyperledger_info.dart
│   │   ├── linux_info.dart
│   │   ├── osoc_info.dart
│   │   ├── outreachy_info.dart
│   │   ├── rsoc_info.dart
│   │   ├── sob_info.dart
│   │   ├── sokde_info.dart
│   │   └── swoc_info.dart
│   ├── services/
│   │   ├── ApiService.dart
│   │   └── notificationService.dart
│   ├── widgets/
│   │   ├── gsoc/
│   │   │   └── GsocProjectWidget.dart
│   │   ├── gsod/
│   │   │   ├── gsod_project_widget_new.dart
│   │   │   └── gsod_project_widget_old.dart
│   │   ├── SearchandFilterWidget.dart
│   │   ├── book_mark_screen.dart
│   │   ├── event_card.dart
│   │   ├── faq.dart
│   │   ├── fossaisa_project_widget.dart
│   │   ├── gssoc_project_widget.dart
│   │   ├── hyperledger_widget.dart
│   │   ├── linux_foundation_widget.dart
│   │   ├── osoc_widget.dart
│   │   ├── outreachy_project_widget.dart
│   │   ├── rsoc_project_widget.dart
│   │   ├── small_year_button.dart
│   │   ├── sob_project_widget.dart
│   │   ├── sokde_project_widget.dart
│   │   ├── swoc_project_widget.dart
│   │   └── year_button.dart
│   ├── ChatBotPage.dart
│   ├── about.dart
│   ├── bar.dart
│   ├── home_page.dart
│   ├── landing_page.dart
│   ├── learning_path.dart
│   ├── main.dart
│   ├── opso_timeline.dart
│   └── splash_screen.dart
│   
├── linux/
│   ├── flutter/
│   │   ├── CMakeLists.txt
│   │   ├── generated_plugin_registrant.cc
│   │   ├── generated_plugin_registrant.h
│   │   └── generated_plugins.cmake
│   ├── .gitignore
│   ├── CMakeLists.txt
│   ├── main.cc
│   ├── my_application.cc
│   └── my_application.h
│   
├── macos/
│   ├── Flutter/
│   │   ├── Flutter-Debug.xcconfig
│   │   ├── Flutter-Release.xcconfig
│   │   └── GeneratedPluginRegistrant.swift
│   ├── Runner.xcodeproj
│   │   ├── project.xcworkspace/xcshareddata/
│   │   │   └── IDEWorkspaceChecks.plist
│   │   ├── xcshareddata/xcschemes/
│   │   │   └── Runner.xcscheme
│   │   └── project.pbxproj
│   ├── Runner.xcworkspace/
│   │   ├── xcshareddata/
│   │   │   └── IDEWorkspaceChecks.plist
│   │   └── contents.xcworkspacedata
│   ├── Runner/
│   │   ├── Assets.xcassets/AppIcon.appiconset/
│   │   │   ├── Contents.json
│   │   │   ├── app_icon_1024.png
│   │   │   ├── app_icon_128.png
│   │   │   ├── app_icon_16.png
│   │   │   ├── app_icon_256.png
│   │   │   ├── app_icon_32.png
│   │   │   ├── app_icon_512.png
│   │   │   └── app_icon_64.png
│   │   ├── Base.lproj/
│   │   │   └── MainMenu.xib
│   │   ├── Configs/
│   │   │   ├── AppInfo.xcconfig
│   │   │   ├── Debug.xcconfig
│   │   │   ├── Release.xcconfig
│   │   │   └── Warnings.xcconfig
│   │   ├── AppDelegate.swift
│   │   ├── DebugProfile.entitlements
│   │   ├── Info.plist
│   │   ├── MainFlutterWindow.swift
│   │   └── Release.entitlements
│   ├── RunnerTests/
│   │   └── RunnerTests.swift
│   ├── .gitignore
│   └── Podfile
│   
├── test/
│   └── widget_test.dart
│   
├── web/
│   ├── icons/
│   │   ├── Icon-192.png
│   │   ├── Icon-512.png
│   │   ├── Icon-maskable-192.png
│   │   └── Icon-maskable-512.png
│   ├── favicon.png
│   ├── index.html
│   └── manifest.json
│   
├── windows/
│   ├── flutter/
│   │   ├── CMakeLists.txt
│   │   ├── generated_plugin_registrant.cc
│   │   ├── generated_plugin_registrant.h
│   │   └── generated_plugins.cmake
│   ├── runner/
│   │   ├── resources/
│   │   │   └── app_icon.ico
│   │   ├── CMakeLists.txt
│   │   ├── Runner.rc
│   │   ├── flutter_window.cpp
│   │   ├── flutter_window.h
│   │   ├── main.cpp
│   │   ├── resource.h
│   │   ├── runner.exe.manifest
│   │   ├── utils.cpp
│   │   ├── utils.h
│   │   ├── win32_window.cpp
│   │   └── win32_window.h
│   ├── .gitignore
│   └── CMakeLists.txt
│
├── .gitignore
├── .metadata
├── CONTRIBUTING.md
├── Code_of_Conduct.md
├── LEARN.md
├── LICENSE
├── Project_Structure.md
├── README.md
├── analysis_options.yaml
├── build.gradle
├── local.properties
├── pubspec.lock
└── pubspec.yaml
```

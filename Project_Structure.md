## Project Structure

```
.github
├── ISSUE_TEMPLATE
│   ├── bug.yml               
│   ├── documentation.yml      
│   └── feature.yml            
├── workflows
│   ├── auto-comment-on-issue.yml     
│   ├── auto-comment-on-pr-merge.yml   
│   ├── auto-comment-pr-raise.yml     
│   ├── autocomment-iss-close.yml     
│   ├── close-old-pr.yml              
│   ├── codeql.yml                     
│   ├── dependabot.yml                
│   └── issue-assign.yml              
└── pull_request_template.md

.gradle
├── 8.0.2
│   ├── checksums
│   │   └── checksums.lock                   
│   ├── fileChanges
│   │   └── last-build.bin                  
│   ├── fileHashes
│   │   └── fileHashes.lock                  
│   └── gc.properties                  
├── 8.1.1
│   ├── checksums
│   │   └── checksums.lock                  
│   ├── dependencies-accessors
│   │   ├── dependencies-accessors.lock     
│   │   └── gc.properties                   
│   ├── executionHistory
│   │   └── executionHistory.lock                     
│   ├── fileChanges
│   │   └── last-build.bin                     
│   ├── fileHashes
│   │   └── fileHashes.lock
│   └── gc.properties                


android/
├── app/
│   └── src/
│       ├── debug/
│       │   └── AndroidManifest.xml
│      ├── main/
│       │   ├── kotlin/
│       │   │   └── com/
│       │   │       └── example/
│       │   │           └── opso/
│       │   │               └── MainActivity.kt
│       │   ├── res/
│       │   │   ├── drawable-v21/
│       │   │   │   └── launch_background.xml
│       │   │   ├── drawable/
│       │   │   │   └── launch_background.xml
│       │   │   ├── mipmap-hdpi/
│       │   │   │   └── ic_launcher.png
│       │   │   ├── mipmap-mdpi/
│       │   │   │   └── ic_launcher.png
│       │   │   ├── mipmap-xhdpi/
│       │   │   │   └── ic_launcher.png
│       │   │   ├── mipmap-xxhdpi/
│       │   │   │   └── ic_launcher.png
│       │   │   ├── mipmap-xxxhdpi/
│       │   │   │   └── ic_launcher.png
│       │   │   ├── values-night/
│       │   │   │   └── styles.xml
│       │   │   └── values/
│       │   │       └── styles.xml
│       │   └── AndroidManifest.xml
│       ├── profile/
│       │   └── AndroidManifest.xml
│   └── build.gradle
│
└──gradle/
    ├── wrapper/
    │    └── gradle-wrapper.properties
    ├── .gitignore
    ├── build.gradle
    ├── gradle.properties
    └── settings.gradle

assets/
├── projects/
│      ├── fossasia/
│      │   ├── fossasia2016.json
│      │   ├── fossasia2017.json
│      │   ├── fossasia2018.json
│      │   ├── fossasia2019.json
│      │   └── fossasia2020.json
│      ├── gsoc_org/
│      │   ├── gsoc2020org.json
│      │   ├── gsoc2021org.json
│      │   ├── gsoc2022org.json
│      │   ├── gsoc2023org.json
│      │   └── gsoc2024org.json
│      ├── gsoc_projects/
│      │   ├── gsoc2020projects.json
│      │   ├── gsoc2021projects.json
│      │   ├── gsoc2022projects.json
│      │   ├── gsoc2023projects.json
│      │   └── gsoc2024projects.json
│      ├── gsod/
│      │   ├── gsod2019.json
│      │   ├── gsod2020.json
│      │   ├── gsod2021.json
│      │   ├── gsod2022.json
│      │   └── gsod2023.json
│      ├── gssoc/
│      │   ├── gssoc2021.json
│      │   ├── gssoc2022.json
│      │   ├── gssoc2023.json
│      │   └── gssoc2024.json
│      ├── hyperledger/
│      │   ├── hyperledger2021.json
│      │   ├── hyperledger2022.json
│      │   ├── hyperledger2023.json
│      │   └── hyperledger2024.json
│      ├── linux_foundation/
│      │   └── linux_foundation.json
│      ├── osoc/
│      │   ├── osoc2021.json
│      │   └── osoc2022.json
│      ├── outreachy/
│      │   ├── outreachy2021.json
│      │   ├── outreachy2022.json
│      │   ├── outreachy2023.json
│      │   └── outreachy2024.json
│      ├── redux/
│      │   └── redux.json   
│      ├── sob/
│      │   ├── sob2021.json
│      │   ├── sob2022.json
│      │   └── sob2023.json
│      ├── sokde/
│      │   ├── sokde2022.json
│      │   ├── sokde2023.json
│      │   └── sokde2024.json
│      ├── swoc/
│      │   ├── swoc2020.json
│      │   ├── swoc2021.json
│      │   ├── swoc2022.json
│      │   └── swoc2023.json
│      ├── wob/
│      │   └── wob2024.json
│      └── woc/
│          └── woc.json
├── Google_season_of_docs.png
├── OpSo_about.png
├── OpSo_main.png
├── coding_ninja_swag.png
├── fossasia.png
├── girlscript_logo.png
├── git_campus_logo.png
├── github_swag.png
├── gsoc_logo.png
├── hacktoberfest.png
├── hyperledger.png
├── landing.webp
├── linux_foundation_logo.png
├── mlh_logo.jpg
├── no-results.png
├── open_summer_of_code.png
├── outreachy.png
├── participation_certificate.png
├── redox.png
├── sokde.png
├── splash_main.png
├── summer_of_bitcoin_logo.png
├── swoc.png
└── xyz_domain.png

ios/
├── Flutter/
├── Runner.xcodeproj/
│   ├── project.xcworkspace/
│   │   ├── xcshareddata/
│   │   │   ├── IDEWorkspaceChecks.plist
│   │   │   └── WorkspaceSettings.xcsettings
│   │   ├── contents.xcworkspace
│   ├── xcshareddata/xcschemes/
│   │    └── Runner.xcscheme
│   └── project.pbxproj
├── Runner.xcworkspace/
│   ├── xcshareddata/
│   │   ├── IDEWorkspaceChecks.plist
│   │   └── WorkspaceSettings.xcsettings
│   └── contents.xcworkspace
├── Runner/
│   ├── Assets.xcassets/
│   │   ├── AppIcon.appiconset/
│   │   └── LaunchImage.imageset/
│   ├── Base.lproj/
│   │   ├── LaunchScreen.storyboard
│   │   └── Main.storyboard
│   ├── AppDelegate.swift
│   ├── Info.plist
│   └── Runner-Bridging-Header.h
├── RunnerTests/
│   └── RunnerTests.swift
├── .gitignore
└── Podfile

lib/
├── modals/
├── programs screen/
├── programs_info_pages/
├── services/
├── widgets/
├── ChatBotPage.dart
├── about.dart
├── bar.dart
├── home_page.dart
├── landing_page.dart
├── learning_path.dart
├── main.dart
├── opso_timeline.dart
└── splash_screen.dart

linux/
├── flutter/
│   ├── CMakeLists.txt
│   ├── generated_plugin_registrant.cc
│   ├── generated_plugin_registrant.h
│   ├── generated_plugins.cmake
├── .gitignore
├── CMakeLists.txt
├── main.cc
├── my_application.cc
└── my_application.h

macos/
├── Flutter
├── Runner.xcodeproj
├── Runner.xcworkspace
├── Runner
├── RunnerTests
├── .gitignore
└── Podfile

test/
└── widget_test.dart

web/
├── icons/
│   ├── Icon-192.png
│   ├── Icon-512.png
│   ├── Icon-maskable-192.png
│   ├── Icon-maskable-512.png
├── favicon.png
├── index.html
└── manifest.json

windows/
├── flutter/
├── runner/
├── .gitignore
└── CMakeLists.txt
```

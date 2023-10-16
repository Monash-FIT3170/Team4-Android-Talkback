# Teach Me TalkBack

## Overview

Teach Me TalkBack is an iOS and Android application which empowers people who are blind or have low vision to effectively interact with their iOS and Android devices. Our mission has been to give these people a user-friendly and accessibility-first experience that allows them to progress at their own pace in comprehensive tutorials, practical challenges, and engaging mini-games.

Having inherited Teach Me TalkBack, our task was to further develop the application. We identified making the application accessible to even more users was a top priority. The developments we made were intended to extend the application's reach - making it compatible in an array of languages and a new operating system.

We further added to the existing application by adding more modules and challenges. Notably, we included a calculator and phone tutorial and challenges, and a sandbox mode which provides feedback on user gestures.

Our ultimate goal creating this application was to make the digital world more inclusive and accessible to a wider range of people.

### High-level view

Please refer to the **Potential Solution Architecture** document.

### Risks

Please refer to the **Risk Register** document.

### Communication

A Discord server was used to facilitate communication in this project between team members and the project supervisor.

The server was set up to have a general chatroom, as well as subteam and role-based chatroom. Each of these divisions had text and voice chat rooms. Meetings were often organised and conducted through this medium.

The codebase for the application was stored on a git repository - which details and contains a comprehensive history of the project throughout its 24 week development. It also contains all relevant files concerning the application.

For the Discord server link and access to the git repository please contact the relevant people in charge.

## Getting Started

### Hardware Requirements

Please refer to the **Potential Solution Architecture** document.

#### Phone

A physical device is required for future development on the application. Real devices can exhibit different behaviours that would otherwise go unnoticed if solely reliant on emulators. It is suggested that the development team has at least one Android device and one Apple device to test the application.

It is recommended that the device used should run Android 9.0 (Pie) or later because TalkBack can be updated via the Play Store.

Note that if the Android device does not have TalkBack preinstalled with the OS, the Android Accessibility Suite can be downloaded from the Play Store. This allows all Android users to access TalkBack.

#### Development Computer

- Computer which can run the latest version of Android Studios
- Computer which can run the latest version of Xcode (Only for MacOS)
- Recommended IDE: Visual Studio Code (VS Code)

### Development Requirements

#### SDK and Emulator

For development, the following are required:

- The latest version of Android Studio, Flutter, Xcode
- An Android SDK level above 26
- An Android device running Android 8.0 (Oreo) or later
- An iOS emulator running iOS 16 or later

We strongly recommend, however, that you use the most up-to-date versions of each operating system, IDEs, and languages. This ensures improved security, bug fixes, enhanced features, performance optimizations, and access to the latest tools and libraries, ensuring better stability, compatibility, and the ability to leverage the latest advancements in the technology stack.

#### TalkBack

There are multiple TalkBack versions available. Since Android 9.0, TalkBack is no longer tied to the Android version you are running and is instead updated independently as an app. Using the latest version should allow you to work with new changes as they are released, as most old behaviours and gestures are still maintained in later versions.

Some minor changes have occurred, and you should consult Google's changelog for details. Beware; you cannot trivially check the TalkBack version being used.

#### TalkBack in the Emulator

TalkBack is not installed in any emulator image provided in Android Studio. You must manually sideload a TalkBack version. For this, we recommend installing the Android Accessibility Suite from the Play Store. There are no modern stand-alone versions of TalkBack available to download.

#### VoiceOver

Like TalkBack, VoiceOver also has different versions. However, the accessibility tool is updated alongside the operating system updates - and not externally through an application. Each update often contains new features, bug fixes, and improvements to enhance accessibility for users with visual impairments.

We recommend using the latest iOS for development for the most up-to-date version of VoiceOver.

#### VoiceOver in the Emulator

Unlike TalkBack, VoiceOver does not require the user to install it on an emulator, as it is a part of the operating system. Therefore, we suggest using an iPhone emulator which runs the latest iOS version to replicate the most current version of VoiceOver.

### Running the Project

#### Installations

The application was developed in the language Flutter, using VS Code as the IDE. After cloning the project folder from Git, these are the recommended steps to run the application.

Firstly, it is necessary to install Flutter and Dart on your device. The instructions to do this can be found on the official Flutter websites, found here: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install).

Then, install the Flutter Extension for VS Code, which can be done from the Extensions marketplace. You may also be required to download all the dependencies for the application. This can be done by navigating to the root directory of the project from command line/terminal and including the instruction: flutter pub get.

Next, open the project in VS Code. The scripts which the team developed which contain the functionality of the application can be found in the _application/lib_ directory. The _main.dart_ file contains the main facilitating script. Each of the specific tutorials can be found in the _application/lib/tutorial_ directory - with each tutorial having its own directory named after itself.

##### Running the Application on an Emulator

Running the project on an emulator requires the installation of Android Studios and Xcode (for MacOS users only).

In Android Studios, users can select a device which runs Android. We advise that you select an emulator which meets the device requirements listed above. To download an Android emulator, navigate to the 'Device Manager' in the toolbar at the top of a project. Select '_Create device_', and select the device which you wish to download. You have now installed your Android emulator.

iOS emulators can only be installed by users with a device running MacOS. If using an Apple device, download Xcode from the App Store. Once installed, open Xcode and navigate to 'Preferences' and select the 'Components' tab. Then, install the simulator version you want to use. Again, we recommend that the chosen simulator meets the requirements listed earlier.

To run Teach Me TalkBack from VS Code, open the project in the IDE. Listed on the toolbar in the bottom right corner, you can select a device. When a device is selected, you can divide which emulator to launch the project on. Run the _main.dart_ file, which will launch the project in its current state on the selected emulator.

##### Running the Application on a Physical Device

To run the application on a physical device, connect the phone to the computer via USB. You may be required to enable USB debugging in the device's developer options.

Similar to running the emulator, select the physical device from options on the toolbar located in the bottom right corner of the IDE. Then proceed to run the application from VS Code - which will compile and install it to the connected device. Note that when connecting an iOS device, Xcode must be installed on the computer.

##### Enabling TalkBack and VoiceOver

For both operating systems, TalkBack/VoiceOver must be enabled. For Android devices - in the emulator, navigate to the Play Store and install the Android Accessibility Suite. Once downloaded, open _Settings_ and search for 'TalkBack'. The TalkBack option will then appear. When clicked, you are taken to a screen with a toggle switch - allowing you to turn on TalkBack.

For iOS devices, the user must navigate to _Settings_. Swipe up to reveal a search bar and type in 'VoiceOver'. Select the top result and switch the toggle to on to enable VoiceOver on the device.

After enabling TalkBack/VoiceOver, navigate to the Teach Me TalkBack application to simulate the application on the device.

## Current Issue, Bugs, and Limitations

### Issues,Bugs and Limitations

In modules featuring the video player widget, a recurring issue arises where the screen reader intermittently fails to select the embedded video. This limitation poses challenges for users attempting to access video content within affected modules.

The notification challenge module presents a dual set of issues. Firstly, notifications are not consistently dispatched to users. Secondly, even when notifications are received, clicking on them may not reliably advance the module. These irregularities can lead to users missing crucial information and experiencing disruptions in module progression.

An inconsistency is observed in the response of VoiceOver and TalkBack to identical instructions within the Flutter framework. Specifically, screen readers, at times, truncate semantics, resulting in incomplete information. This divergence in behaviour can create an inconsistent user experience and potential confusion.

The behaviour of two-finger gestures on the emulator contrasts starkly with their performance on physical devices. While the emulator showcases flawless gesture behaviour, this perfection is not replicated on real devices. This discrepancy between expected and actual outcomes may affect user interaction, particularly on physical devices.

Issues related to semantics order and text reading order have been identified. Specifically, forcing the screen to read specific text at certain times can introduce problems. Furthermore, this inconsistency is not confined to a specific operating system, manifesting differently between iOS and Android platforms.

The process of packaging the iOS application is hindered by developer limitations. These constraints may introduce complications in the deployment and distribution of the iOS version of the application.

Concerns have been raised regarding language translation issues. The inherent lack of context in translations performed by ChatGPT may lead to inaccuracies. To address this, it is proposed to add metadata, such as '\<helpful context\>', to English translation entries while excluding this metadata in the actual app's display.

The gesture minigame encounters accessibility challenges when the screen reader is enabled. The screen reader intercepts gestures before the app can process them, resulting in compromised functionality. This adversely affects the accessibility of the gesture minigame for users relying on screen readers.

## Additional Notes for Future Developers

##### Tech Stack

The application is coded in Flutter because it is a single-language solution to cross platform functionality for iOS and Android. We used Visual Studio Code to develop the application due to its cohesive compatibility with Flutter. It still requires the user to have Xcode and Android Studio installed on their device for access to emulators. The emulators, however, can be run from VS Code. See more in the **Tech Stack Review** document for justifications of tech stack decisions.

##### Multi-Language Accessibility

The multi-language accessibility feature is programmed so that the application language is the same as the device's setting. If the language set on the user's device is not compatible with the languages our application is available in, then the application will default to English. Be mindful that languages which read in a different direction (i.e., right-to-left) have inverted gestures in TalkBack/VoiceOver.

##### TalkBack Emulator

The TalkBack functionality in the Android emulator differs notably from its behavior on a physical phone. Specifically, the gesture set exhibits slight variations, and the typical movement on emulators is influenced by reading modes. In contrast, physical phones feature their own navigation gestures that incorporate reading modes.

Moreover, distinct characteristics such as audio cues, including clicks and list-item ticks that change in pitch, are absent when using the emulator. Additionally, the absence of haptic feedback, a crucial element employed by most gestures, further contributes to the divergent experience compared to using TalkBack on an actual device.

## Glossary

**Android -** A common operating system used on smartphones.

**Android Studio -** The official integrated development environment (IDE) for Android app development, providing tools and resources to design, code, test, and debug Android applications.

**Discord -** A communication platform that offers text, voice, and video chat, primarily used by gamers and communities for real-time communication.

**Emulator -** Software that enables a computer system to imitate the behaviour of another system, often used to run applications or programs designed for a different hardware or software environment.

**Flutter -** An open-source UI software development toolkit created by Google, used to build natively compiled applications for mobile, web, and desktop from a single codebase.

**Git -** A distributed version control system used for tracking changes in source code during software development, allowing collaboration among developers and efficient management of codebase history.

**iOS -** A common operating system used on smartphones, specifically iPhones.

**TalkBack -** Google Talkback is an accessibility service for the Android operating system that helps blind and visually impaired users to interact with their devices.

**Visual Studio Code -** A free and popular source-code editor developed by Microsoft, known for its lightweight design and strong support for various programming languages.

**VoiceOver -** A screen reader that describes aloud what appears on screens in iOS operating systems.

**Xcode -** Apple's IDE used for creating software for iOS, macOS, watchOS, and tvOS platforms.

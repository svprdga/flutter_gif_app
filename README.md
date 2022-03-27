# Flutter Giphy Clone - sample project

This is a Flutter sample code to demonstrate how to consume the [Giphy API](https://developers.giphy.com/) and display their GIFs.

You can find the related video in [Youtube](https://youtu.be/bczkyrHrrek) and [Odysee](https://odysee.com/@svprdga:d/flutter-giphy-clone-speed-code).

## Instructions

Follow these instructions to run this sample:

1. Create a file `lib/keys.dart` with the following content, substituting the string values with your own Giphy API keys:

```dart
import 'dart:io';

final giphyApiKey = Platform.isAndroid
    ? 'your-android-key'
    : 'your-iOS-key';
```

2. The Giphy API requires to give attribution, this project uses two of their images to accomplish that. You can find more information on their [Quick Start Guide](https://developers.giphy.com/docs/api#quick-start-guide). Follow the link that they provide to download the official attribution images and then copy the following files (path on the left) to their destination within the project (path on the right):

- `/Static Logos/Large/Dark Backgrounds/Poweredby_640px-Black_HorizText.png` => `assets/images/img_giphy_dark.png`
- `/Static Logos/Large/Light Backgrounds/Poweredby_640px-White_HorizText.png` => `assets/images/img_giphy_light.png`

(*) The path or name of the files may not be exactly what is indicated here.
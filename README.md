# StoreChecker

This Flutter plugin is useful to find the origin of installed apk/ipa which is made available for download.
**Android**: It's very common to have Android applications republished on alternate markets or their APKs made available for download. The plugin detects whether app is installed from local source or Play Store or other stores
**iOS**: Detects whether we have installed from TestFlight Beta or App Store build

# Usage
You can use the StoreChecker to find the origin of apk/ipa. This works both on iOS and Android.
Add this to your package's pubspec.yaml file:
dependencies:
  store_checker: ^0.0.1

```dart
import 'package:store_checker/store_checker.dart';

Source installationSource = await StoreChecker.getSource;

String source = "";
switch(installationSource){
        case Source.IS_INSTALLED_FROM_PLAY_STORE:
          source = "Play Store";
          break;
        case Source.IS_INSTALLED_FROM_LOCAL_SOURCE:
          source = "Local Source";  //For example: Installed apk using adb commands, side loading or cloud
          break;
        case Source.IS_INSTALLED_FROM_OTHER_STORE:
          source = "Other Store";  //For example: Amazon app store
          break;
        case Source.IS_INSTALLED_FROM_APP_STORE:
          source = "App Store";
          break;
        case Source.IS_INSTALLED_FROM_TEST_FLIGHT:
          source = "Test Flight";
          break;
        case Source.UNKNOWN:
          source = "Unknown source";
          break;
      }
```

## Issues and feedback

Please file [issues](https://github.com/ravitejaavv/store_checker/issues) to send feedback or report a bug. Thank you!


## License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

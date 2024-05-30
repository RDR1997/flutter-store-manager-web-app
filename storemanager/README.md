# StoreManager

## Prerequisites
- Flutter 3.7.12
- Dart 2.19.6
  
## Steps to build Android APK
### 1. Replace the back-end api url

- First, locate the Environment.dart file here /lib/Models/Environment.dart.
- In Environment.dart file, replace the back-end api server and api links, that assigns to "api_server" and "api" variables.

  For Example:
  ```
    class Environment {
      final api_server = "https://storemanager-iye42qcs2a-el.a.run.app/";
      final api = "https://storemanager-iye42qcs2a-el.a.run.app/api";
    }
  ```

### 2. Run the following command to build android apk
  ```
    flutter build apk
  ```

# Level 1
shared_preferences - Verified publisher flutter.dev, last release October 2026, all six platforms, 160 points, BSD-3-Clause license, has dependencies.

flutter_secure_storage - Verified publisher steenbakker.dev, last release September 2026, all six platforms, 160 points, BSD-3-Clause license, has dependencies.

path_provider - Verified publisher flutter.dev, last release June 2026, five platforms (no web), 160 points, BSD-3-Clause license, has dependencies.

image_picker - Verified publisher flutter.dev, last release October 2026, all six platforms, 160 points, Apache-2.0 and BSD-3-Clause license, has dependencies.

permission_handler - Verified publisher baseflow.com, last release September 2026, four platforms (no Linux and macOS), 160 points, MIT license, has dependencies.

url_launcher - Verified publisher flutter.dev, last release October 2026, all six platforms, 160 points, BSD-3-Clause license, has dependencies.

The version that was resolved for "http" is "1.6.0" inside pubspec.lock.\
^1.2.0 would accept versions higher than from 1.2.0 all the way up to 2.0.0 excluding.\
pubspec.lock is needed to save exact versions of external packages installed, while pubspec.yaml specifies the appropriate range for that package version.
The outdated package "cupertino_icons" wasn't resolved as the latest version because its latest version is a major update.

# Level 3
prefs.setString('token', ...) would have put the token into an ordinary
unencrypted app-data file: an XML/preferences file on Android and a plist in
the app's Library folder on iOS. The token would sit there as readable text.
A device backup, anyone with root or a jailbreak, or anyone with a cable and debugging access to a debug build
could be able to read it.

In iOS Keychain, after uninstall items can survive deleting the app,
so after a reinstall the old token may still be there and the user can appear
signed in. 

In Android, after the lock screen is removed the keys protecting the data can
be invalidated when the screen lock is removed or changed, so the stored token
becomes unreadable and the user is signed out unexpectedly.

# Level 5
In iOS it is enough to decline permission one time for it to
recieve permanentlyDenied state.
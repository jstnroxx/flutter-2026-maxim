import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const String _prefsKey = 'avatarPath';
  File? _avatar;

  @override
  void initState() {
    super.initState();

    _restore();
  }

  Future<void> _restore() async {
    final SharedPreferencesAsync prefs = context.read<SharedPreferencesAsync>();
    final String? path = await prefs.getString(_prefsKey);

    if (path == null || !File(path).existsSync()) return;
    if (!mounted) return;

    setState(() => _avatar = File(path));
  }

  Future<void> _pick(ImageSource source) async {
    final SharedPreferencesAsync prefs = context.read<SharedPreferencesAsync>();
    final XFile? picked = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1024,
      imageQuality: 85,
    );

    if (picked == null) return;

    final Directory dir = await getApplicationDocumentsDirectory();
    final File saved = await File(picked.path).copy('${dir.path}/avatar.jpg');

    await prefs.setString(_prefsKey, saved.path);

    if (!mounted) return;
    setState(() => _avatar = saved);
  }

  Future<void> _takePhoto() async {
    final PermissionStatus status = await Permission.camera.request();
    if (!mounted) return;

    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
      case PermissionStatus.provisional:
        await _pick(ImageSource.camera);

      case PermissionStatus.denied:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The camera is needed to take a profile photo.')),
        );

      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        _showSettingsDialog();
    }
  }

  void _showSettingsDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Camera access is off'),
        content: const Text(
          'To take a photo, allow camera access for this app in Settings. '
              'You can still choose a photo from the gallery.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);

              await openAppSettings();
            },
            child: const Text('Open settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 64,
              backgroundImage: _avatar == null ? null : FileImage(_avatar!),
              child: _avatar == null ? const Icon(Icons.person, size: 64) : null,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => _pick(ImageSource.gallery),
              child: const Text('Choose photo'),
            ),
            OutlinedButton(
              onPressed: _takePhoto,
              child: const Text('Take photo'),
            ),
          ],
        ),
      ),
    );
  }
}
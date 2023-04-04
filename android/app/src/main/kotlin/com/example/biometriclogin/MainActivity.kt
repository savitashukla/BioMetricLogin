package com.example.biometriclogin

import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.GeneratedPluginRegistrant.registerWith

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        registerWith(flutterEngine)
    }
}

package com.wayne.flutter_wtrip

import android.os.Bundle
import android.os.PersistableBundle
import androidx.annotation.NonNull;
//import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.example.asr_plugin.AsrPlugin
import io.flutter.app.FlutterActivity

class MainActivity: FlutterActivity() {
//    fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
//    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this));
        AsrPlugin.registerWith(registrarFor("com.example.asr_plugin.AsrPlugin"));
    }

//    private void fun registerSelfPlugin() {
//        AsrPlugin.registerWith(registrarFor("com.example.asr_plugin.AsrPlugin"));
//    }
}

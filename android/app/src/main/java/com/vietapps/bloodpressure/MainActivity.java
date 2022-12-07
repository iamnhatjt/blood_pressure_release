package com.vietapps.bloodpressure;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        flutterEngine.getPlugins().add(new GoogleMobileAdsPlugin());
        super.configureFlutterEngine(flutterEngine);
        final NativeAdFactory factory = new AppNativeAdFactory(getLayoutInflater());
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "appNativeAdFactory", factory);
    }

    @Override
    public void cleanUpFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine);
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "appNativeAdFactory");
    }
}

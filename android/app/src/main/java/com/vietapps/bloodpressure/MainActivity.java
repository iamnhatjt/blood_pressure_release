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
        final NativeAdFactory factorySmall = new AppNativeAdFactory(R.layout.app_native_ads_temp_small,getLayoutInflater());
        final NativeAdFactory factoryMedium = new AppNativeAdFactory(R.layout.app_native_ads,getLayoutInflater());
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "appNativeAdFactorySmall", factorySmall);
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "appNativeAdFactoryMedium", factoryMedium);
    }

    @Override
    public void cleanUpFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine);
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "appNativeAdFactorySmall");
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "appNativeAdFactoryMedium");
    }
}

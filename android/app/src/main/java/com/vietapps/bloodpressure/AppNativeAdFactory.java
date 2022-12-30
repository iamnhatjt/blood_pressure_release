package com.vietapps.bloodpressure;

import android.graphics.drawable.ColorDrawable;
import android.view.LayoutInflater;

import com.google.android.ads.nativetemplates.NativeTemplateStyle;
import com.google.android.ads.nativetemplates.TemplateView;
import com.google.android.gms.ads.nativead.NativeAd;
import com.google.android.gms.ads.nativead.NativeAdView;

import java.util.Map;

import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;

public class AppNativeAdFactory implements NativeAdFactory {
    private final LayoutInflater layoutInflater;

    private final int resource;

    AppNativeAdFactory(int resource, LayoutInflater layoutInflater) {
        this.resource = resource;
        this.layoutInflater = layoutInflater;
    }

    @Override
    public NativeAdView createNativeAd(
            NativeAd nativeAd, Map<String, Object> customOptions) {
        final NativeAdView adView =
                (NativeAdView) layoutInflater.inflate(resource, null);
//        final TextView headlineView = adView.findViewById(R.id.ad_headline);
//        final TextView bodyView = adView.findViewById(R.id.ad_body);
//
//        headlineView.setText(nativeAd.getHeadline());
//        bodyView.setText(nativeAd.getBody());
//
//        adView.setBackgroundColor(Color.YELLOW);
//
//        adView.setNativeAd(nativeAd);
//        adView.setBodyView(bodyView);
//        adView.setHeadlineView(headlineView);

        NativeTemplateStyle styles = new
                NativeTemplateStyle.Builder().withMainBackgroundColor(new ColorDrawable(0xFFFFFFFF)).build();
        TemplateView template = adView.findViewById(R.id.my_template);
        template.setStyles(styles);
        template.setNativeAd(nativeAd);

        return adView;
    }
}

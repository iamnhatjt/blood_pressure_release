import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../common/ads/add_native_ad_manager.dart';

class NativeAdsWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final bool isPremium;
  final String factoryId;
  const NativeAdsWidget(
      {Key? key,
      this.width,
      this.height,
      required this.factoryId,
      required this.isPremium})
      : super(key: key);

  @override
  State<NativeAdsWidget> createState() =>
      _NativeAdsWidgetState();
}

class _NativeAdsWidgetState extends State<NativeAdsWidget> {
  final ValueNotifier<Map> _nativeAdsMap =
      ValueNotifier({});
  @override
  void initState() {
    super.initState();
    if (widget.isPremium) {
      return;
    }
    NativeAd? nativeAd;
    nativeAd = createNativeAd(widget.factoryId, () {
      _nativeAdsMap.value = {
        'ad': nativeAd,
        'widget': Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Container(
            decoration: commonDecoration(),
            alignment: Alignment.center,
            height: widget.height ?? _getHeight(),
            width: widget.width ?? Get.width,
            child: AdWidget(ad: nativeAd!),
          ),
        )
      };
    });
    nativeAd.load();
  }

  double _getHeight() {
    if (widget.factoryId == NativeFactoryId.appNativeAdFactorySmall) {
      return 120.0.sp;
    }
    return 250.0.sp;
  }

  @override
  void dispose() {
    _nativeAdsMap.value['ad']?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map>(
        valueListenable: _nativeAdsMap,
        builder: (context, value, _) {
          return value['widget'] ?? const SizedBox.shrink();
        });
  }
}

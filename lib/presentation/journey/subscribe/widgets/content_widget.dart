import 'package:bloodpressure/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentWidget extends StatelessWidget {
  final String text;

  const ContentWidget({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 32.sp,
      ),
      width: double.infinity,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 16.sp,
                width: 16.sp,
                child: Center(child: Icon(Icons.circle, size: 6.sp,))),
            SizedBox(width: 12.sp,),
            Expanded(child: Text(text, style: ThemeText.bodyText2,))
          ],
        ),
      ),
    );
  }

}
import 'package:bloodpressure/common/mixin/date_time_mixin.dart';
import 'package:bloodpressure/presentation/controller/app_base_controller.dart';
import 'package:bloodpressure/presentation/journey/home/blood_sugar/select_state_mixin.dart';
import 'package:bloodpressure/presentation/widget/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_blood_sugar_dialog/blood_sugar_add_data_dialog.dart';

class BloodSugarController extends AppBaseController
    with DateTimeMixin, SelectStateMixin {
  void onSetAlarm() {
    onSelectTime(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  Future onAddData() async {
    final result = await showAppDialog(context, "", "",
        builder: (ctx) => const BloodSugarAddDataDialog());
    // if (result != null && result) {
    //   _filterBloodPressure();
    // }
  }
}

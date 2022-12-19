import 'package:bloodpressure/common/util/app_notification_local.dart';
import 'package:bloodpressure/common/util/extensions/datetime_extension.dart';
import 'package:bloodpressure/common/util/translation/app_translation.dart';
import 'package:bloodpressure/data/local_repository.dart';
import 'package:bloodpressure/domain/enum/alarm_type.dart';
import 'package:bloodpressure/domain/model/alarm_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class AlarmUseCase {
  final LocalRepository localRepository;

  const AlarmUseCase({required this.localRepository});

  Future<void> addAlarm(AlarmModel alarmModel) async {
    _addAlarmNotification(alarmModel);

    await localRepository.addAlarm(alarmModel);
  }

  Future<void> removeAlarm(int index) async {
    final alarmModel = localRepository.getAlarms()[index];
    for (int i = 0; i < alarmModel.alarmDays!.length; i++) {
      if (alarmModel.alarmDays![i]) {
        final notiId = alarmModel.id.hashCode + i + 1;
        await AppNotificationLocal.cancelScheduleNotification(notiId);
      }
    }
    await localRepository.removeAlarm(index);
  }

  Future<void> updateAlarm(int index, AlarmModel alarmModel) async {
    await localRepository.updateAlarm(index, alarmModel);
    for (int i = 0; i < alarmModel.alarmDays!.length; i++) {
      final notiId = alarmModel.id.hashCode + i + 1;
      await AppNotificationLocal.cancelScheduleNotification(notiId);
    }
    _addAlarmNotification(alarmModel);
    AppNotificationLocal.cancelScheduleNotification(alarmModel.id.hashCode);
  }

  Future<List<AlarmModel>> getAlarms() async {
    return localRepository.getAlarms();
  }

  void _addAlarmNotification(AlarmModel alarmModel) async {
    for (int index = 0; index < alarmModel.alarmDays!.length; index++) {
      final bool isSelected = alarmModel.alarmDays![index];
      if (isSelected) {
        final int weekday = index + 1;
        final currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
        final currentLocation = tz.getLocation(currentTimeZone);
        final DateTime tzNow =
            tz.TZDateTime.now(tz.getLocation(currentTimeZone));
        final nextWeekDay = tzNow.next(weekday);
        final scheduledDate = tz.TZDateTime(
            currentLocation,
            nextWeekDay.year,
            nextWeekDay.month,
            nextWeekDay.day,
            alarmModel.time!.hour,
            alarmModel.time!.minute);
        final androidBitMap =
            await AppNotificationLocal.getImageBytes(alarmModel.type!.icon);
        AppNotificationLocal.setupNotification(
          title: TranslationConstants.trackYourHealth.tr,
          content: alarmModel.type!.trNotiDes,
          scheduleDateTime: scheduledDate,
          notiId: alarmModel.id.hashCode + index + 1,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          androidIconPath: alarmModel.type!.androidIcon,
          largeIcon: androidBitMap,
        );
      }
    }
  }
}

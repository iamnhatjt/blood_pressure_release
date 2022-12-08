class HeartRateModel {
  int? timeStamp;
  int? value;

  HeartRateModel({
    this.timeStamp,
    this.value,
  });

  HeartRateModel.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'] as int?;
    value = json['value'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['timeStamp'] = timeStamp;
    json['value'] = value;
    return json;
  }
}

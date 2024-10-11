class AdminSettingsModel {
  final bool? canPrintReceipt;
  final bool? canDeleteOrder;

  AdminSettingsModel({
    required this.canPrintReceipt,
    required this.canDeleteOrder,
  });

  AdminSettingsModel copyWith({
    bool? canPrintReceipt,
    bool? canDeleteOrder,
  }) {
    return AdminSettingsModel(
      canPrintReceipt: canPrintReceipt ?? this.canPrintReceipt,
      canDeleteOrder: canDeleteOrder ?? this.canDeleteOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'canPrintReceipt': canPrintReceipt,
      'canDeleteOrder': canDeleteOrder,
    };
  }

  factory AdminSettingsModel.fromMap(Map<String, dynamic> map) {
    return AdminSettingsModel(
      canPrintReceipt: map['canPrintReceipt'] as bool?,
      canDeleteOrder: map['canDeleteOrder'] as bool?,
    );
  }
}

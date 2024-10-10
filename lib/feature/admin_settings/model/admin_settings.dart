class AdminSettingsModel {
  final bool canPrintReceipt;

  AdminSettingsModel({
    required this.canPrintReceipt,
  });

  AdminSettingsModel copyWith({
    bool? canPrintReceipt,
  }) {
    return AdminSettingsModel(
      canPrintReceipt: canPrintReceipt ?? this.canPrintReceipt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'canPrintReceipt': canPrintReceipt,
    };
  }

  factory AdminSettingsModel.fromMap(Map<String, dynamic> map) {
    return AdminSettingsModel(
      canPrintReceipt: map['canPrintReceipt'] as bool,
    );
  }

  @override
  String toString() => 'AdminSettingsModel(canPrintReceipt: $canPrintReceipt)';

  @override
  bool operator ==(covariant AdminSettingsModel other) {
    if (identical(this, other)) return true;

    return other.canPrintReceipt == canPrintReceipt;
  }

  @override
  int get hashCode => canPrintReceipt.hashCode;
}

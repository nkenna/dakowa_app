class BankData {
  String? accountNumber;
  String? accountName;
  int? bankId;

  BankData({this.accountNumber, this.accountName, this.bankId});

  BankData.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    bankId = json['bank_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['bank_id'] = this.bankId;
    return data;
  }
}
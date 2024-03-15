// ignore_for_file: prefer_void_to_null

class ServerModel {
  ServerModel({
    required this.result,
  });
  late final List<Result> result;
  
  ServerModel.fromJson(Map<String, dynamic> json){
    result = List.from(json['result']).map((e)=>Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Result {
  Result({
    required this.users,
    required this.config,
    required this.flagName,
    required this.flagImage,
  });
  late final List<Users> users;
  late final String config;
  late final String flagName;
  late final String flagImage;
  
  Result.fromJson(Map<String, dynamic> json){
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
    config = json['config'];
    flagName = json['flag_name'];
    flagImage = json['flag_image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['users'] = users.map((e)=>e.toJson()).toList();
    data['config'] = config;
    data['flag_name'] = flagName;
    data['flag_image'] = flagImage;
    return data;
  }
}

class Users {
  Users({
    required this.id,
    required this.userId,
     this.firstName,
     this.lastName,
    required this.groupId,
    required this.irrWallet,
    required this.digitalWallet,
    required this.giftWallet,
    required this.discount,
     this.apiKey,
     this.ipAddress,
     this.referralId,
     this.referredBy,
     this.lastIp,
     this.lastLogin,
    required this.noVerify,
    required this.gateway,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.password,
    required this.email,
    required this.passString,
    required this.pivot,
  });
  late final int id;
  late final String userId;
  late final Null firstName;
  late final Null lastName;
  late final int groupId;
  late final String irrWallet;
  late final String digitalWallet;
  late final String giftWallet;
  late final String discount;
  late final Null apiKey;
  late final Null ipAddress;
  late final Null referralId;
  late final Null referredBy;
  late final Null lastIp;
  late final Null lastLogin;
  late final String noVerify;
  late final int gateway;
  late final int status;
  late final String createdAt;
  late final String updatedAt;
  late final String password;
  late final String email;
  late final String passString;
  late final Pivot pivot;
  
  Users.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    firstName = null;
    lastName = null;
    groupId = json['group_id'];
    irrWallet = json['irr_wallet'];
    digitalWallet = json['digital_wallet'];
    giftWallet = json['gift_wallet'];
    discount = json['discount'];
    apiKey = null;
    ipAddress = null;
    referralId = null;
    referredBy = null;
    lastIp = null;
    lastLogin = null;
    noVerify = json['noVerify'];
    gateway = json['gateway'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    password = json['password'];
    email = json['email'];
    passString = json['pass_string'];
    pivot = Pivot.fromJson(json['pivot']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['group_id'] = groupId;
    data['irr_wallet'] = irrWallet;
    data['digital_wallet'] = digitalWallet;
    data['gift_wallet'] = giftWallet;
    data['discount'] = discount;
    data['api_key'] = apiKey;
    data['ip_address'] = ipAddress;
    data['referral_id'] = referralId;
    data['referred_by'] = referredBy;
    data['last_ip'] = lastIp;
    data['last_login'] = lastLogin;
    data['noVerify'] = noVerify;
    data['gateway'] = gateway;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['password'] = password;
    data['email'] = email;
    data['pass_string'] = passString;
    data['pivot'] = pivot.toJson();
    return data;
  }
}

class Pivot {
  Pivot({
    required this.serverId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String serverId;
  late final String userId;
  late final String createdAt;
  late final String updatedAt;
  
  Pivot.fromJson(Map<String, dynamic> json){
    serverId = json['server_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['server_id'] = serverId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
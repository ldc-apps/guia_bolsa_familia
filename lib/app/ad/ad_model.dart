import '../enums/ad_type_enum.dart';

class AdConfig {
  static final Map<String, dynamic> configDefault = {
    "activeAll": true,
    "appOpen": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/8460876151",
      "low": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/8460876151",
      },
      "medium": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/6026284508"
      },
      "high": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/9454641044",
      }
    },
    "banner": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/8979998327",
      "low": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/8979998327",
      },
      "medium": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/8377115672"
      },
      "high": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/1293079996",
      }
    },
    "intersticial": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/7020049398",
      "low": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/7020049398",
      },
      "medium": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/1101508302"
      },
      "high": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/2414589978",
      }
    },
    "rewarded": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/6872462317",
      "low": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/6872462317",
      },
      "medium": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/7147794482"
      },
      "high": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/5462628987",
      }
    },
    "intersticialRewarded": {
      "active": true,
      "waterfall": true,
      "default": "ca-app-pub-8419654969814276/4202314360",
      "low": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/4202314360",
      },
      "medium": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/4246298973"
      },
      "high": {
        "active": true,
        "id": "ca-app-pub-8419654969814276/5982299895",
      }
    }
  };

  late bool activeAll;
  late AdObjConfig appOpen;
  late AdObjConfig banner;
  late AdObjConfig intersticial;
  late AdObjConfig rewarded;

  late AdObjConfig intersticialRewarded;

  AdConfig.fromJson(Map<String, dynamic> json) {
    activeAll = json['activeAll'];
    appOpen = json['appOpen'] = AdObjConfig.fromJson(this, json['appOpen']);
    banner = json['banner'] = AdObjConfig.fromJson(this, json['banner']);
    intersticial = AdObjConfig.fromJson(this, json['intersticial']);
    rewarded = AdObjConfig.fromJson(this, json['rewarded']);
    intersticialRewarded =
        AdObjConfig.fromJson(this, json['intersticialRewarded']);
  }

  bool get canShowRewardedAd => rewarded.active || intersticialRewarded.active;

  Map<String, dynamic> toJson() => {
        "activeAll": activeAll,
        "appOpen": appOpen.toJson(),
        "banner": banner.toJson(),
        "intersticial": intersticial.toJson(),
        "rewarded": rewarded.toJson(),
        "intersticialRewarded": intersticialRewarded.toJson(),
      };

  static bool checkWaterFallErrorCode(int code) => code == 3 || code == 9;

  static AdConfig getDefault() => AdConfig.fromJson(configDefault);
}

class AdEnable {
  bool banner = false;
  bool instersticial = false;
  bool openedApp = false;
  bool reward = false;
  bool query = false;

  AdEnable();

  AdEnable.fromFirebase({
    required this.banner,
    required this.instersticial,
    required this.openedApp,
    required this.reward,
    required this.query,
  });

  //PROD
  // factory AdEnable.fromMap(Map<String, dynamic> map) {
  //   return AdEnable.fromFirebase(
  //     reward: map['reward'] as bool,
  //     query: map['query'] as bool,
  //     instersticial: map['instersticial'] as bool,
  //     banner: map['banner'] as bool,
  //     openedApp: map['openedApp'] as bool,
  //   );
  // }

  // TEST
  factory AdEnable.fromMap(Map<String, dynamic> map) {
    return AdEnable.fromFirebase(
      reward: true,
      query: true,
      instersticial: true,
      banner: true,
      openedApp: true,
    );
  }
}

class AdFallConfig {
  late bool active;
  late String id;

  AdFallConfig.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        "active": active,
        "id": id,
      };
}

class AdObjConfig {
  late bool activeAll;
  late bool activeObj;
  late bool waterfall;
  late String defaultId;
  late AdFallConfig low;
  late AdFallConfig medium;
  late AdFallConfig high;

  AdObjConfig.fromJson(AdConfig adConfig, Map<String, dynamic> json) {
    activeAll = adConfig.activeAll;
    activeObj = json['active'];
    waterfall = json['waterfall'];
    defaultId = json['default'];
    low = AdFallConfig.fromJson(json['low']);
    medium = AdFallConfig.fromJson(json['medium']);
    high = AdFallConfig.fromJson(json['high']);
  }

  bool get active => activeAll && activeObj;

  List<String> get id {
    if (waterfall) {
      List<String> ids = [];
      if (high.active) ids.add(high.id);
      if (medium.active) ids.add(medium.id);
      if (low.active) ids.add(low.id);
      return (ids.isNotEmpty ? ids : [defaultId]).toList();
    } else {
      return [defaultId].toList();
    }
  }

  Map<String, dynamic> toJson() => {
        "active": active,
        "waterfall": waterfall,
        "default": defaultId,
        "low": low.toJson(),
        "medium": medium.toJson(),
        "high": high.toJson(),
      };
}

class AdType {
  late String id;
  late String locale;
  late AdTypeEnum type;

  AdType();

  AdType.fromFirebase({
    required this.id,
    required this.locale,
    required this.type,
  });

  factory AdType.fromMap(Map<String, dynamic> map) {
    return AdType.fromFirebase(
      id: map['id'] as String,
      locale: map['locale'] as String,
      type: (map['type'] as String).toAdTypeEnum(),
    );
  }
}

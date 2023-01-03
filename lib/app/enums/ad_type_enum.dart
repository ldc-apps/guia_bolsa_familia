enum AdTypeEnum{
  reward,
  intersticialReward,
  none,
}

extension AdTypeEnumParse on String{
  AdTypeEnum toAdTypeEnum(){
    switch (this) {
      case 'reward': return AdTypeEnum.reward;
      case 'intersticial': return AdTypeEnum.intersticialReward;
      default: return AdTypeEnum.none;
    }
  }
}
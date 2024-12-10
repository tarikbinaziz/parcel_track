class OrderConditionState {
  final double minOrderAmount;
  final double maxOrderAmount;
  final double deliveryCharge;

  OrderConditionState({
    this.minOrderAmount = 0.0,
    this.maxOrderAmount = 0.0,
    this.deliveryCharge = 0.0,
  });
}

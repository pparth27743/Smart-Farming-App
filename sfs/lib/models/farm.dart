class Farm {
  final String farmerId;
  final String farmId;
  final int humidity;
  final int soil_moisture;
  final int temp;
  final bool pump;
  final bool rooftop;

  Farm(
      {this.farmerId,
      this.farmId,
      this.humidity,
      this.soil_moisture,
      this.temp,
      this.pump,
      this.rooftop});
}

class Pump {
  bool pumpFlag;
  bool pumpError;
  double waterLevl;

  Pump(
      {required this.pumpFlag,
      required this.pumpError,
      required this.waterLevl});

  get waterLevel => waterLevl;
  get pumpOn => pumpFlag;
  get pumpErrorFlag => pumpError;
}

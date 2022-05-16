import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/pump.dart';

class IrrigationPumpScreen extends StatefulWidget {
  static const routeName = '/soil-pump';

  const IrrigationPumpScreen({Key? key}) : super(key: key);

  @override
  State<IrrigationPumpScreen> createState() => _IrrigationPumpScreenState();
}

class _IrrigationPumpScreenState extends State<IrrigationPumpScreen> {
  var dbRef = FirebaseDatabase.instance.ref().child('soild');
  late Pump pump;
  bool init = true;
  bool custom = true;
  bool pumpError = true;
  late bool pumpOn;

  initData() async {
    dbRef.onValue.listen((event) async {
      final data = event.snapshot.children;

      setState(() {
        pump = Pump(
            pumpFlag:
                data.elementAt(2).value.toString() == 'true' ? true : false,
            pumpError:
                data.elementAt(1).value.toString() == 'true' ? true : false,
            waterLevl: 100.0 - (data.elementAt(0).value as int) * 1.0);
        // custom = data.elementAt(0).value.toString() == 'true' ? true : false;
      });
      pumpOn = pump.pumpFlag;
      pumpError = pump.pumpError;
      init = false;
    });
  }

  @override
  void initState() {
    initData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Irrigation System Options'),
      ),
      body: Center(
        child: init
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Soil Pump Is :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 36,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: pump.pumpFlag ? Colors.green : Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              pump.pumpFlag ? 'On' : 'Off',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        Switch(
                          value: pump.pumpFlag,
                          onChanged: custom
                              ? (value) {
                                  dbRef.child('soilPumbFlag').set(value);
                                }
                              : null,
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.purple,
                    ),
                    // const SizedBox(height: 50),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Soil Pump State Is :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 96,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: pump.pumpError ? Colors.red : Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              pump.pumpError ? 'Error' : 'Functional',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          child: const Text('Reset'),
                          onPressed: pump.pumpError
                              ? () {
                                  dbRef.child('soilPumbError').set(false);
                                }
                              : null,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            fixedSize: const Size(60, 0),
                            primary: Colors.white,
                            backgroundColor: pump.pumpError
                                ? Colors.teal
                                : Colors.transparent,
                            onSurface: Colors.white,
                            textStyle: const TextStyle(fontSize: 18),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.purple,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Wetness Level Is :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 56,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:
                                pump.waterLevl > 50 ? Colors.green : Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              pump.waterLevl.round().toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

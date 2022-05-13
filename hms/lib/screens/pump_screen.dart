import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hms/model/pump.dart';
import 'package:lottie/lottie.dart';

class PumpScreen extends StatefulWidget {
  static const routeName = '/water-pumb';
  const PumpScreen({Key? key}) : super(key: key);

  @override
  State<PumpScreen> createState() => _PumpScreenState();
}

class _PumpScreenState extends State<PumpScreen>
    with SingleTickerProviderStateMixin {
  var dbRef = FirebaseDatabase.instance.ref().child('WaterSensor');
  late Pump pump;
  late AnimationController _controller;
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
                data.elementAt(1).value.toString() == 'true' ? true : false,
            pumpError:
                data.elementAt(3).value.toString() == 'true' ? true : false,
            waterLevl: double.parse(data.elementAt(2).value.toString()));
        custom = data.elementAt(0).value.toString() == 'true' ? true : false;
      });
      pumpOn = pump.pumpFlag;
      pumpError = pump.pumpError;
      init = false;
    });
  }

  @override
  void initState() {
    initData();
    _controller = AnimationController(
      vsync: this,

      duration: const Duration(milliseconds: 600),
      // reverseDuration: const Duration(milliseconds: 6000),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tank Options'),
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
                        TextButton(
                          onPressed: () {
                            dbRef.child('custom').set(false);
                            // setState(() {});
                          },
                          child: const Text('A'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            fixedSize: const Size(30, 10),
                            primary: Colors.white,
                            backgroundColor:
                                custom ? Colors.transparent : Colors.teal,
                            onSurface: Colors.grey,
                            textStyle: const TextStyle(fontSize: 18),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                        ),
                        const Text(':Automatic'),
                        TextButton(
                          onPressed: () {
                            dbRef.child('custom').set(true);
                            // setState(() {});
                          },
                          child: const Text('C'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            fixedSize: const Size(30, 10),
                            primary: Colors.white,
                            backgroundColor:
                                custom ? Colors.teal : Colors.transparent,
                            onSurface: Colors.grey,
                            textStyle: const TextStyle(fontSize: 18),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                        ),
                        const Text(':Custom'),
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
                          'Water Pump Is :',
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
                                  dbRef.child('pumbFlag').set(value);
                                  value
                                      ? _controller.forward()
                                      : _controller.reverse();
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
                          'Water Pump State Is :',
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
                                  dbRef.child('waterPumbError').set(false);
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
                          'Water Level Is :',
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
                    SizedBox(
                      height: 200,
                      child: Lottie.network(
                        'https://assets8.lottiefiles.com/packages/lf20_gdesehba.json',
                        controller: _controller,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

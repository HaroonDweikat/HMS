import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class OutdoorScreen extends StatefulWidget {
  static const routeName = '/outdoor-light';
  const OutdoorScreen({Key? key}) : super(key: key);

  @override
  State<OutdoorScreen> createState() => _OutdoorScreenState();
}

class _OutdoorScreenState extends State<OutdoorScreen> {
  // late Pump pump;
  var lambDbRef = FirebaseDatabase.instance.ref().child('lamb');
  var motionDbRef = FirebaseDatabase.instance.ref('motionSensorFlag');
  var ldrDbRef = FirebaseDatabase.instance.ref('LDRSensorLvl');

  bool init = true;
  bool custom = true;
  bool lampFlag = false;
  bool motionFlag = false;
  int lampOnPeriod = 0;
  int ldrValue = 0;

  initData() async {
    motionDbRef.onValue.listen((event) async {
      setState(() {
        motionFlag = event.snapshot.value as bool;
      });
    });
    ldrDbRef.onValue.listen((event) async {
      setState(() {
        ldrValue = event.snapshot.value as int;
      });
    });
    lambDbRef.onValue.listen((event) async {
      final data = event.snapshot.children;
      setState(() {
        custom = data.elementAt(0).value as bool;
        lampFlag = data.elementAt(1).value as bool;
        lampOnPeriod = data.elementAt(2).value as int;
        init = false;
      });
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
        title: const Text('Outdoor Light Options'),
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
                            custom = false;
                            lambDbRef.child('custom').set(custom);
                            setState(() {});
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
                            custom = true;
                            lambDbRef.child('custom').set(custom);
                            setState(() {});
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 24),
                        const Text(
                          'Light Intensity:',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 34),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // color: Colors.teal,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.light_mode_sharp,
                                color: ldrValue < 30
                                    ? Colors.yellow.shade200
                                    : ldrValue < 50
                                        ? Colors.yellow.shade300
                                        : ldrValue < 70
                                            ? Colors.yellow.shade400
                                            : Colors.yellow.shade700,
                                size: 33,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                ldrValue.toString(),
                                style: TextStyle(
                                  color: ldrValue < 50
                                      ? Colors.teal.shade200
                                      : Colors.teal,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 24),
                        const Text(
                          'Lamb State Is :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 44),
                        Container(
                          width: 36,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // color: lampFlag ? Colors.green : Colors.red,
                          ),
                          child: Center(
                            child: Icon(
                              lampFlag
                                  ? Icons.lightbulb_rounded
                                  : Icons.lightbulb_outline,
                              color: lampFlag ? Colors.teal : Colors.white,
                              size: 30,
                              // style: const TextStyle(
                              //     fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        Switch(
                          value: lampFlag,
                          onChanged: custom
                              ? (value) {
                                  lambDbRef.child('lambFlag').set(value);
                                }
                              : null,
                        ),
                        const SizedBox(width: 30),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 24),
                        const Text(
                          'Motion State Is :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 54),
                        Container(
                          width: 36,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // color: lampFlag ? Colors.green : Colors.red,
                          ),
                          child: Center(
                            child: Icon(
                              motionFlag
                                  ? Icons.directions_run
                                  : Icons.man_rounded,
                              color: motionFlag ? Colors.teal : Colors.white,
                              size: 30,
                              // style: const TextStyle(
                              //     fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 24),
                        const Text(
                          'Lamb On Timer :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Slider(
                            min: 1.0,
                            max: 10.0,
                            divisions: 10,
                            activeColor: Colors.teal,
                            inactiveColor: Colors.grey,
                            label: 'Set Timer value',
                            value: lampOnPeriod.toDouble(),
                            onChanged: (double value) {
                              lambDbRef
                                  .child('lambPeriodToOnState')
                                  .set(value.toInt());
                            },
                            // semanticFormatterCallback: (double newValue) {
                            //   return '${newValue.round()} dollars';
                            // },
                          ),
                        ),
                        const SizedBox(width: 14),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 24),
                        const Text(
                          'Lamb Timer Value:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 54),
                        Text(
                          '$lampOnPeriod second',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        const SizedBox(width: 14),
                      ],
                    ),
                    // const Divider(
                    //   height: 20,
                    //   thickness: 2,
                    //   indent: 20,
                    //   endIndent: 20,
                    //   color: Colors.purple,
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
}

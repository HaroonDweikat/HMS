import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GateSystemIcon extends StatefulWidget {
  static const routeName = '/gate-system';
  const GateSystemIcon({Key? key}) : super(key: key);

  @override
  State<GateSystemIcon> createState() => _GateSystemIconState();
}

class _GateSystemIconState extends State<GateSystemIcon> {
  var dbRef = FirebaseDatabase.instance.ref().child('stepper');
  bool init = true;
  bool gateState = false;
  bool objectFlag = false;
  bool stepperTurnOn = false;
  bool stopStepper = false;

  initData() async {
    dbRef.onValue.listen((event) async {
      final data = event.snapshot.children;

      setState(() {
        gateState = data.elementAt(0).value.toString() == 'true' ? true : false;
        objectFlag =
            data.elementAt(1).value.toString() == 'true' ? true : false;
        stepperTurnOn =
            data.elementAt(2).value.toString() == 'true' ? true : false;
        stopStepper =
            data.elementAt(3).value.toString() == 'true' ? true : false;
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
        title: const Text('Gate Options'),
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
                          'Gate State Is :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 76,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.teal,
                          ),
                          child: Center(
                            child: Text(
                              gateState
                                  ? stepperTurnOn
                                      ? 'Closing'
                                      : 'Opened'
                                  : stepperTurnOn
                                      ? 'Opening'
                                      : 'Closed',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        stepperTurnOn
                            ? const CircularProgressIndicator()
                            : const Text(''),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          //gate false > close
                          onPressed: gateState
                              ? null
                              : () {
                                  dbRef.child('stepperTurnOn').set(true);
                                  // dbRef.child('gateState').set(true);
                                },
                          child: const Text('Open'),
                          style: ElevatedButton.styleFrom(primary: Colors.teal),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          //gate true > open
                          onPressed: gateState
                              ? () {
                                  dbRef.child('stepperTurnOn').set(true);
                                  // dbRef.child('gateState').set(false);
                                }
                              : null,
                          child: const Text('Close'),
                          style: ElevatedButton.styleFrom(primary: Colors.teal),
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
                          'Gate State Is :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 226,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: objectFlag ? Colors.red : Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              objectFlag
                                  ? 'Unkonwn object in the gate way'
                                  : 'Every thing is great',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

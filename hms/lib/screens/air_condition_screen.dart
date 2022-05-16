import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AirConditionScreen extends StatefulWidget {
  static const routeName = '/air-condition-system';

  const AirConditionScreen({Key? key}) : super(key: key);

  @override
  State<AirConditionScreen> createState() => _AirConditionScreenState();
}

class _AirConditionScreenState extends State<AirConditionScreen> {
  var dbRef = FirebaseDatabase.instance.ref().child('tempSensor');
  bool init = true;
  bool conditionState = false;
  int temprature = 0;
  int tempThreeshould = 0;

  initData() async {
    dbRef.onValue.listen((event) async {
      final data = event.snapshot.children;

      setState(() {
        conditionState = data.elementAt(0).value as bool;
        temprature = data.elementAt(1).value as int;
        tempThreeshould = data.elementAt(2).value as int;
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
        title: const Text('Air condtion Options'),
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
                          'Air Condtion State : ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 46,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.teal,
                          ),
                          child: Center(
                            child: Text(
                              conditionState ? 'On' : 'Off',
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Tempreature :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Center(
                          child: Text(
                            temprature.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 24),
                        Text(
                          ' Tempreature Threeshould: $tempThreeshould',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        const SizedBox(width: 14),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Slider(
                            min: 16.0,
                            max: 30.0,
                            divisions: 16,
                            activeColor: Colors.teal,
                            inactiveColor: Colors.grey,
                            // label: 'Set Tempreature value',
                            value: tempThreeshould.toDouble(),
                            onChanged: (double value) {
                              dbRef
                                  .child('tempreatureThreeshould')
                                  .set(value.toInt());
                            },
                          ),
                        ),
                      ],
                    )
                    // // const SizedBox(height: 50),
                    // Row(
                    //   mainAxisSize: MainAxisSize.max,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       'Gate State Is :',
                    //       style: TextStyle(
                    //           fontSize: 20, fontWeight: FontWeight.w600),
                    //     ),
                    //     const SizedBox(width: 4),
                    //     Container(
                    //       width: 226,
                    //       height: 30,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(8),
                    //         color: objectFlag ? Colors.red : Colors.green,
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           objectFlag
                    //               ? 'Unkonwn object in the gate way'
                    //               : 'Every thing is great',
                    //           style: const TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 14),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class GasPolutionSystem extends StatefulWidget {
  static const routeName = '/gas-polution';

  const GasPolutionSystem({Key? key}) : super(key: key);

  @override
  State<GasPolutionSystem> createState() => _GasPolutionSystemState();
}

class _GasPolutionSystemState extends State<GasPolutionSystem> {
  var dbRef = FirebaseDatabase.instance.ref().child('smoke');
  bool init = true;
  bool buzzerState = false;
  bool buzzerController = false;
  int somkeLevl = 0;

  initData() async {
    dbRef.onValue.listen((event) async {
      final data = event.snapshot.children;

      setState(() {
        buzzerController =
            data.elementAt(0).value.toString() == 'true' ? true : false;
        buzzerState =
            data.elementAt(1).value.toString() == 'true' ? true : false;
        somkeLevl = data.elementAt(2).value as int;
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
                        const Text(
                          'Buzzer State Is :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 36,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: buzzerState ? Colors.green : Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              buzzerState ? 'On' : 'Off',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        Switch(
                          value: buzzerState,
                          onChanged: buzzerState
                              ? (value) {
                                  dbRef
                                      .child('buzzerControlledFromApp')
                                      .set(value);
                                  dbRef.child('buzzerState').set(value);
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
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 300,
                            child: Center(
                              child: Icon(
                                Icons.air,
                                size: 40,
                              ),
                            ),
                          ),
                          Text(
                            'Gaz state: ${somkeLevl < 50 ? ' Air is clear' : 'Unkown Gaz in the Air'}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Polution level: ',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                somkeLevl.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: somkeLevl < 50
                                        ? Colors.teal
                                        : Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

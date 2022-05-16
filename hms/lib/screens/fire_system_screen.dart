import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FireSystem extends StatefulWidget {
  static const routeName = '/fire-system';

  const FireSystem({Key? key}) : super(key: key);

  @override
  State<FireSystem> createState() => _FireSystemState();
}

class _FireSystemState extends State<FireSystem> {
  var dbRef = FirebaseDatabase.instance.ref().child('smoke');
  bool init = true;
  bool buzzerState = false;
  bool buzzerController = false;
  bool fireFlag = false;
  int somkeLevl = 0;

  initData() async {
    dbRef.onValue.listen((event) async {
      final data = event.snapshot.children;

      setState(() {
        buzzerController = data.elementAt(0).value as bool;
        buzzerState = data.elementAt(1).value as bool;
        fireFlag = data.elementAt(2).value as bool;
        somkeLevl = data.elementAt(3).value as int;
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
        title: const Text('Fire System Alarm'),
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
                            buzzerController = false;
                            dbRef
                                .child('buzzerControlledFromApp')
                                .set(buzzerController);
                            setState(() {});
                          },
                          child: const Text('A'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            fixedSize: const Size(30, 10),
                            primary: Colors.white,
                            backgroundColor: buzzerController
                                ? Colors.transparent
                                : Colors.teal,
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
                            buzzerController = true;
                            dbRef
                                .child('buzzerControlledFromApp')
                                .set(buzzerController);
                            setState(() {});
                          },
                          child: const Text('C'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            fixedSize: const Size(30, 10),
                            primary: Colors.white,
                            backgroundColor: buzzerController
                                ? Colors.teal
                                : Colors.transparent,
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
                            color: buzzerState ? Colors.red : Colors.teal,
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
                          onChanged: buzzerController
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              Center(
                                child: Container(
                                  width: 300,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: fireFlag ? Colors.red : Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      fireFlag
                                          ? 'There is a fire!!!'
                                          : 'House is safe',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
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

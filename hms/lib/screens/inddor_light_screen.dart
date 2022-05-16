import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InddorLightScreen extends StatefulWidget {
  static const routeName = '/indor-light';

  const InddorLightScreen({Key? key}) : super(key: key);

  @override
  State<InddorLightScreen> createState() => _InddorLightScreenState();
}

class _InddorLightScreenState extends State<InddorLightScreen> {
  // late Pump pump;
  var lambDbRef = FirebaseDatabase.instance.ref().child('indoorLight');

  bool init = true;
  bool custom = true;
  bool lampFlag = false;
  bool led1 = false;
  bool led2 = false;
  bool led3 = false;
  bool led4 = false;
  var ldrDbRef = FirebaseDatabase.instance.ref('LDRSensorLvl');
  int outdorLdr = 0;
  int indorLdr = 0;

  initData() async {
    lambDbRef.onValue.listen((event) async {
      final data = event.snapshot.children;
      setState(() {
        led1 = data.elementAt(0).value as bool;
        led2 = data.elementAt(1).value as bool;
        led3 = data.elementAt(2).value as bool;
        led4 = data.elementAt(3).value as bool;
        custom = data.elementAt(4).value as bool;
        init = false;
        if (custom) {
          indorLdr = led1
              ? 25
              : led2
                  ? 50
                  : led3
                      ? 75
                      : led4
                          ? 100
                          : 0;
        } else {
          indorLdr = outdorLdr < 26
              ? 100
              : outdorLdr < 55
                  ? 75
                  : outdorLdr < 77
                      ? 50
                      : outdorLdr < 90
                          ? 25
                          : 0;
        }
      });
    });

    ldrDbRef.onValue.listen((event) async {
      setState(() {
        outdorLdr = event.snapshot.value as int;
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
        title: const Text('Indoor Light Options'),
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
                            lambDbRef.child('lightControlWay').set(custom);
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
                            lambDbRef.child('lightControlWay').set(custom);
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
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 24),
                            const Text(
                              'Outdor Light Intensity:',
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
                                    color: outdorLdr < 30
                                        ? Colors.yellow.shade200
                                        : outdorLdr < 50
                                            ? Colors.yellow.shade300
                                            : outdorLdr < 70
                                                ? Colors.yellow.shade400
                                                : Colors.yellow.shade700,
                                    size: 33,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    outdorLdr.toString(),
                                    style: TextStyle(
                                      color: outdorLdr < 50
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
                        Row(
                          children: [
                            const SizedBox(width: 24),
                            const Text(
                              'Indor Light Intensity:   ',
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
                                    color: indorLdr < 30
                                        ? Colors.yellow.shade200
                                        : outdorLdr < 55
                                            ? Colors.yellow.shade300
                                            : outdorLdr < 80
                                                ? Colors.yellow.shade400
                                                : Colors.yellow.shade700,
                                    size: 33,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    indorLdr.toString(),
                                    style: TextStyle(
                                      color: indorLdr < 50
                                          ? Colors.teal.shade200
                                          : Colors.teal,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
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
                          'Lamb\'s State Is :',
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
                              indorLdr > 20
                                  ? Icons.lightbulb_rounded
                                  : Icons.lightbulb_outline,
                              color: indorLdr > 20 ? Colors.teal : Colors.white,
                              size: 30,
                              // style: const TextStyle(
                              //     fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // color: lampFlag ? Colors.green : Colors.red,
                          ),
                          child: Center(
                            child: Icon(
                              indorLdr > 40
                                  ? Icons.lightbulb_rounded
                                  : Icons.lightbulb_outline,
                              color: indorLdr > 40 ? Colors.teal : Colors.white,
                              size: 30,
                              // style: const TextStyle(
                              //     fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // color: lampFlag ? Colors.green : Colors.red,
                          ),
                          child: Center(
                            child: Icon(
                              indorLdr > 70
                                  ? Icons.lightbulb_rounded
                                  : Icons.lightbulb_outline,
                              color: indorLdr > 70 ? Colors.teal : Colors.white,
                              size: 30,
                              // style: const TextStyle(
                              //     fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // color: lampFlag ? Colors.green : Colors.red,
                          ),
                          child: Center(
                            child: Icon(
                              indorLdr > 90
                                  ? Icons.lightbulb_rounded
                                  : Icons.lightbulb_outline,
                              color: indorLdr > 90 ? Colors.teal : Colors.white,
                              size: 30,
                              // style: const TextStyle(
                              //     fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        const Text(
                          '0',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: Slider(
                            min: 0.0,
                            max: 100.0,
                            divisions: 4,
                            activeColor: Colors.teal,
                            inactiveColor: Colors.grey,
                            label: 'Set Light intensity',
                            value: indorLdr.toDouble(),
                            onChanged: (double value) {
                              if (!custom) {
                                return;
                              }
                              indorLdr = value.toInt();
                              switch (value.toInt()) {
                                case 0:
                                  lambDbRef.child('led1').set(false);
                                  lambDbRef.child('led2').set(false);
                                  lambDbRef.child('led3').set(false);
                                  lambDbRef.child('led4').set(false);
                                  break;
                                case 25:
                                  lambDbRef.child('led1').set(true);
                                  lambDbRef.child('led2').set(false);
                                  lambDbRef.child('led3').set(false);
                                  lambDbRef.child('led4').set(false);
                                  break;
                                case 50:
                                  lambDbRef.child('led1').set(true);
                                  lambDbRef.child('led2').set(true);
                                  lambDbRef.child('led3').set(false);
                                  lambDbRef.child('led4').set(false);
                                  break;
                                case 75:
                                  lambDbRef.child('led1').set(true);
                                  lambDbRef.child('led2').set(true);
                                  lambDbRef.child('led3').set(true);
                                  lambDbRef.child('led4').set(false);
                                  break;
                                case 100:
                                  lambDbRef.child('led1').set(true);
                                  lambDbRef.child('led2').set(true);
                                  lambDbRef.child('led3').set(true);
                                  lambDbRef.child('led4').set(true);
                                  break;
                                default:
                              }
                              lambDbRef.child('lightControlWay').set(custom);
                            },
                            // semanticFormatterCallback: (double newValue) {
                            //   return '${newValue.round()} dollars';
                            // },
                          ),
                        ),
                        const Text(
                          '100',
                          style: TextStyle(
                              color: Color(0xFFFBC02D),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

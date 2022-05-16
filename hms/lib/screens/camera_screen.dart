import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:url_launcher/url_launcher.dart';

class SecurtyCamera extends StatefulWidget {
  static const routeName = '/securte-camera';
  const SecurtyCamera({Key? key}) : super(key: key);

  @override
  State<SecurtyCamera> createState() => SecurtyCameraState();
}

class SecurtyCameraState extends State<SecurtyCamera> {
  var camIpDbRef = FirebaseDatabase.instance.ref().child('camIP');
  var startStreaming = FirebaseDatabase.instance.ref('startStreaming');
  var cam = FirebaseDatabase.instance.ref().child('cam');
  bool init = true;
  bool camMobileEnabled = true;
  bool camSecurity = true;
  String camIp = '';
  String _url = 'https://';
  // final Uri _url = Uri.parse('https://flutter.dev');
  openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  initData() async {
    cam.onValue.listen((event) async {
      final data = event.snapshot.children;

      setState(() {
        camMobileEnabled = data.elementAt(0).value as bool;
        camSecurity = data.elementAt(1).value as bool;
      });
    });
    camIpDbRef.onValue.listen((event) async {
      setState(() {
        camIp = event.snapshot.value as String;
        _url = 'http://' + camIp;
        // _url = 'http://192.168.1.118';
        init = false;
        // openUrl('https://www.google.ps');
        print(camIp);
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
        title: const Text('Securty Camera'),
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
                            'Notification State Is :',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 86,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.teal,
                            ),
                            child: Center(
                              child: Text(
                                camSecurity ? 'Enabled' : 'Disabled',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Switch(
                            value: camSecurity,
                            onChanged: (value) {
                              cam.child('camSecurity').set(value);
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // openUrl('https://flutter.dev');
                            openUrl(_url);
                          },
                          child: const Text('Start Streaming'))
                    ],
                  ),
                )),
    );
  }
}

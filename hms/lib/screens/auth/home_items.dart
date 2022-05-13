import 'package:flutter/material.dart';
import 'package:hms/screens/gaz_pullution_screen.dart';
import 'package:hms/screens/outdoor_light_screen.dart';
import 'package:hms/screens/pump_screen.dart';
import 'package:hms/screens/soil_pump_screem.dart';
import 'package:hms/widgets/water_level.dart';

class HomeItemsScreen extends StatefulWidget {
  const HomeItemsScreen({Key? key}) : super(key: key);

  @override
  State<HomeItemsScreen> createState() => _HomeItemsScreenState();
}

class _HomeItemsScreenState extends State<HomeItemsScreen> {
  List<Widget> sensoreGridWidget = [];
  late List<Map<String, dynamic>> sensoreGrid;
  bool _isInit = true;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      initData();
      initWidget();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  initWidget() {
    for (var i = 0; i < sensoreGrid.length; i++) {
      if (i == 0) {
        sensoreGridWidget.add(
          InkWell(
            onTap: sensoreGrid[i]['function'],
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      // border: Border.all(width: 1, color: Colors.red),
                    ),
                    child: const WaterLevel(),
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(33, 33, 33, 0.5),
                          spreadRadius: 2,
                          blurRadius: 3,

                          offset: Offset(1, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        sensoreGrid[i]['title'],
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        continue;
      }
      sensoreGridWidget.add(
        InkWell(
          onTap: sensoreGrid[i]['function'],
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(sensoreGrid[i]['image']),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(33, 33, 33, 0.5),
                        spreadRadius: 2,
                        blurRadius: 3,

                        offset: Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      sensoreGrid[i]['title'],
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  initData() {
    sensoreGrid = [
      {
        'image': '',
        'title': 'Water Tank',
        'function': () {
          Navigator.of(context).pushNamed(PumpScreen.routeName);
        },
      },
      {
        'image': 'assets/images/outdoor-light-icon.jpg',
        'title': 'Outdoor Light Sys.',
        'function': () {
          Navigator.of(context).pushNamed(OutdoorScreen.routeName);
        },
      },
      {
        'image': 'assets/images/soil-system.jpg',
        'title': 'Soil System',
        'function': () {
          Navigator.of(context).pushNamed(SoilPumpScreen.routeName);
        },
      },
      {
        'image': 'assets/images/outdoor-light-icon.jpg',
        'title': 'Gate System',
        'function': () {
          Navigator.of(context).pushNamed(PumpScreen.routeName);
        },
      },
      {
        'image': 'assets/images/gas-polution.png',
        'title': 'Gaz Pollution System',
        'function': () {
          Navigator.of(context).pushNamed(GasPolutionSystem.routeName);
        },
      },
      {
        'image': 'assets/images/outdoor-light-icon.jpg',
        'title': 'Air Condition Sys.',
        'function': () {
          Navigator.of(context).pushNamed(PumpScreen.routeName);
        },
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(14.0),

            primary: true,
            // shrinkWrap: true,
            children: [
              const SizedBox(height: 16),
              GridView.builder(
                padding: const EdgeInsets.only(bottom: 120),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (ctx, index) => sensoreGridWidget[index],
                itemCount: sensoreGrid.length,
              ),
            ],
          );
  }
}

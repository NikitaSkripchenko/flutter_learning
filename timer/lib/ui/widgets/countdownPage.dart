import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:oneteatree/ui/widgets/roundButton.dart';
import 'cupWidget.dart';

const double _kItemExtent = 32.0;
const List<String> options = <String>[
  '+1',
  '+2',
  '+3',
  '+4',
  '+5',
  '+6',
  '+7',
  '+8',
  '+9',
  '+10',
  '+12',
  '+14',
  '+16',
  '+18',
  '+20',
  '+25',
  '+30',
  '+35',
  '+40',
  '+50',
  '+60',
  '+70',
  '+80',
  '+90',
  '+100',
  '+110',
  '+120',
  '+130',
  '+140',
  '+150'
];

int converting(String val) {
  String clean = val.replaceRange(0, 1, '');
  return int.parse(clean);
}

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  int _preSelectedOption = 0;
  int _selectedOption = 0;
  double progressValue = 0;
  int straits = 0;

  Duration lastDuration = Duration(seconds: 60);
  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void notify() {
    var x = controller.duration! * controller.value;
    if ("0:00:00.000000" == controller.duration! * controller.value) {
      print("hhh");
    }
    if (countText == '00:00') {
      controller.reset();
      setState(() {
        lastDuration += Duration(seconds: converting(options[_selectedOption]));
        controller.duration = lastDuration;

        straits += 1;
        isPlaying = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );
    controller.addListener(
      () {
        notify();
        if (controller.isDismissed) {
          setState(() {
            progressValue = 1.0;
            isPlaying = false;
          });
        } else {
          setState(
            () {
              progressValue = controller.value;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5fbff),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
          Text('$straits'),
          Text('${options[_selectedOption]}'),
          SizedBox(
            width: double.infinity,
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: straits,
              itemBuilder: (BuildContext context, int index) {
                return const Cup();
              },
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    value: progressValue,
                    strokeWidth: 60,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.isDismissed) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          height: 300,
                          child: CupertinoTimerPicker(
                            initialTimerDuration: lastDuration,
                            mode: CupertinoTimerPickerMode.ms,
                            onTimerDurationChanged: (time) {
                              setState(() {
                                controller.duration = time;
                                lastDuration = time;
                              });
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      countText,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.reverse(
                          from: controller.value == 0 ? 1.0 : controller.value);
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff999999),
                                    width: 0.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  CupertinoButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 5.0,
                                    ),
                                  ),
                                  CupertinoButton(
                                    child: Text('Confirm'),
                                    onPressed: () {
                                      setState(() {
                                        _selectedOption = _preSelectedOption;
                                      });
                                      Navigator.pop(context);
                                    },
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 5.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 320.0,
                              color: Color(0xfff7f7f7),
                              child: CupertinoPicker(
                                magnification: 1.22,
                                squeeze: 1.2,
                                useMagnifier: true,
                                itemExtent: 32,
                                // This is called when selected item is changed.

                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    _preSelectedOption = selectedItem;
                                  });
                                },
                                children: List<Widget>.generate(options.length,
                                    (int index) {
                                  return Center(
                                    child: Text(
                                      options[index],
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: RoundButton(
                    icon: Icons.plus_one,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

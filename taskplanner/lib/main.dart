import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'dart:math';
import 'dart:io';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  @override
  ApplicationState createState() => ApplicationState();
}

double? angle;
double? distMin2;
int? octave;
String? note;
int? noteInt;
List freqNotes = [
  [16.3, 17.3, 18.3, 19.4, 20.5, 21.8, 23.1, 24.5, 26.0, 27.5, 29.1, 30.8],
  [32.7, 34.6, 36.7, 38.9, 41.2, 43.6, 46.2, 49.0, 51.9, 55.0, 58.0, 62.0],
  [65.0, 69.0, 74.0, 78.0, 83.0, 87.0, 92.5, 98.0, 104.0, 110.0, 117.0, 123.0],
  [
    131.0,
    139.0,
    147.0,
    156.0,
    165.0,
    175.0,
    185.0,
    196.0,
    208.0,
    220.0,
    233.0,
    247.0
  ],
  [
    262.0,
    277.0,
    294.0,
    311.0,
    330.0,
    349.0,
    370.0,
    392.0,
    415.0,
    440.0,
    466.0,
    494.0
  ],
  [
    523.0,
    554.0,
    587.0,
    622.0,
    659.0,
    698.5,
    740.0,
    784.0,
    831.0,
    880.0,
    932.0,
    988.0
  ],
  [
    1046.5,
    1109.0,
    1175.0,
    1244.5,
    1318.5,
    1397.0,
    1480.0,
    1568.0,
    1661.0,
    1760.0,
    1865.0,
    1975.0
  ],
  [
    2093.0,
    2217.0,
    2349.0,
    2489.0,
    2637.0,
    2794.0,
    2960.0,
    3136.0,
    3322.0,
    3520.0,
    3729.0,
    3951.0
  ],
  [
    4186.0,
    4435.0,
    4698.0,
    4978.0,
    5274.0,
    5588.0,
    5920.0,
    6272.0,
    6645.0,
    7040.0,
    7458.0,
    7902.0
  ],
  [
    8372.0,
    8870.0,
    9396.0,
    9956.0,
    10548.0,
    11176.0,
    11840.0,
    12544.0,
    13290.0,
    14080.0,
    14918.0,
    15804.0
  ],
  [16744.0, 17740.0, 18792.0, 19912.0, 21098.0]
];

class ApplicationState extends State<Application> {
  double? frequence;
  bool? isRecording;

  Map freqNotesMap = {
    1: "do",
    2: "ré",
    3: "mi",
    4: "fa",
    5: "sol",
    6: "la",
    7: "si"
  };
  FlutterFft flutterFft = FlutterFft();

  initialisation() async {
    await flutterFft.startRecorder();
    setState(() => isRecording = flutterFft.getIsRecording);
    flutterFft.onRecorderStateChanged.listen(
      (data) => {
        setState(
          () => {
            frequence = data[1] as double,
          },
        ),
        flutterFft.setFrequency = frequence!,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo(),
              freq(),
              freq2(frequence, freqNotes, freqNotesMap),
              fleche(angle),
              boutons(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    initialisation();
  }
}

Widget logo() {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 200,
        child: Image.asset(
          'assets/images/B.png',
          width: 100,
          height: 100,
        ),
      )
    ],
  ));
}

Widget freq() {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("fréquence et note:", style: TextStyle(fontSize: 30)),
    ],
  ));
}

Widget freq2(frequence, freqNotes, freqNotesMap) {
  distMin2 ??= 0;
  frequence ??= 0; // définie la valeur à 0 si elle est nulle
  angle ??= 0;
  octave ??= 0;
  note ??= "";
  noteInt ??= 0;
  frequence = frequence.toInt();

  if (frequence < 31.5)
    octave = -1;
  else if (frequence >= 31.5 && frequence < 63)
    octave = 0;
  else if (frequence >= 63 && frequence < 127)
    octave = 1;
  else if (frequence >= 127 && frequence < 255)
    octave = 2;
  else if (frequence >= 255 && frequence < 510)
    octave = 3;
  else if (frequence >= 510 && frequence < 1020)
    octave = 4;
  else if (frequence >= 1020 && frequence < 2034)
    octave = 5;
  else if (frequence >= 2034 && frequence < 4069)
    octave = 6;
  else if (frequence >= 4069 && frequence < 8137)
    octave = 7;
  else if (frequence >= 8137 && frequence < 16274)
    octave = 8;
  else if (frequence >= 16274) octave = 9;
  List tableau = freqNotes[octave! + 1];
  double distMin = 50000;

  for (int i = 0; i < tableau.length; i++) {
    if (sqrt(pow(frequence - tableau[i], 2)) < distMin) {
      distMin = sqrt(pow(frequence - tableau[i], 2));
      distMin2 = frequence - tableau[i];
      noteInt = i;
    }
  }

  Map noteTableau = {
    0: "Do",
    1: "Do#",
    2: "Re",
    3: "Re#",
    4: "Mi",
    5: "Fa",
    6: "Fa#",
    7: "Sol",
    8: "Sol#",
    9: "La",
    10: "La#",
    11: "Si"
  };
  note = noteTableau[noteInt];

  angle = ((freqNotes[octave! + 1][noteInt] - distMin2!.toInt()) /
          freqNotes[octave! + 1][noteInt]) *
      -6;

  return (Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "$frequence Hz\n$note",
        style: const TextStyle(fontSize: 40),
        textAlign: TextAlign.center,
      ),
    ],
  ));
}

Widget boutons() {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      boutons2("Do"),
      boutons2("Re"),
      boutons2("Mi"),
      boutons2("Fa"),
      boutons2("Sol"),
      boutons2("La"),
      boutons2("Si"),
    ],
  ));
}

Widget boutons2(texte) {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          primary: Color.fromARGB(255, 249, 249, 249),
          onPrimary: Colors.black,
          fixedSize: const Size(35, 35),
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
        ),
        onPressed: () => {boutons3(texte)},
        child: Text(texte),
      )
    ],
  ));
}

bool p = false;

void boutons3(note) {
  Map noteTableauReverse = {
    "Do": 0,
    "Do#": 1,
    "Re": 2,
    "Re#": 3,
    "Mi": 4,
    "Fa": 5,
    "Fa#": 6,
    "Sol": 7,
    "Sol#": 8,
    "La": 9,
    "La#": 10,
    "Si": 11
  };
  double angle2 =
      ((freqNotes[octave! + 1][noteTableauReverse[note]] - distMin2!.toInt()) /
              freqNotes[octave! + 1][noteTableauReverse[note]]) *
          -6;
  print(angle2);
  if (angle2 < -6) {
    angle = -6;
  }
  angle = angle2;
}

Widget fleche(angle) {
  angle ??= 0;
  print(angle);
  return (Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 225,
        child: Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset('assets/images/demi_cercle.png',
                width: 300, height: 300),
            Positioned(
                bottom: -94,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(angle),
                  child: Image.asset('assets/images/fleche.png',
                      width: 100, height: 260),
                ))
          ],
        ),
      )
    ],
  ));
}

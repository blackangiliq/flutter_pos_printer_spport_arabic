import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printer_test_youtube/ImagestorByte.dart';
import 'package:printer_test_youtube/printer.dart';
import 'package:screenshot/screenshot.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  String dir = Directory.current.path;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(dir);
     // this func to cheeck if port are close or not 
    setState(() {
        Process.run('$dir/images/installerX64/install.exe', [' start '])
          .then((ProcessResult results) {
        print("port poen");
      });
    });
  }
  void testPrint(String printerIp, Uint8List theimageThatComesfr) async {
    print("im inside the test print 2");
    // TODO Don't forget to choose printer's paper size
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    final PosPrintResult res = await printer.connect(printerIp, port: 9100);

    if (res == PosPrintResult.success) {
      // DEMO RECEIPT
      await testReceipt(printer, theimageThatComesfr);
      print(res.msg);
      await Future.delayed(const Duration(seconds: 3), () {
        print("prinnter desconect");
        printer.disconnect();
      });
    }
  }
  TextEditingController Printer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("معاينة الوصل قبل الطباعة "),
      ),
      body: Center(
          child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: Printer,
                decoration: InputDecoration(hintText: "printer ip"),
              ),

              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text(
                  'print res',
                  style: TextStyle(fontSize: 40),
                ),
                onPressed: () {
                  screenshotController
                      .capture(delay: Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    theimageThatComesfromThePrinter = capturedImage!;
                    setState(() {
                      theimageThatComesfromThePrinter = capturedImage;
                      testPrint(Printer.text, theimageThatComesfromThePrinter);
                    });
                  }).catchError((onError) {
                    print(onError);
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Screenshot(
                controller: screenshotController,
                child: Container(
                    width: 460,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "محمد نعم 臺灣  ",
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Text(
                            "----------------------------------------------------------------------------------"),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "(  汉字 )",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "رقم الطلب",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: Text(
                              "-------------------------------------------------------------------------------------"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "التفاصيل",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 6,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "السعر ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "العدد",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "臺灣",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    flex: 6,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "تجربة عيوني انتة ",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Test My little pice of huny",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Text(
                            "----------------------------------------------------------------------------------"),
                      ],
                    )),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ],
      )),
    );
  }
}

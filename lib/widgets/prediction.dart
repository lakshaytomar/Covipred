import 'package:flutter/cupertino.dart';
import '../models/parameters.dart';
import '../dio_client.dart';
import 'package:flutter/material.dart';

class Prediction extends StatefulWidget {
  const Prediction({Key? key}) : super(key: key);

  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  late final TextEditingController _pController;
  late final TextEditingController _mController;
  late final TextEditingController _lController;
  late final TextEditingController _eController;

  final DioClient _dioClient = DioClient();

  bool isCreating = false;

  @override
  void initState() {
    _pController = TextEditingController();
    _mController = TextEditingController();
    _lController = TextEditingController();
    _eController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: _pController,
            decoration: InputDecoration(hintText: 'Enter Platelet Count'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _mController,
            decoration: InputDecoration(hintText: 'Enter Monocyte Count'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _lController,
            decoration: InputDecoration(hintText: 'Enter Leukocyte Count'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _eController,
            decoration: InputDecoration(hintText: 'Enter Eosinophils Count'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.0),
          isCreating
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isCreating = true;
                    });

                    if (_pController.text != '' &&
                        _mController.text != '' &&
                        _lController.text != '' &&
                        _eController.text != '') {
                      Parameters parameters= Parameters(
                        p: _pController.text,
                        m: _mController.text,
                        l: _lController.text,
                        e: _eController.text,
                      );

                      Parameters? retrieved =
                          await _dioClient.send(parameters: parameters);

                      if (retrieved != null) {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if('${retrieved.p}' == 'Positive') ...[
                                      Text(
                                        'ML Based COVID-19 Prediction: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0)),
                                      Text(
                                        '${retrieved.p}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 20.0)),
                                    ] else if('${retrieved.p}' == 'Negative') ...[
                                      Text(
                                        'ML Based COVID-19 Prediction: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0)),
                                      Text(
                                        '${retrieved.p}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 20.0)),
                                    ] else ...[
                                      Text(
                                        '${retrieved.p} ${retrieved.m}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0)),
                                    ],
                                    
                                    Text(''),
                                    Text(
                                        '${retrieved.m}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0)),
                                    Text(''),
                                    Text('Data you have entered:',
                                        style: TextStyle(fontSize: 16.0)),
                                    Text(
                                        'Platelet Count: ${_pController.text} thousand/μL'),
                                    Text('Monocyte Count: ${_mController.text} thousand/μL'),
                                    Text('Leukocyte Count: ${_lController.text} thousand/μL'),
                                    Text(
                                        'Eosinophils Count: ${_eController.text} thousand/μL'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }

                    setState(() {
                      isCreating = false;
                    });
                  },
                  child: Text(
                    'Predict',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
        ],
      ),
    );
  }
}

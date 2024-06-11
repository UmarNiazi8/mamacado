import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PregnancyTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pregnancy Tracker',
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(0XFFFFEE8EA),
      ),
      home: PregnancyTrackerPage(),
    );
  }
}

class PregnancyTrackerPage extends StatefulWidget {
  @override
  _PregnancyTrackerPageState createState() => _PregnancyTrackerPageState();
}

class _PregnancyTrackerPageState extends State<PregnancyTrackerPage> {
  DateTime _lastMenstrualPeriod = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  List<String> _symptoms = [];
  List<DateTime> _appointments = [];

  int _weeksPregnant = 0;

  @override
  void initState() {
    super.initState();
    _dateController.text =
        DateFormat('yyyy-MM-dd').format(_lastMenstrualPeriod);
  }

  void _calculateWeeksPregnant() {
    setState(() {
      _weeksPregnant =
          ((DateTime.now().difference(_lastMenstrualPeriod).inDays.abs()) / 7)
              .floor();
    });
  }

  void _addSymptom(String symptom) {
    if (_symptoms.length < 5) {
      setState(() {
        _symptoms.add(symptom);
      });
    }
  }

  void _addAppointment(DateTime date) {
    setState(() {
      _appointments.add(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        title: const Text(
          "Pregrency Tracking",
          style: TextStyle(letterSpacing: -1),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/39500.jpg",
                width: 400,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter your last menstrual period date:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _lastMenstrualPeriod,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != _lastMenstrualPeriod)
                    setState(() {
                      _lastMenstrualPeriod = picked;
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(_lastMenstrualPeriod);
                    });
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _calculateWeeksPregnant,
                child: Text('Calculate'),
              ),
              SizedBox(height: 20.0),
              _weeksPregnant > 0
                  ? Text(
                      'You are $_weeksPregnant weeks pregnant.',
                      style: TextStyle(fontSize: 20.0),
                    )
                  : Container(),
              SizedBox(height: 20.0),
              Text(
                'Symptom Tracking:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter symptom',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _addSymptom('');
                    },
                  ),
                ),
                onChanged: (value) {
                  if (_symptoms.isNotEmpty) {
                    _symptoms[_symptoms.length - 1] = value;
                  }
                },
              ),
              SizedBox(height: 10.0),
              Wrap(
                children: _symptoms
                    .map((symptom) => Chip(label: Text(symptom)))
                    .toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                'Appointment Reminders:',
                style: TextStyle(fontSize: 18.0),
              ),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    _addAppointment(picked);
                  }
                },
                child: Text('Add Appointment'),
              ),
              SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _appointments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      DateFormat('yyyy-MM-dd').format(_appointments[index]),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Pregnancy Progress:',
                style: TextStyle(fontSize: 18.0),
              ),
              LinearProgressIndicator(
                value: _weeksPregnant / 40, // Assuming pregnancy lasts 40 weeks
                minHeight: 20.0,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

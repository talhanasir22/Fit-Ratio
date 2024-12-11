import 'package:fit_ratio/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit Ratio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  String weightUnit = 'Kg';
  double bmiResult = 0.0;
  var health = '';
  String bmiUnit = 'kg/m²';

  void calculateBMI() {
    if (_formKey.currentState?.validate() ?? false) {
      double weight = double.parse(weightController.text);
      double feet = double.parse(feetController.text);
      double inches = double.parse(inchController.text);
      double height = (feet * 12) + inches;

      if (weightUnit == 'Lbs') {
        weight /= 2.205; // Convert lbs to kg
        bmiUnit = 'lbs/in²'; // Set BMI unit for lbs
      } else {
        bmiUnit = 'kg/m²'; // Set BMI unit for kg
      }

      height *= 2.54; // Convert height to cm
      height /= 100; // Convert height to meters

      setState(() {
        bmiResult = weight / (height * height);

        if (bmiResult > 25.01) {
          health = 'Overweight';
        } else if (bmiResult < 18.5) {
          health = 'Underweight';
        } else {
          health = 'Healthy';
        }
      });
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    feetController.dispose();
    inchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fit Ratio',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Body Mass Index',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 240,
                  child: TextFormField(
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(width: 2),
                      ),
                      labelText: 'Enter your Weight',
                      prefixIcon: const Icon(Icons.line_weight_rounded),
                      prefixIconColor: Colors.blueAccent,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'Kg',
                          groupValue: weightUnit,
                          onChanged: (value) {
                            setState(() {
                              weightUnit = value!;
                            });
                          },
                        ),
                        const Text('Kg'),
                        Radio<String>(
                          value: 'Lbs',
                          groupValue: weightUnit,
                          onChanged: (value) {
                            setState(() {
                              weightUnit = value!;
                            });
                          },
                        ),
                        const Text('lbs')
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 240,
                  child: TextFormField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    controller: feetController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(width: 2),
                      ),
                      labelText: 'Enter your height (ft)',
                      prefixIcon: const Icon(Icons.height_rounded),
                      prefixIconColor: Colors.blueAccent,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height (ft)';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 240,
                  child: TextFormField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    controller: inchController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: const BorderSide(width: 2),
                      ),
                      labelText: 'Enter your height (in)',
                      prefixIcon: const Icon(Icons.height_rounded),
                      prefixIconColor: Colors.blueAccent,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height (in)';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    'Calculate',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  bmiResult == 0.0 ? '' : 'Your BMI is ${bmiResult.toStringAsFixed(2)} $bmiUnit',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                Text(
                  bmiResult == 0.0 ? '' : 'You are $health',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

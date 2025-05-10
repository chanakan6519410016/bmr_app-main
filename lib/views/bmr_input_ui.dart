import 'package:flutter/material.dart';

class BmrInputUI extends StatefulWidget {
  const BmrInputUI({super.key});

  @override
  State<BmrInputUI> createState() => _BmrInputUIState();
}

class _BmrInputUIState extends State<BmrInputUI> {
  String selectedGender = 'ชาย';
  List<String> genderOptions = ['ชาย', 'หญิง'];

  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  double? calculatedBmr;

  void showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Text('กรอกข้อมูลไม่ครบ',
              style: TextStyle(color: Colors.redAccent)),
          content: Text(message, style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              child: Text('ตกลง', style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void calculateBMR() {
    if (ageController.text.isEmpty) {
      showErrorPopup("กรุณากรอกอายุ");
      return;
    }

    if (weightController.text.isEmpty) {
      showErrorPopup("กรุณากรอกน้ำหนัก");
      return;
    }

    if (heightController.text.isEmpty) {
      showErrorPopup("กรุณากรอกส่วนสูง");
      return;
    }

    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;
    int age = int.tryParse(ageController.text) ?? 0;

    double bmr = 0;
    if (selectedGender == 'ชาย') {
      bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
    } else {
      bmr = 655 + (19.6 * weight) + (1.8 * height) - (4.7 * age);
    }

    setState(() {
      calculatedBmr = bmr;
    });
  }

  void clscalculateBMR() {
    weightController.text = '';
    heightController.text = '';
    ageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('BMR App', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/go.jpg', // ใช้รูปใน assets
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            if (calculatedBmr != null) ...[
              Center(
                child: Column(
                  children: [
                    Text(
                      calculatedBmr!.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'kcal/day',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
            Text("Your Information",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Gender
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    dropdownColor: Colors.blue,
                    decoration: _inputDecoration('Gender'),
                    style: TextStyle(color: Colors.black),
                    iconEnabledColor: Colors.white,
                    items: genderOptions.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 15),

                  // Age
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    decoration: _inputDecoration('Age'),
                  ),
                  SizedBox(height: 15),

                  // Weight
                  TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    decoration: _inputDecoration('Weight (kg)'),
                  ),
                  SizedBox(height: 15),

                  // Height
                  TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    decoration: _inputDecoration('Height (cm)'),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: calculateBMR,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Center(
                child: Text(
                  'คำนวณ BMR',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: clscalculateBMR,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Center(
                child: Text(
                  'ล้างค่า',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

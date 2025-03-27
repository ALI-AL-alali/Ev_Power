import 'package:ev_power/widgets/mybutton2.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, this.email = ''});
  final String email;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _pinController = TextEditingController();
  bool _isLoading = false;

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              alignment: Alignment.centerRight,
              title: const Text(
                'معلومات الإرسال',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              content: Text(
                'تاكد من صندوق الرسائل الغير مرغوب فيها',
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 16),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'حسناً',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 201, 8, 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Colors.white,
              elevation: 10,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'التحقق من الرمز',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 201, 8, 8),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              color: Colors.white,
              onPressed: () {
                _showInfoDialog(context);
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'تم إرسال رمز التحقق إلى: ${widget.email}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Pinput(
                    length: 5,
                    controller: _pinController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(
                          color: const Color.fromARGB(255, 201, 8, 8),
                        ),
                      ),
                    ),
                    onCompleted: (pin) => _verifyCode(pin),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _resendCode,
                    child: const Text(
                      "إعادة إرسال الرمز",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyButton2(
                    Title: _isLoading ? 'جاري التحقق...' : 'تحقق',
                    color: const Color.fromARGB(255, 201, 8, 8),
                    onPressed: () => _verifyCode(_pinController.text),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 201, 8, 8),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyCode(String code) async {
    if (code.length != 5) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      if (code == "12345") {
        Navigator.pushReplacementNamed(context, 'reset_password_screen');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'رمز التحقق غير صحيح',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم إعادة إرسال الرمز',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.grey,
      ),
    );
  }
}

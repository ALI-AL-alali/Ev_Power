import 'package:flutter/material.dart';
import 'package:ev_power/widgets/input.dart';
import 'package:ev_power/widgets/mybutton2.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final currenwidth = MediaQuery.of(context).size.width;
    final currenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: currenheight,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Colors.indigo, Color.fromARGB(255, 0, 127, 230)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child:
                                currenwidth <= 400
                                    ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'تعيين كلمة مرور جديدة',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'أدخل كلمة مرور جديدة\nمع تأكيد كلمة المرور',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    )
                                    : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'تعيين كلمة مرور جديدة',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'أدخل كلمة مرور جديدة\nمع تأكيد كلمة المرور',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              currenwidth <= 400
                                  ? SizedBox(
                                    width: currenwidth * 0.35,
                                    child: Expanded(
                                      child: Container(
                                        child: Image.asset(
                                          'images/password.png',
                                          width: 180,
                                        ),
                                      ),
                                    ),
                                  )
                                  : SizedBox(
                                    width: currenwidth * 0.49,
                                    child: Expanded(
                                      child: Container(
                                        child: Image.asset(
                                          'images/password.png',
                                        ),
                                      ),
                                    ),
                                  ),
                              SizedBox(height: 6),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Input(
                            text: 'كلمة المرور الجديدة',
                            mycontroller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال كلمة المرور';
                              }
                              if (value.length < 8) {
                                return 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          Input(
                            text: 'تاكيد كلمة المرور',
                            mycontroller: _confirmPassword,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال كلمة المرور';
                              }
                              if (value.length < 8) {
                                return 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل';
                              }
                              if (_passwordController.text !=
                                  _confirmPassword.text) {
                                return "تاكد من تطابق كلمة المرور";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                          MyButton2(
                            Title: _isLoading ? 'جاري الإرسال...' : 'حفظ',
                            color: Colors.indigo,
                            onPressed: () {
                              Navigator.pushNamed(context, '');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.indigo),
              ),
            ),
        ],
      ),
    );
  }
}

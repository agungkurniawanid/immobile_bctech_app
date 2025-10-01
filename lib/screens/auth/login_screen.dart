import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobile_bctech_app/main.dart';
import 'package:immobile_bctech_app/providers/provider_login.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(systemIconColorProvider.notifier).state = Colors.white;
    });

    final isObscure = ref.watch(obscurePassword);
    final focusNode = ref.watch(passwordFocusNodeProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset(
                    'assets/background/main-background.png',
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/logo/main-logo.png',
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Inventory Management",
                      style: GoogleFonts.roboto(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF024110),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Divider(color: Color(0xFFAFAFAF), height: 32, thickness: 1),
                    const SizedBox(height: 24),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Color(0xFF7C7C7C)),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF024110),
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD5D8DE),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF024110),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextField(
                      focusNode: focusNode,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Color(0xFF7C7C7C)),
                        floatingLabelStyle: const TextStyle(
                          color: Color(0xFF024110),
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFD5D8DE),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF024110),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: focusNode.hasFocus
                                ? const Color(0xFF024110)
                                : Colors.black,
                          ),
                          onPressed: () {
                            ref.read(obscurePassword.notifier).state =
                                !isObscure;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF024110),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Version 1.0.0",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Color(0xFF171717),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

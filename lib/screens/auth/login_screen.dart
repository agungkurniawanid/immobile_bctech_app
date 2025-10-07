import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobile_bctech_app/const/color_const.dart';
import 'package:immobile_bctech_app/main.dart';
import 'package:immobile_bctech_app/providers/login_provider.dart';
import 'package:immobile_bctech_app/layouts/bottom_navigation_layout.dart';

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
    final primaryColor = ref.watch(primaryColorProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _buildLogoBackground(),
            _buildFormLogin(isObscure, focusNode, primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoBackground() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('assets/background/main-background.png').image,
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
    );
  }

  Widget _buildFormLogin(isObscure, focusNode, primaryColor) {
    return Align(
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
              color: Colors.black.withValues(alpha: 0.2),
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
                color: primaryColor,
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
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD5D8DE), width: 1.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
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
                floatingLabelStyle: TextStyle(
                  color: primaryColor,
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
                  borderSide: BorderSide(color: primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: focusNode.hasFocus ? primaryColor : Colors.black,
                  ),
                  onPressed: () {
                    ref.read(obscurePassword.notifier).state = !isObscure;
                  },
                ),
              ),
            ),

            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return const NavigationController();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
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
              style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

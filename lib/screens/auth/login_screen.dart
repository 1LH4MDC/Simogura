import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';

// ─────────────────────────────────────────────────────────────
//  WARNA
// ─────────────────────────────────────────────────────────────
class _C {
  static const navy  = Color(0xFF0C344D);
  static const white = Color(0xFFFFFFFF);
  static const grey  = Color(0xFF9E9E9E);
  static const line  = Color(0xFFE0E0E0);
  static const text  = Color(0xFF333333);
  static const hint  = Color(0xFFAAAAAA);
}

// ─────────────────────────────────────────────────────────────
//  LOGIN SCREEN
// ─────────────────────────────────────────────────────────────
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _rememberMe  = true;
  bool _obscurePass = true;
  bool _isLoading   = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  // ── Hash password pakai SHA-256 ──────────────────────────
  String _hashPassword(String password) {
    final bytes  = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void _onLogin() async {
    if (_usernameCtrl.text.isEmpty || _passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password tidak boleh kosong')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Hash password sebelum dikirim ke API
    final hashedPassword = _hashPassword(_passwordCtrl.text);

    // TODO: ganti Future.delayed di bawah dengan API call yang sesungguhnya
    // Contoh: await ApiService.login(_usernameCtrl.text, hashedPassword);
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.navy,
      body: SafeArea(
        child: Column(
          children: [
            // ── AREA ATAS: logo ───────────────────────────
            Expanded(
              flex: 38,
              child: Center(
                child: Image.asset(
                  'assets/images/logo_dan_nama.png',
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // ── CARD PUTIH ────────────────────────────────
            Expanded(
              flex: 62,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 20),
                decoration: BoxDecoration(
                  color: _C.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // header: tombol back + judul
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // tombol back — kembali ke onboarding
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(color: _C.line),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.chevron_left,
                                  color: _C.text,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'Selamat Datang\ndi Simogura',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _C.text,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Pantau kondisi kolam Anda secara real-time',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: _C.grey,
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // field username
                      _buildUnderlineField(
                        controller: _usernameCtrl,
                        hint: 'Username',
                        suffixIcon: const Icon(
                          Icons.person_outline,
                          color: _C.grey,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // field password
                      _buildUnderlineField(
                        controller: _passwordCtrl,
                        hint: 'Password',
                        obscure: _obscurePass,
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              setState(() => _obscurePass = !_obscurePass),
                          child: Icon(
                            _obscurePass
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: _C.grey,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // remember me
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (v) =>
                                  setState(() => _rememberMe = v ?? false),
                              activeColor: _C.navy,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              side: const BorderSide(color: _C.navy),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Remember me',
                            style: TextStyle(color: _C.text, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // tombol login
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _onLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _C.navy,
                            foregroundColor: _C.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // teks kebijakan
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                                color: _C.grey, fontSize: 11, height: 1.5),
                            children: [
                              TextSpan(
                                  text: 'Dengan masuk, Anda menyetujui '),
                              TextSpan(
                                text: 'Kebijakan Privasi & Syarat Penggunaan',
                                style: TextStyle(
                                  color: _C.navy,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: _C.navy,
                                ),
                              ),
                              TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnderlineField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: _C.text, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _C.hint, fontSize: 14),
        suffixIcon: suffixIcon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: _C.line, width: 1.2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: _C.navy, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        filled: false,
      ),
    );
  }
}
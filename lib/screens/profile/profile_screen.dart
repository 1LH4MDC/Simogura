import 'package:flutter/material.dart';

// ── Uncomment saat onboarding/login siap ──
// import '../onboarding/onboarding_screen.dart';

// ─────────────────────────────────────────────────────────────
//  WARNA
// ─────────────────────────────────────────────────────────────
class _C {
  static const navy    = Color(0xFF0C344D);
  static const blue    = Color(0xFF2FA8D5);
  static const white   = Color(0xFFFFFFFF);
  static const bg      = Color(0xFFF4F6F8);
  static const text    = Color(0xFF1A2E44);
  static const subtext = Color(0xFF7A9BB0);
  static const line    = Color(0xFFE8EEF3);
  static const hint    = Color(0xFFAAAAAA);
  static const danger  = Color(0xFFE84040);
  static const logout  = Color(0xFFB92025); // ✅ warna tombol keluar
}

// ─────────────────────────────────────────────────────────────
//  MODEL DATA PROFIL (dummy — ganti dengan data dari API)
// ─────────────────────────────────────────────────────────────
class _ProfileData {
  static String nama   = 'Ilham Dwi Cahya';
  static String email  = 'ilham@simogura.id';
  static String role   = 'Admin (Pengelola BUMDes)';
  static String avatar = 'IL';
}

// ─────────────────────────────────────────────────────────────
//  PROFILE SCREEN
// ─────────────────────────────────────────────────────────────
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  late TextEditingController _namaCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late TextEditingController _konfirmasiCtrl;
  bool _obscurePass    = true;
  bool _obscureKonfirm = true;

  @override
  void initState() {
    super.initState();
    _namaCtrl       = TextEditingController(text: _ProfileData.nama);
    _emailCtrl      = TextEditingController(text: _ProfileData.email);
    _passwordCtrl   = TextEditingController();
    _konfirmasiCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _konfirmasiCtrl.dispose();
    super.dispose();
  }

  // ── Validasi & Simpan ──────────────────────────────────────
  void _simpanPerubahan() {
    final nama    = _namaCtrl.text.trim();
    final email   = _emailCtrl.text.trim();
    final pass    = _passwordCtrl.text;
    final konfirm = _konfirmasiCtrl.text;

    if (nama.isEmpty || email.isEmpty) {
      _showAlert('Data tidak boleh kosong');
      return;
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      _showAlert('Format email tidak valid');
      return;
    }
    if (pass.isNotEmpty) {
      if (pass.length < 6) {
        _showAlert('Password minimal 6 karakter');
        return;
      }
      if (pass != konfirm) {
        _showAlert('Konfirmasi password tidak sesuai');
        return;
      }
    }

    setState(() {
      _ProfileData.nama   = nama;
      _ProfileData.email  = email;
      _ProfileData.avatar = nama.isNotEmpty ? nama[0].toUpperCase() : 'U';
      _isEditing = false;
    });
    _passwordCtrl.clear();
    _konfirmasiCtrl.clear();
    _showSuccessDialog('Profil berhasil diperbarui');
  }

  void _batalEdit() {
    setState(() {
      _namaCtrl.text  = _ProfileData.nama;
      _emailCtrl.text = _ProfileData.email;
      _passwordCtrl.clear();
      _konfirmasiCtrl.clear();
      _isEditing = false;
    });
  }

  // ── Dialog Logout ──────────────────────────────────────────
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _C.logout.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.logout, color: _C.logout, size: 28),
            ),
            const SizedBox(height: 16),
            const Text(
              'Keluar dari Sistem?',
              style: TextStyle(
                color: _C.text,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Apakah Anda yakin ingin keluar dari sistem?',
              style: TextStyle(color: _C.subtext, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          // Tombol Tidak
          SizedBox(
            width: 110,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: _C.text,
                side: const BorderSide(color: _C.line),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Tidak'),
            ),
          ),
          // Tombol Ya
          SizedBox(
            width: 110,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                // Navigasi ke onboarding/login:
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                //   (route) => false,
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _C.logout,
                foregroundColor: _C.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: const Text('Ya, Keluar'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlert(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: _C.danger,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showSuccessDialog(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.green, size: 30),
            ),
            const SizedBox(height: 16),
            Text(
              msg,
              style: const TextStyle(
                color: _C.text,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: _C.navy,
                foregroundColor: _C.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        backgroundColor: _C.navy,
        foregroundColor: _C.white,
        elevation: 0,
        automaticallyImplyLeading: false, // ✅ hapus tombol kembali
        title: Text(
          _isEditing ? 'Edit Profil' : 'Profil',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: _isEditing
            ? [
                TextButton(
                  onPressed: _batalEdit,
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: _C.white, fontSize: 13),
                  ),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),

            // ── AVATAR ────────────────────────────────────
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: _C.navy,
                      shape: BoxShape.circle,
                      border: Border.all(color: _C.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: _C.navy.withValues(alpha: 0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _ProfileData.avatar,
                        style: const TextStyle(
                          color: _C.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: _C.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: _C.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: _C.white,
                          size: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            if (!_isEditing) ...[
              Text(
                _ProfileData.nama,
                style: const TextStyle(
                  color: _C.text,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _C.blue.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _ProfileData.role,
                  style: const TextStyle(
                    color: _C.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),

            // ── CARD INFO / FORM ───────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _C.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _isEditing ? _buildEditForm() : _buildInfoView(),
            ),
            const SizedBox(height: 16),

            // ── TOMBOL EDIT PROFIL ─────────────────────────
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isEditing
                    ? _simpanPerubahan
                    : () => setState(() => _isEditing = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isEditing ? Colors.green : _C.navy,
                  foregroundColor: _C.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                icon: Icon(
                  _isEditing ? Icons.save_outlined : Icons.edit_outlined,
                  size: 18,
                ),
                label: Text(
                  _isEditing ? 'Simpan Perubahan' : 'Edit Profil',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ── TOMBOL KELUAR (merah) ──────────────────────
            if (!_isEditing)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _showLogoutDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _C.logout, // ✅ #B92025
                    foregroundColor: _C.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text(
                    'Keluar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── MODE LIHAT ─────────────────────────────────────────────
  Widget _buildInfoView() {
    return Column(
      children: [
        const _SectionTitle('Informasi Akun'),
        const SizedBox(height: 12),
        // ✅ Hanya Nama, Email, Role (tanpa ID & Login Terakhir)
        _buildInfoRow(Icons.person_outline,           'Nama',  _ProfileData.nama),
        _buildDivider(),
        _buildInfoRow(Icons.email_outlined,           'Email', _ProfileData.email),
        _buildDivider(),
        _buildInfoRow(Icons.manage_accounts_outlined, 'Role',  _ProfileData.role),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _C.navy.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _C.navy, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(color: _C.subtext, fontSize: 11)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        color: _C.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(color: _C.line, height: 1, thickness: 1);

  // ── MODE EDIT ──────────────────────────────────────────────
  Widget _buildEditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Ubah Data Profil'),
        const SizedBox(height: 16),

        _buildFieldLabel('Nama Lengkap'),
        const SizedBox(height: 6),
        _buildTextField(
          controller: _namaCtrl,
          hint: 'Masukkan nama lengkap',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 16),

        _buildFieldLabel('Email'),
        const SizedBox(height: 6),
        _buildTextField(
          controller: _emailCtrl,
          hint: 'Masukkan email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),

        Row(children: [
          Expanded(child: Divider(color: _C.line)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Ubah Password (opsional)',
              style: TextStyle(
                  color: _C.subtext.withValues(alpha: 0.8), fontSize: 11),
            ),
          ),
          Expanded(child: Divider(color: _C.line)),
        ]),
        const SizedBox(height: 16),

        _buildFieldLabel('Password Baru'),
        const SizedBox(height: 6),
        _buildTextField(
          controller: _passwordCtrl,
          hint: 'Minimal 6 karakter',
          icon: Icons.lock_outline,
          obscure: _obscurePass,
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _obscurePass = !_obscurePass),
            child: Icon(
              _obscurePass
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: _C.subtext,
              size: 18,
            ),
          ),
        ),
        const SizedBox(height: 16),

        _buildFieldLabel('Konfirmasi Password Baru'),
        const SizedBox(height: 6),
        _buildTextField(
          controller: _konfirmasiCtrl,
          hint: 'Ulangi password baru',
          icon: Icons.lock_outline,
          obscure: _obscureKonfirm,
          suffixIcon: GestureDetector(
            onTap: () => setState(() => _obscureKonfirm = !_obscureKonfirm),
            child: Icon(
              _obscureKonfirm
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: _C.subtext,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) => Text(
        label,
        style: const TextStyle(
            color: _C.text, fontSize: 13, fontWeight: FontWeight.w600),
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: _C.text, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _C.hint, fontSize: 13),
        prefixIcon: Icon(icon, color: _C.subtext, size: 18),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: _C.bg,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _C.line, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _C.line, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _C.navy, width: 1.5),
        ),
      ),
    );
  }
}

// ── Section Title ──────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: _C.navy,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: _C.text,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
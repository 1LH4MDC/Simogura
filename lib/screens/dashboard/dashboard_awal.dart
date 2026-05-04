import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';

// ─────────────────────────────────────────────────────────────
//  WARNA
// ─────────────────────────────────────────────────────────────
class _C {
  static const navy    = Color(0xFF0C344D);
  static const white   = Color(0xFFFFFFFF);
  static const bg      = Color(0xFFF4F6F8);
  static const text    = Color(0xFF1A2E44);
  static const subtext = Color(0xFF7A9BB0);
  static const line    = Color(0xFFE0E0E0);
  static const hint    = Color(0xFFAAAAAA);
}

// ─────────────────────────────────────────────────────────────
//  DASHBOARD AWAL — Empty State
// ─────────────────────────────────────────────────────────────
class DashboardAwal extends StatelessWidget {
  const DashboardAwal({super.key});

  void _goToTambahKolam(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TambahKolamScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Greeting ──────────────────────────────────
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2FA8D5).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.person, color: _C.navy, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hallo, ham',
                        style: TextStyle(
                          color: _C.text,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pantau kolam anda',
                        style: TextStyle(color: _C.subtext, fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // bell notifikasi
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: _C.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.notifications_none, color: _C.navy),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Empty State Card ───────────────────────────
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                  decoration: BoxDecoration(
                    color: _C.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Gambar kolam
                      Image.asset(
                        'assets/images/kolam.png',
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 28),

                      const Text(
                        'Belum memiliki kolam',
                        style: TextStyle(
                          color: _C.text,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tambahkan kandang anda untuk dikelola di\naplikasi Simogura',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _C.subtext,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Tombol tambah kolam
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => _goToTambahKolam(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _C.navy,
                            foregroundColor: _C.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Tambah Kolam',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  TAMBAH KOLAM SCREEN — Form
// ─────────────────────────────────────────────────────────────
class TambahKolamScreen extends StatefulWidget {
  const TambahKolamScreen({super.key});

  @override
  State<TambahKolamScreen> createState() => _TambahKolamScreenState();
}

class _TambahKolamScreenState extends State<TambahKolamScreen> {
  final _namaCtrl      = TextEditingController();
  final _alamatCtrl    = TextEditingController();
  final _kapasitasCtrl = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _namaCtrl.dispose();
    _alamatCtrl.dispose();
    _kapasitasCtrl.dispose();
    super.dispose();
  }

  void _simpanKolam() async {
    // Validasi
    if (_namaCtrl.text.trim().isEmpty) {
      _showSnack('Nama kolam tidak boleh kosong');
      return;
    }
    if (_alamatCtrl.text.trim().isEmpty) {
      _showSnack('Alamat kolam tidak boleh kosong');
      return;
    }
    if (_kapasitasCtrl.text.trim().isEmpty) {
      _showSnack('Total kapasitas tidak boleh kosong');
      return;
    }

    setState(() => _isSaving = true);

    // TODO: ganti dengan API call untuk menyimpan kolam
    // Contoh: await ApiService.tambahKolam(namaCtrl.text, ...);
    await Future.delayed(const Duration(milliseconds: 800));

    setState(() => _isSaving = false);

    if (!mounted) return;

    // Navigasi ke DashboardScreen, hapus semua halaman sebelumnya
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
      (route) => false,
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        backgroundColor: _C.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.chevron_left, color: _C.text, size: 28),
        ),
        title: const Text(
          'Tambah Kolam',
          style: TextStyle(
            color: _C.text,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Form ────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _C.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informasi  kolam',
                        style: TextStyle(
                          color: _C.text,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Nama Kolam
                      _buildLabel('Nama kolam'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _namaCtrl,
                        hint: 'Tuliskan nama kandang',
                      ),
                      const SizedBox(height: 18),

                      // Alamat Kolam
                      _buildLabel('Alamat Kolam'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _alamatCtrl,
                        hint: 'Tulis alamat',
                      ),
                      const SizedBox(height: 18),

                      // Total Kapasitas
                      _buildLabel('Total kapasitas kandang (ekor)'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _kapasitasCtrl,
                        hint: '',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Tombol Simpan ────────────────────────────────
            Container(
              color: _C.white,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _simpanKolam,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _C.navy,
                    foregroundColor: _C.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Simpan kolam',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            letterSpacing: 0.3,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: _C.text,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: _C.text, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _C.hint, fontSize: 13),
        filled: true,
        fillColor: _C.bg,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _C.navy, width: 1.5),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../controllers/kolam_controller.dart';
import '../../models/akun_model.dart';
import '../../models/kolam_model.dart';
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
//  DASHBOARD AWAL — List or Empty State
// ─────────────────────────────────────────────────────────────
class DashboardAwal extends StatefulWidget {
  final AkunModel user;
  const DashboardAwal({super.key, required this.user});

  @override
  State<DashboardAwal> createState() => _DashboardAwalState();
}

class _DashboardAwalState extends State<DashboardAwal> {
  final _kolamController = KolamController();
  List<KolamModel> _kolams = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchKolams();
  }

  Future<void> _fetchKolams() async {
    setState(() => _isLoading = true);
    try {
      final data = await _kolamController.getKolams(widget.user.id!);
      setState(() => _kolams = data);
    } catch (e) {
      debugPrint("FETCH_KOLAM_ERROR: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _goToTambahKolam(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TambahKolamScreen(userId: widget.user.id!),
      ),
    );

    if (result == true) {
      _fetchKolams();
    }
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
                    children: [
                      Text(
                        'Hallo, ${widget.user.username ?? "User"}',
                        style: const TextStyle(
                          color: _C.text,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Pantau kolam anda',
                        style: TextStyle(color: _C.subtext, fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
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

              // ── Content ───────────────────────────
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _kolams.isEmpty
                        ? _buildEmptyState(context)
                        : _buildKolamList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _kolams.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => _goToTambahKolam(context),
              backgroundColor: _C.navy,
              child: const Icon(Icons.add, color: _C.white),
            )
          : null,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildKolamList() {
    return ListView.builder(
      itemCount: _kolams.length,
      itemBuilder: (context, index) {
        final kolam = _kolams[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: _C.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _C.bg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.waves, color: _C.navy),
            ),
            title: Text(
              kolam.lokasi ?? 'Kolam Tanpa Nama',
              style: const TextStyle(
                color: _C.text,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Terdaftar pada: ${kolam.createdAt?.day}/${kolam.createdAt?.month}/${kolam.createdAt?.year}',
              style: const TextStyle(color: _C.subtext, fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right, color: _C.subtext),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              );
            },
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  TAMBAH KOLAM SCREEN — Form
// ─────────────────────────────────────────────────────────────
class TambahKolamScreen extends StatefulWidget {
  final int userId;
  const TambahKolamScreen({super.key, required this.userId});

  @override
  State<TambahKolamScreen> createState() => _TambahKolamScreenState();
}

class _TambahKolamScreenState extends State<TambahKolamScreen> {
  final _lokasiCtrl    = TextEditingController();
  final _kolamController = KolamController();
  bool _isSaving = false;

  @override
  void dispose() {
    _lokasiCtrl.dispose();
    super.dispose();
  }

  void _simpanKolam() async {
    if (_lokasiCtrl.text.trim().isEmpty) {
      _showSnack('Lokasi/Nama kolam tidak boleh kosong');
      return;
    }

    setState(() => _isSaving = true);

    try {
      await _kolamController.createKolam(_lokasiCtrl.text.trim(), widget.userId);
      
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      _showSnack('Gagal menyimpan kolam: $e');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
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

                      _buildLabel('Lokasi / Nama kolam'),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _lokasiCtrl,
                        hint: 'Tuliskan nama atau lokasi kandang',
                      ),
                    ],
                  ),
                ),
              ),
            ),

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
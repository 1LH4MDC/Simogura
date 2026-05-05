import 'package:flutter/material.dart';
import '../profile/profile_screen.dart';

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
  static const green   = Color(0xFF4CAF50);
  static const card    = Color(0xFFFFFFFF);
}

// ─────────────────────────────────────────────────────────────
//  MODEL DATA IoT (dummy — nanti diganti API)
// ─────────────────────────────────────────────────────────────
class _SensorData {
  // ⚠️ DATA DUMMY — ganti dengan data dari API IoT teman kamu
  static double suhu        = 29.0;   // °C
  static double kelembaban  = 23.0;   // %
  static double kadarAmonia = 20.0;   // ppm
  static double pakan       = 35.0;   // kg
  static double volumeAir   = 50.0;   // %
  static int    hariKe      = 2;
  static int    targetHari  = 35;
  static String namaKolam   = 'Kolam Pertama';
  static String namaUser    = 'ham';
  static int    notifCount  = 3;
}

// ─────────────────────────────────────────────────────────────
//  DASHBOARD SCREEN
// ─────────────────────────────────────────────────────────────
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: _navIndex == 0
            ? _buildHomePage()
            : _navIndex == 1
                ? _buildMonitoringPage()
                : _buildProfilPage(),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── HOME PAGE ─────────────────────────────────────────────
  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Greeting + notifikasi ──────────────────────
          Row(
            children: [
              // avatar
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _C.blue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person, color: _C.navy, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hallo, ${_SensorData.namaUser}',
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
              ),
              // bell notifikasi
              Stack(
                children: [
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
                    child:
                        const Icon(Icons.notifications_none, color: _C.navy),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${_SensorData.notifCount}',
                          style: const TextStyle(
                              color: _C.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Selector kolam ─────────────────────────────
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: _C.navy,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                  _SensorData.namaKolam,
                  style: const TextStyle(
                    color: _C.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _C.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: _C.navy, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Card siklus aktif ──────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _C.navy,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Siklus Aktif',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Hari ke ${_SensorData.hariKe}',
                          style: const TextStyle(
                            color: _C.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: _C.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Target : ${_SensorData.targetHari} hari',
                        style: const TextStyle(
                          color: _C.navy,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _C.white,
                      side: const BorderSide(
                          color: Colors.white38, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Lihat Detail',
                        style: TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Card Suhu (full width) ─────────────────────
          _buildSensorCardFull(
            label: 'Suhu',
            value: _SensorData.suhu.toStringAsFixed(0),
            unit: '°C',
            statusText: 'Suhu ideal kandang',
            icon: Icons.thermostat_outlined,
            iconColor: const Color(0xFF4FC3F7),
            valueColor: _C.green,
          ),
          const SizedBox(height: 12),

          // ── Card Kelembaban + Kadar Amonia (2 kolom) ───
          Row(
            children: [
              Expanded(
                child: _buildSensorCardHalf(
                  label: 'Kelembaban',
                  value: _SensorData.kelembaban.toStringAsFixed(0),
                  unit: '%',
                  statusText: 'Suhu ideal kandang',
                  icon: Icons.water_drop_outlined,
                  iconColor: const Color(0xFF4FC3F7),
                  valueColor: _C.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSensorCardHalf(
                  label: 'Kadar Amonia',
                  value: _SensorData.kadarAmonia.toStringAsFixed(0),
                  unit: 'ppm',
                  statusText: 'Kadar Amonia Normal',
                  icon: Icons.science_outlined,
                  iconColor: const Color(0xFFFFB74D),
                  valueColor: _C.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Card Pakan + Volume Air (2 kolom) ──────────
          Row(
            children: [
              Expanded(
                child: _buildSensorCardHalf(
                  label: 'Pakan',
                  value: _SensorData.pakan.toStringAsFixed(0),
                  unit: 'kg',
                  statusText: 'Total pakan 2 hari',
                  icon: Icons.set_meal_outlined,
                  iconColor: const Color(0xFFFF8A65),
                  valueColor: _C.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSensorCardHalf(
                  label: 'Volume Air',
                  value: _SensorData.volumeAir.toStringAsFixed(0),
                  unit: '%',
                  statusText: 'Volume air tercukupi',
                  icon: Icons.water_outlined,
                  iconColor: const Color(0xFF4FC3F7),
                  valueColor: _C.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── CARD SENSOR FULL WIDTH ─────────────────────────────────
  Widget _buildSensorCardFull({
    required String label,
    required String value,
    required String unit,
    required String statusText,
    required IconData icon,
    required Color iconColor,
    required Color valueColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ikon kiri
          Container(
            width: 56,
            height: 70,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            color: _C.text,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    const Icon(Icons.chevron_right,
                        color: _C.subtext, size: 18),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: TextStyle(
                          color: valueColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: unit,
                        style: TextStyle(
                          color: valueColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(statusText,
                    style: const TextStyle(
                        color: _C.subtext, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── CARD SENSOR HALF WIDTH ─────────────────────────────────
  Widget _buildSensorCardHalf({
    required String label,
    required String value,
    required String unit,
    required String statusText,
    required IconData icon,
    required Color iconColor,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: _C.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              const Icon(Icons.chevron_right, color: _C.subtext, size: 16),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(statusText,
              style: const TextStyle(color: _C.subtext, fontSize: 10)),
        ],
      ),
    );
  }

  // ── PLACEHOLDER PAGES ──────────────────────────────────────
  Widget _buildMonitoringPage() {
    return const Center(
      child: Text('Halaman Monitoring',
          style: TextStyle(color: _C.text, fontSize: 16)),
    );
  }

Widget _buildProfilPage() {
  return const ProfileScreen();
}

  // ── BOTTOM NAVIGATION ──────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: _C.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        backgroundColor: _C.white,
        selectedItemColor: _C.navy,
        unselectedItemColor: _C.subtext,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
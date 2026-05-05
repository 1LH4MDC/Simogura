import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/kolam_model.dart';

class KolamController {
  final _supabase = Supabase.instance.client;

  // Fetch semua kolam berdasarkan created_by
  Future<List<KolamModel>> getKolams(int userId) async {
    try {
      final response = await _supabase
          .from('kolam')
          .select()
          .eq('created_by', userId);
      
      return (response as List).map((e) => KolamModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Tambah Kolam
  Future<KolamModel> createKolam(String lokasi, int userId) async {
    try {
      final response = await _supabase
          .from('kolam')
          .insert({
            'lokasi': lokasi,
            'created_by': userId,
          })
          .select()
          .single();
      
      return KolamModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Update Kolam
  Future<void> updateKolam(String id, String lokasi) async {
    try {
      await _supabase
          .from('kolam')
          .update({'lokasi': lokasi})
          .eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  // Hapus Kolam
  Future<void> deleteKolam(String id) async {
    try {
      await _supabase
          .from('kolam')
          .delete()
          .eq('id', id);
    } catch (e) {
      rethrow;
    }
  }
}

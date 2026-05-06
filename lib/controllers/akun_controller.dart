import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/akun_model.dart';

class AkunController {
  final _supabase = Supabase.instance.client;

  // Hashing password dengan SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  // Login
  Future<AkunModel?> login(String username, String password) async {
    try {
      final hash = _hashPassword(password);
      
      final response = await _supabase
          .from('akun')
          .select()
          .eq('username', username)
          .maybeSingle();

      if (response == null) {
        throw 'Username tidak ditemukan.';
      }

      if (response['password'] != hash) {
        throw 'Password salah.';
      }

      // Update lastlogin_at
      await _supabase
          .from('akun')
          .update({'lastlogin_at': DateTime.now().toIso8601String()})
          .eq('id', response['id']);

      return AkunModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Update Profile
  Future<void> updateProfile(int id, Map<String, dynamic> data) async {
    try {
      if (data.containsKey('password') && data['password'] != null) {
        data['password'] = _hashPassword(data['password']);
      }
      
      await _supabase
          .from('akun')
          .update(data)
          .eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Current User (Example)
  Future<AkunModel?> fetchProfile(int id) async {
    try {
      final response = await _supabase
          .from('akun')
          .select()
          .eq('id', id)
          .maybeSingle();
      
      if (response != null) {
        return AkunModel.fromJson(response);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}

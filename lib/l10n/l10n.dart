import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('ar', ''), // Arabic, no country code
    const Locale('en', ''), // English, no country code
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ar':
        return '🇸🇦';
      case 'en':
      default:
        return '🇺🇸';
    }
  }
}

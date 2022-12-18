import 'package:flutter/material.dart';

/// This class has a property
class IrsBasePage {
  /// This is the title of the page
  final String title;

  /// This is the icon of the page
  final IconData icon;

  /// This is the widget that represents the page
  final Widget page;

  /// This is the constructor
  const IrsBasePage({
    required this.title,
    required this.icon,
    required this.page,
  });
}

extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeEach {
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  String get initials {
    final parts = trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return isNotEmpty ? this[0].toUpperCase() : '';
  }

  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(r'^\+?[\d\s-]{7,15}$').hasMatch(this);
  }

  String get maskedPhone {
    if (length < 7) return this;
    return '${substring(0, 3)}****${substring(length - 3)}';
  }

  String get toTitleCase {
    return split(RegExp(r'(?<=[a-z])(?=[A-Z])| '))
        .map((word) => word.capitalize)
        .join(' ');
  }

  bool get isNumeric => double.tryParse(this) != null;
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? route;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppStatCard(
        title: title,
        value: value,
        icon: icon,
        color: color,
        onTap: route != null ? () => context.push(route!) : null,
      ),
    );
  }
}

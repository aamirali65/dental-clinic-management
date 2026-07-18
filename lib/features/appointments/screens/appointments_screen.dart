import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../shared/models/appointment_model.dart';
import '../../../core/utils/mock_data.dart';
import '../widgets/appointment_card.dart';
import '../providers/appointments_provider.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _statusFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointments = ref.watch(appointmentsProvider);
    final filteredAppointments = _filterAppointments(appointments);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/book-appointment'),
        child: const Icon(Icons.add_rounded),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              AppSpacing.sm,
              AppSpacing.screenPadding,
              AppSpacing.sm,
            ),
            child: AppSearchBar(
              hintText: 'Search appointments...',
              onChanged: (v) => setState(() => _searchQuery = v),
              showFilter: true,
              onFilterTap: () => _showFilterSheet(),
            ),
          ),
          _buildCalendar(),
          _buildStatusFilter(),
          Expanded(
            child: filteredAppointments.isEmpty
                ? const AppEmptyState(
                    title: 'No Appointments',
                    description: 'No appointments found for this date',
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: AppSpacing.sm),
                    itemCount: filteredAppointments.length,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                        appointment: filteredAppointments[index],
                      ).animate().fadeIn(
                            duration: 300.ms,
                            delay: (index * 50).ms,
                          ).slideX(begin: 0.05, curve: Curves.easeOut);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
      ),
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 30)),
        lastDay: DateTime.now().add(const Duration(days: 60)),
        focusedDay: _selectedDate,
        selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) => setState(() => _calendarFormat = format),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() => _selectedDate = selectedDay);
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
          leftChevronIcon: const Icon(Icons.chevron_left_rounded, color: AppColors.textGrey),
          rightChevronIcon: const Icon(Icons.chevron_right_rounded, color: AppColors.textGrey),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          todayTextStyle: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
          selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          defaultTextStyle: Theme.of(context).textTheme.bodyMedium!,
          weekendTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.textGrey),
          outsideTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.textLight),
          markerDecoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                bottom: 1,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }
            return null;
          },
        ),
        eventLoader: (day) {
          return MockData.appointments.where((a) => a.date.year == day.year && a.date.month == day.month && a.date.day == day.day).toList();
        },
      ),
    );
  }

  Widget _buildStatusFilter() {
    final statuses = ['All', 'Scheduled', 'Confirmed', 'Completed', 'Cancelled'];
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
          vertical: AppSpacing.sm,
        ),
        itemCount: statuses.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final isSelected = _statusFilter == statuses[index];
          return GestureDetector(
            onTap: () => setState(() => _statusFilter = statuses[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkCard
                        : AppColors.card,
                borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                border: !isSelected
                    ? Border.all(color: AppColors.border)
                    : null,
              ),
              child: Text(
                statuses[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<AppointmentModel> _filterAppointments(List<AppointmentModel> appointments) {
    return appointments.where((a) {
      final dateMatch = a.date.year == _selectedDate.year && a.date.month == _selectedDate.month && a.date.day == _selectedDate.day;
      final statusMatch = _statusFilter == 'All' ||
          '${a.status.name[0].toUpperCase()}${a.status.name.substring(1)}' == _statusFilter;
      final searchMatch = _searchQuery.isEmpty ||
          a.patientName.toLowerCase().contains(_searchQuery.toLowerCase());
      return dateMatch && statusMatch && searchMatch;
    }).toList();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkCard : AppColors.card,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXxl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const Text('Filter Appointments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.xxl),
            const Text('Status'),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: ['All', 'Scheduled', 'Confirmed', 'In Progress', 'Completed', 'Cancelled']
                  .map((s) => FilterChip(
                        label: Text(s),
                        selected: _statusFilter == s,
                        onSelected: (_) {
                          setState(() => _statusFilter = s);
                          Navigator.pop(context);
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/daily_intake_stats/daily_intake_stats_viewmodel.dart';
import '../../widgets/auth/auth_widgets.dart';
import '../../widgets/daily_intake_stats/daily_intake_stats_widgets.dart';

// Entry point for the daily intake stats screen
//
// First screen after login or continue as guest (for now)
// Shows daily calorie summary, macros, and the days meal list
class DailyIntakeView extends StatefulWidget {
  const DailyIntakeView({super.key});

  @override
  State<DailyIntakeView> createState() => _DailyIntakeViewState();
}

class _DailyIntakeViewState extends State<DailyIntakeView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DailyIntakeViewModel>().loadDailyIntake();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const _DailyIntakeContent();
  }
}

// internal ui for the daily intake stats
// watches DailyIntakeViewModel and rebuilds when state changes
class _DailyIntakeContent extends StatelessWidget {
  const _DailyIntakeContent();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DailyIntakeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FitStrive'),
        // no back button, daily intake stats is the root screen after login (for now)
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                _formatDate(vm.selectedDate),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(context, vm),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: add navigation to 'add a meal' button
          Navigator.pushNamed(context, '/log-food');
          if (context.mounted) {
            context.read<DailyIntakeViewModel>().loadDailyIntake();
          }
        },
        tooltip: 'Add meal',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DailyIntakeViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FsErrorBanner(message: vm.errorMessage!),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: vm.loadDailyIntake,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: vm.loadDailyIntake,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // calorie summary card
          CalorieSummaryCard(summary: vm.summary),
          const SizedBox(height: 8),

          // macro breakdown
          MacroRow(summary: vm.summary),
          const SizedBox(height: 24),

          // menu grid
          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildMenuCard(context, 'Log Exercise', Icons.fitness_center),
              _buildMenuCard(context, 'My Goals', Icons.flag),
              _buildMenuCard(context, 'Statistics', Icons.bar_chart),
              _buildMenuCard(context, 'Profile', Icons.person),
            ],
          ),

          const SizedBox(height: 24),

          // meals section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's meals",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {
                  // TODO: add navigation to 'see all' button to a list of all todays entries
                  // Navigator.pushNamed(context, '/nutrition');
                },
                child: const Text('See all'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // meals list or empty state
          if (!vm.hasMeals)
            const EmptyMealsPlaceholder()
          else
            ...vm.meals.map(
              (meal) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: MealListItem(
                  meal: meal,
                  onDelete: () => vm.deleteMeal(meal.id),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Widget _buildMenuCard(
    BuildContext context,
    String cardName,
    IconData myIcon,
  ) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          if (cardName == 'Log Food') {
            Navigator.pushNamed(context, '/log-food');
          } else if (cardName == 'Log Exercise') {
            Navigator.pushNamed(context, '/log-weight');
          } else if (cardName == 'My Goals') {
            Navigator.pushNamed(context, '/my-goals');
          } else if (cardName == 'Profile') {
            Navigator.pushNamed(context, '/profile');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(cardName + ' screen coming soon!')),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              myIcon,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

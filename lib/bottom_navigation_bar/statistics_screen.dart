import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker_app/constraint/app_constraint.dart';
import 'package:habits_tracker_app/model/weekly_habit_data.dart';
import 'package:habits_tracker_app/services/habit_storage_services.dart';
import 'package:habits_tracker_app/widgets/habit_chart_widget.dart';
import 'package:habits_tracker_app/widgets/habit_detailed_dialog_widget.dart';
import 'package:habits_tracker_app/widgets/state_card_widget.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
  /// list for weekly data and animation controller //////
  List<WeeklyHabitData> weeklyData = [];
  bool isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.defaultAnimationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadWeeklyData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadWeeklyData() async {
    await HabitStorageService.initialize();

    try {
      List<WeeklyHabitData> loadedData =
          await HabitStorageService.loadWeeklyData();

      if (loadedData.isEmpty) {
        loadedData = HabitStorageService.initializeWeekData();
        await HabitStorageService.saveWeeklyData(loadedData);
      }

      setState(() {
        weeklyData = loadedData;
        isLoading = false;
      });

      _animationController.forward();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading data: $e');
      }
      setState(() {
        weeklyData = HabitStorageService.initializeWeekData();
        isLoading = false;
      });
      _animationController.forward();
    }
  }

  void _simulateHabitCompletion() {
    if (weeklyData.isEmpty) return;

    final random = Random();
    final dayIndex = random.nextInt(weeklyData.length);
    final currentData = weeklyData[dayIndex];

    final availableHabits = AppConstants.sampleHabits
        .where((habit) => !currentData.completedHabitNames.contains(habit))
        .toList();

    /// showing the snack bar //////
    if (availableHabits.isEmpty) {
      _showSnackBar(
        'All habits completed for ${currentData.weekday}! 🎉',
        Colors.green,
      );
      return;
    }

    final habitsToComplete = min(availableHabits.length, random.nextInt(3) + 1);
    final selectedHabits = <String>[];

    //// here we use for loop ///////
    for (int i = 0; i < habitsToComplete; i++) {
      final habitIndex = random.nextInt(availableHabits.length);
      final selectedHabit = availableHabits.removeAt(habitIndex);
      selectedHabits.add(selectedHabit);
    }

    ///// for new habit //////
    final newCompletedHabits = [
      ...currentData.completedHabitNames,
      ...selectedHabits,
    ];
    final newPercentage =
        (newCompletedHabits.length / AppConstants.sampleHabits.length) * 100;

    // this set state for weekly data ///////
    setState(() {
      weeklyData[dayIndex] = currentData.copyWith(
        completionPercentage: newPercentage,
        completedHabits: newCompletedHabits.length,
        completedHabitNames: newCompletedHabits,
      );
    });

    HabitStorageService.saveWeeklyData(weeklyData);
    _animationController.reset();
    _animationController.forward();

    final habitsList = selectedHabits.join(', ');
    _showSnackBarWithAction('Completed: $habitsList', Colors.green, dayIndex);
  }

  ////// snackbar /////
  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: AppConstants.snackBarDuration,
      ),
    );
  }

  ////// function for showing snack bar ///////
  void _showSnackBarWithAction(
    String message,
    Color backgroundColor,
    int dayIndex,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: AppConstants.snackBarDuration,
        action: SnackBarAction(
          label: 'View Details',
          textColor: Colors.white,
          onPressed: () => _showHabitDetails(dayIndex),
        ),
      ),
    );
  }

  /////// function for showing habit detailed  /////
  void _showHabitDetails(int dayIndex) {
    if (dayIndex >= 0 && dayIndex < weeklyData.length) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return HabitDetailedDialogWidget(data: weeklyData[dayIndex]);
        },
      );
    }
  }

  double get _averageCompletion {
    if (weeklyData.isEmpty) return 0;
    final total = weeklyData.fold<double>(
      0,
      (sum, data) => sum + data.completionPercentage,
    );
    return total / weeklyData.length;
  }

  int get _currentStreak {
    int streak = 0;
    for (int i = weeklyData.length - 1; i >= 0; i--) {
      if (weeklyData[i].completionPercentage >= AppConstants.streakThreshold) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  String _getBestDay() {
    if (weeklyData.isEmpty) return "None";

    var bestDay = weeklyData.reduce(
      (a, b) => a.completionPercentage > b.completionPercentage ? a : b,
    );

    if (bestDay.completionPercentage == 0) return "None Yet";

    return "${bestDay.weekday} (${bestDay.completionPercentage.toStringAsFixed(0)}%)";
  }

  /// here code is for function motivation header and itis call in the bottom
  Widget _buildMotivationalHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppConstants.primaryGradientStart,
            AppConstants.primaryGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Your Habit Journey",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${_averageCompletion.toStringAsFixed(1)}% Average This Week",
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  /// here is code function for chart section //////
  Widget _buildChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Weekly Habit Completion",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Tap any day on the chart to see detailed habit breakdown",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white60,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: AppConstants.chartHeight,
              decoration: BoxDecoration(
                color: AppConstants.cardBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: HabitChartWidget(
                  weeklyData: weeklyData,
                  animation: _animation,
                  onDayTapped: _showHabitDetails,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  ////// here is a fucntion for statistics section ////////
  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Week Overview",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: StateCardWidget(
                title: "Current Streak",
                value: "$_currentStreak Days",
                icon: Icons.local_fire_department,
                color: Colors.orangeAccent,
                gradient: const [Color(0xFFFF6B35), Color(0xFFFF8E53)],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: StateCardWidget(
                title: "Best Day",
                value: _getBestDay(),
                icon: Icons.star,
                color: Colors.yellowAccent,
                gradient: const [Color(0xFFFFD700), Color(0xFFFFA500)],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: StateCardWidget(
                title: "Total Habits",
                value: "${AppConstants.sampleHabits.length}",
                icon: Icons.checklist,
                color: Colors.greenAccent,
                gradient: const [Color(0xFF10B981), Color(0xFF34D399)],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: StateCardWidget(
                title: "Completion Rate",
                value: "${_averageCompletion.toStringAsFixed(0)}%",
                icon: Icons.trending_up,
                color: Colors.blueAccent,
                gradient: const [Color(0xFF3B82F6), Color(0xFF60A5FA)],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Weekly Progress",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppConstants.cardBackgroundColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMotivationalHeader(),
                    const SizedBox(height: 30),
                    _buildChartSection(),
                    const SizedBox(height: 30),
                    _buildStatisticsSection(),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _simulateHabitCompletion,
        backgroundColor: AppConstants.primaryGradientStart,
        icon: const Icon(Icons.add_task, color: Colors.white),
        label: const Text(
          "Complete Habit",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

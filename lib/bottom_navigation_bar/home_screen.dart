import 'package:flutter/material.dart';
//import 'package:habits_tracker_app/bottom_navigation_bar/statistics_screen.dart';
import 'package:habits_tracker_app/card_detailed_screen/card_detailed_screen.dart';
import 'package:habits_tracker_app/model/habit_model.dart';
import 'package:habits_tracker_app/model/habit_model_extansion.dart';
import 'package:habits_tracker_app/model/individual_habit_model.dart';
import 'package:habits_tracker_app/new_habit_screen/new_habits_screen.dart';
import 'package:habits_tracker_app/widgets/habit_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //// here we call our habit model we craete in seperate file ///
  List<HabitModel> cards = [
    HabitModel(
      id: "1",
      title: "Reading Books",
      imagepath: "",
      ontap: () {},
      backgroundColor: Colors.orange,
      habits: [],
    ),
    HabitModel(
      id: "2",
      title: "Daily Exercise",
      imagepath: "",
      ontap: () {},
      backgroundColor: Colors.green,
      habits: [],
    ),
    HabitModel(
      id: "3",
      title: "Drinking Water",
      imagepath: "",
      ontap: () {},
      backgroundColor: Colors.blueAccent,
      habits: [],
    ),
    HabitModel(
      id: "4",
      title: "Healthy Eating",
      imagepath: "",
      ontap: () {},
      backgroundColor: Colors.deepPurple,
      habits: [],
    ),
  ];

//// this widget for header section in the app and call it in the bottom ///////
  Widget _buildHeaderSection() {
    int totalHabits = cards.fold(0, (sum, card) => sum + card.habits.length);

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: const Color(0xFF4F46E5).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
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
                  Text(
                    _getGreeting(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Keep building great habits!",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Quick stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickStat("Categories", "${cards.length}"),
              _buildQuickStat("Total Habits", "$totalHabits"),
              _buildQuickStat("Streak", "12 days"),
            ],
          ),
        ],
      ),
    );
  }

//// this widget for quick start ///////
  Widget _buildQuickStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

////// this is for showing time in app on the top in the home screen ///////////
   String _getGreeting() {
    final hour = DateTime.now().hour;
     if (hour >= 6 && hour < 12) {
    return "Good Morning! 🌅";
  } else if (hour >= 12 && hour < 17) {
    return "Good Afternoon! ☀️";
  } else if (hour >= 17 && hour < 19) {
    return "Good Evening! 🌆";
  } else {
    return "Good Night! 🌙";
  }
}


//// create funstion for update the card /////////
  void _updateCard(HabitModel updatedCard) {
    setState(() {
      final index = cards.indexWhere((card) => card.id == updatedCard.id);
      if (index != -1) {
        cards[index] = updatedCard;
      }
    });
  }

//// create function for add habit card /////////
  void _addHabitToCard(String cardId, IndividualHabitModel habit) {
    setState(() {
      final index = cards.indexWhere((card) => card.id == cardId);
      if (index != -1) {
        cards[index] = cards[index].addHabit(habit);
      }
    });
  }



//// create funstion for navigate to card detaile /////////
  void _navigateToCardDetail(HabitModel card) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CardDetailScreen(card: card, onCardUpdated: _updateCard),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1421), // Dark theme background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F2442),
        elevation: 0,
        title: const Text(
          "My Habits",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          // Statistics button in app bar
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const StatisticsScreen(),
          //       ),
          //     );
          //   },
          //   icon: const Icon(Icons.analytics_outlined, color: Colors.white),
          //   tooltip: 'View Statistics',
          // ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section with greeting and stats
          _buildHeaderSection(),

          // Habits grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85, // Adjust card height
                children: cards
                    .map(
                      (card) => HabitCardWidget(
                        card: card.copyWith(
                          ontap: () => _navigateToCardDetail(card),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// this button for showing the statistics button on the home screen ///////
          // Statistics FAB
          // FloatingActionButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const StatisticsScreen(),
          //       ),
          //     );
          //   },
          //   backgroundColor: const Color(0xFF4F46E5),
          //   heroTag: "statistics", // Unique tag for multiple FABs
          //   child: const Icon(Icons.bar_chart, color: Colors.white),
          // ),
          const SizedBox(height: 16),
          // Add habit FAB
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewHabitsScreen(
                    cards: cards,
                    onHabitSaved: _addHabitToCard,
                  ),
                ),
              );
            },
            backgroundColor: const Color(0xFF06B6D4),
            heroTag: "add_habit", // Unique tag for multiple FABs
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  
  
 
}



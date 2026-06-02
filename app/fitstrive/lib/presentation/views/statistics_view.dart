import 'package:flutter/material.dart';
import '../models/temp_profile_data.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  void _confirmAndResetGoal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🎉Congratulations! 🎉', textAlign: TextAlign.center),
        content: Text(
          'You reached your goal! Do you want to confirm your progress and reset?',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Not Yet', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              TempProfileData.weightLogByDate.clear();
              TempProfileData.targetDailyWeightDeficit = 0.0;
              TempProfileData.totalTargetAmount = 0.0;
              TempProfileData.goalType = '';
              TempProfileData.deadlineDate = '';

              Navigator.pop(context); 
              Navigator.pop(context); 
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('History cleared. Ready for your next goal!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text('Confirm & Reset', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> weightData = TempProfileData.weightLogByDate;

    List<String> sortedDates = weightData.keys.toList();
    sortedDates.sort();

    bool isGoalAchieved = false;
    if (TempProfileData.totalTargetAmount > 0 && sortedDates.isNotEmpty) {
      double startWeight = weightData[sortedDates.first]!;
      double currentWeight = weightData[sortedDates.last]!;
      
      if (TempProfileData.goalType == 'Lose Weight') {

        if (currentWeight <= startWeight - TempProfileData.totalTargetAmount) {
          isGoalAchieved = true;
        }
      } else if (TempProfileData.goalType == 'Gain Weight') {

        if (currentWeight >= startWeight + TempProfileData.totalTargetAmount) {
          isGoalAchieved = true;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Progress'),
      ),
      body: weightData.isEmpty 
          ? Center(
              child: Text(
                'No weight data yet!\nGo to the Dashboard to log today.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Padding(
              padding: EdgeInsets.all(20.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isGoalAchieved)
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.amber.shade400, width: 2),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.emoji_events, color: Colors.amber.shade800, size: 48),
                          SizedBox(height: 8),
                          Text('GOAL COMPLETED!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber.shade900)),
                          SizedBox(height: 4),
                          Text('You successfully reached your target.', style: TextStyle(color: Colors.amber.shade800)),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _confirmAndResetGoal,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber.shade600, 
                              foregroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 45)
                            ),
                            child: Text('Reset', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    )

                  else if (TempProfileData.totalTargetAmount > 0)
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.purple.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.emoji_events, color: Colors.purple.shade700, size: 36),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Current Goal', style: TextStyle(color: Colors.purple.shade900, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text(
                                  TempProfileData.goalType + ' ' + TempProfileData.totalTargetAmount.toString() + ' kg by ' + TempProfileData.deadlineDate,
                                  style: TextStyle(color: Colors.purple.shade800, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  Text(
                    'Weight Trend',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Latest Weight', style: TextStyle(fontSize: 14)),
                            Text(
                              weightData[sortedDates.last].toString() + ' kg',
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Icon(Icons.trending_down, size: 60, color: Colors.green.shade700),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  Text(
                    'Daily Deficit Log',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: sortedDates.length,
                      itemBuilder: (context, index) {

                        int reversedIndex = sortedDates.length - 1 - index;
                        String dateString = sortedDates[reversedIndex];
                        double currentWeight = weightData[dateString]!;
                        double? dailyDifference;
                        if (reversedIndex > 0) {
                          String previousDate = sortedDates[reversedIndex - 1];
                          double previousWeight = weightData[previousDate]!;

                          dailyDifference = currentWeight - previousWeight; 
                        }
                        String startDateStr = sortedDates.first;
                        double startWeight = weightData[startDateStr]!;

                        DateTime startDate = DateTime.parse(startDateStr.split('-').map((e) => e.padLeft(2, '0')).join('-') + " 00:00:00");
                        DateTime currentDate = DateTime.parse(dateString.split('-').map((e) => e.padLeft(2, '0')).join('-') + " 00:00:00");
                        
                        int daysPassed = currentDate.difference(startDate).inDays;

                        double expectedWeight = startWeight;
                        if (TempProfileData.goalType == 'Lose Weight') {
                          expectedWeight -= (daysPassed * TempProfileData.targetDailyWeightDeficit);
                        } else if (TempProfileData.goalType == 'Gain Weight') {
                          expectedWeight += (daysPassed * TempProfileData.targetDailyWeightDeficit);
                        }

                        bool onTrack = false;
                        if (TempProfileData.goalType == 'Lose Weight') {
                          onTrack = currentWeight <= expectedWeight;
                        } else {
                          onTrack = currentWeight >= expectedWeight;
                        }

                        return Card(
                          margin: EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(

                              backgroundColor: onTrack ? Colors.green.shade100 : Colors.orange.shade100,
                              child: Icon(Icons.scale, color: onTrack ? Colors.green.shade800 : Colors.orange.shade800),
                            ),
                            title: Text(
                              currentWeight.toString() + ' kg', 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dateString),

                                if (TempProfileData.targetDailyWeightDeficit > 0 && daysPassed > 0)
                                  Text(
                                    onTrack ? 'On Track! (Expected: ${expectedWeight.toStringAsFixed(1)} kg)' : 'Behind Target (Expected: ${expectedWeight.toStringAsFixed(1)} kg)',
                                    style: TextStyle(
                                      color: onTrack ? Colors.green.shade700 : Colors.orange.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ), 

                            trailing: _buildDeficitBadge(dailyDifference),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

Widget _buildDeficitBadge(double? difference) {
    if (difference == null) {
      return Text('Starting\nWeight', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12));
    }

    String diffString = difference.toStringAsFixed(1); 
    double requiredDeficit = TempProfileData.targetDailyWeightDeficit;
    bool hitGoal = difference <= -requiredDeficit;

    if (hitGoal) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          diffString + ' kg', 
          style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold)
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          (difference > 0 ? '+' : '') + diffString + ' kg', 
          style: TextStyle(color: Colors.orange.shade900, fontWeight: FontWeight.bold)
        ),
      );
    }
  }
}
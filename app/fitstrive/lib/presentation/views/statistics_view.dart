import 'package:flutter/material.dart';
import '../models/temp_profile_data.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> weightData = TempProfileData.weightLogByDate;

    List<String> sortedDates = weightData.keys.toList();
    sortedDates.sort(); 

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

                  if (TempProfileData.totalTargetAmount > 0)
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

                        return Card(
                          margin: EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: Icon(Icons.scale, color: Colors.blue.shade800),
                            ),
                            title: Text(
                              currentWeight.toString() + ' kg', 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Text(dateString), 

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Goal Reached!', style: TextStyle(color: Colors.green.shade800, fontSize: 10, fontWeight: FontWeight.bold)),
            Text(diffString + ' kg', style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    } 

    else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Missed Target', style: TextStyle(color: Colors.orange.shade900, fontSize: 10, fontWeight: FontWeight.bold)),
            Text((difference > 0 ? '+' : '') + diffString + ' kg', style: TextStyle(color: Colors.orange.shade900, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  }
}
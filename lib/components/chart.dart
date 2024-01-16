import 'package:expenses/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  // Receive a list in constructor that contains the past 7 days from now
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  // Creates a list of objects of the type Map that carries String[Week] + Double[value]
  List<Map<String, dynamic>> get groupedTransactions {
    // Return a new list of maps with a limited range of objects (7)
    return List.generate(7, (index) {
      // In generation cycles: day 30 (Datetime.now) minus 0 (index) is 30, day 30 minus 1
      // is equal 29, minus 2 is 28 and so on... From this we get the past week, the days
      // countdown from today (day 30) in the format dd/mm/yyyy, which further down will be
      // readed by DateFormat.E() and will be turned into week name than in initials.
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      // (Variable to store the sum of all the transactions on the same day)
      double totalSum = 0.0;

      // This for loop will check all the occurrences in recentTransactions equal weekDay...
      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        // ...and if the next element of the recentTransactions have the same date,
        // month and year the value of the Transaction object is added to the current
        // total sum.
        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      // Having the weekDay and the totalSum of all Transaction values of the same day,
      // which may not be found, staying with zero value, we can return the new
      // Map object to the generate() method.
      return {
        'day': DateFormat.E().format(weekDay).toString(),
        'value': totalSum,
      };
    });
  }

  double get _weekTotalvalue {
    return groupedTransactions.fold(0.0, (sumAccumulated, tr) {
      return sumAccumulated + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // groupedTransactions;
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.from(groupedTransactions.reversed).map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: _weekTotalvalue == 0
                    ? 0
                    : (tr['value'] as double) / _weekTotalvalue,
                isToday: tr['day'] ==
                        DateFormat.E().format(DateTime.now()).toString()
                    ? true
                    : false,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

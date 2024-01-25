import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
  final bool isToday;

  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 20,
          // fittedbox: makes inside element resize according to the parent's size
          // which in case is the fit, or the maximum width fittedbox can stretch...
          child: FittedBox(
            child: Text(
              '\$${value.toStringAsFixed(2)}',
              style: TextStyle(
                color: isToday
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 30,
              width: 10,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isToday == true
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.onPrimary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                // color: const Color.fromARGB(255, 232, 232, 232),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isToday == true
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            // fontStyle: FontStyle.italic,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        isToday
            ? Icon(
                Icons.arrow_drop_up,
                size: 20,
                color: Theme.of(context).colorScheme.secondary,
              )
            : const Icon(
                Icons.arrow_drop_up,
                size: 20,
                color: Colors.transparent,
              ),
      ],
    );
  }
}

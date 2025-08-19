import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_wild/main.dart';
import 'package:new_wild/ui/screens/scenario_generation/components/generate_scenario_tile.dart';

void main() {
  group(
    'GenerateScenarioTile tests',
    () {
      // testWidgets(
      //   'Counter increments smoke test',
      //   (WidgetTester tester) async {
      //     // Build our app and trigger a frame.
      //     await tester.pumpWidget(const MyApp());

      //     // Verify that our counter starts at 0.
      //     expect(find.text('0'), findsOneWidget);
      //     expect(find.text('1'), findsNothing);

      //     // Tap the '+' icon and trigger a frame.
      //     await tester.tap(find.byIcon(Icons.add));
      //     await tester.pump();

      //     // Verify that our counter has incremented.
      //     expect(find.text('0'), findsNothing);
      //     expect(find.text('1'), findsOneWidget);
      //   },
      // );

      testWidgets(
        'GenerateScenrioTile triggers onTap callback when tapped',
        (WidgetTester tester) async {
          bool isTapped = false;
          const backgroundColor = Colors.blue;
          const iconBackgroundColor = Colors.green;
          const assetPath = 'asset/icons/vk_logo.svg';
          const title = 'Test Title';
          const description = 'Test Description';

          await tester.pumpWidget(
            MaterialApp(
              home: Center(
                child: GenerateScenarioTile(
                  backgroundColor: backgroundColor,
                  iconBackgroundColor: iconBackgroundColor,
                  assetPath: assetPath,
                  title: title,
                  description: description,
                  onTap: () => isTapped = true,
                ),
              ),
            ),
          );

          await tester.tap(find.byType(GenerateScenarioTile));
          await tester.pumpAndSettle();

          expect(isTapped, isTrue);
        },
      );
    },
  );
}

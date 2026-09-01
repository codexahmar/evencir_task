import 'package:evencir_task/constants/app_images.dart';
import 'package:evencir_task/screens/homeScreen.dart';
import 'package:evencir_task/screens/planScreen.dart';
import 'package:evencir_task/widgets/workoutContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('WorkoutContainer renders with title, tag and duration without overflow', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: WorkoutContainer(
              type: 'Arm Workout',
              color: Color(0xFF20B76F),
              iconPath: AppImages.exerciseIcon,
              title: 'Arm Blaster Blitz',
              duration: '20m - 25m',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Arm Workout'), findsOneWidget);
    expect(find.text('Arm Blaster Blitz'), findsOneWidget);
    expect(find.text('20m - 25m'), findsOneWidget);
  });

  testWidgets('PlanScreen renders without layout assertion errors', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: PlanScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Training Calendar'), findsOneWidget);
    expect(find.text('Arm Blaster'), findsOneWidget);
    expect(find.text('Leg Day Blitz'), findsOneWidget);
  });

  testWidgets('HomeScreen switches between tabs without exceptions', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Tap on Plan tab (index 1)
    await tester.tap(find.text('Plan'));
    await tester.pumpAndSettle();
    expect(find.text('Training Calendar'), findsOneWidget);

    // Tap on Mood tab (index 2)
    await tester.tap(find.text('Mood'));
    await tester.pumpAndSettle();
    expect(find.text('How are you feeling at the Moment?'), findsOneWidget);

    // Tap on Profile tab (index 3)
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Active Targets'), findsOneWidget);
  });
}

import 'package:evencir_task/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App launches with SplashScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('AURAFIT'), findsOneWidget);
    expect(find.text('TRAIN • TRACK • TRANSFORM'), findsOneWidget);
  });
}

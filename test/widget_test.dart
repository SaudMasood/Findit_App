import 'package:flutter_test/flutter_test.dart';
import 'package:findit_app/main.dart';

void main() {
  testWidgets('FindIt app starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('FindIt'), findsOneWidget);
  });
}
import 'package:base_project_flutter/views/location_popup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const permissions = MethodChannel('flutter.baseflow.com/permissions/methods');
  const location = MethodChannel('flutter.baseflow.com/geolocator');
  final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(permissions, null);
    messenger.setMockMethodCallHandler(location, null);
  });

  testWidgets('granted permissions skip consent; disabled GPS shows a truthful retry', (tester) async {
    messenger.setMockMethodCallHandler(permissions, (call) async {
      if (call.method == 'checkPermissionStatus') return 1;
      fail('Already-granted permissions must not be requested: ${call.method}');
    });
    messenger.setMockMethodCallHandler(location, (call) async {
      if (call.method == 'isLocationServiceEnabled') return false;
      fail('No position acquisition is allowed while GPS is disabled: ${call.method}');
    });

    await tester.pumpWidget(const MaterialApp(home: LocationPopUpPage()));
    await tester.pumpAndSettle();
    expect(find.text('Attention!'), findsNothing);
    expect(find.text('GPS is turned off. Enable location services, then try again.'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    expect(find.text('We Got Your Location'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Try again'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}

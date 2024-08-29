// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:testproject/main.dart';

// void main() {
//   final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

//   group('end-to-end test', () {
//     testWidgets(
//       'tap on the floating action button, verify counter',
//       (tester) async {
//         // Load app widget.
//         await tester.pumpWidget(const GenerativeAISample());

//         // Verify the counter starts at 0.
//         // expect(find.text('Enter a prompt'), findsOneWidget);

//         // Finds the floating action button to tap on.
//         final fab = find.byKey(const Key('prompt-text-field'));

//         // Emulate a tap on the floating action button.
//         await tester.tap(fab);

//         // Trigger a frame.
//         await tester.enterText(fab, "Code me flutter app for booking hotel");
//         await tester.testTextInput.receiveAction(TextInputAction.done);
//         await tester.pumpAndSettle(const Duration(seconds: 20));

//         // expect(
//         //     find.textContaining("Code me flutter app for booking hotel"), fab);

//         // Verify the counter increments by 1.
//         // expect(find.text('1'), findsOneWidget);
//       },
//       skip: false,
//       timeout: const Timeout(Duration(minutes: 5)),
//     );
//   });
// }

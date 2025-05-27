//
// class MyState extends State<MyStatefulWidget> with WidgetsBindingObserver {
//   // ...
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // If the controller is not ready, do not try to start or stop it.
//     // Permission dialogs can trigger lifecycle changes before the controller is ready.
//     if (!controller.value.isInitialized) {
//       return;
//     }
//
//     switch (state) {
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.paused:
//         return;
//       case AppLifecycleState.resumed:
//       // Restart the scanner when the app is resumed.
//       // Don't forget to resume listening to the barcode events.
//         _subscription = controller.barcodes.listen(_handleBarcode);
//
//         unawaited(controller.start());
//       case AppLifecycleState.inactive:
//       // Stop the scanner when the app is paused.
//       // Also stop the barcode events subscription.
//         unawaited(_subscription?.cancel());
//         _subscription = null;
//         unawaited(controller.stop());
//     }
//   }
//
// // ...
// }
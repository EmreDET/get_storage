import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GetStorage g;

  const channel = MethodChannel('plugins.flutter.io/path_provider');
  void setUpMockChannels(MethodChannel channel) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall? methodCall) async {
        if (methodCall?.method == 'getApplicationDocumentsDirectory') {
          return '.';
        }
        return null;
      },
    );
  }

  setUpAll(() async {
    setUpMockChannels(channel);
  });

  setUp(() async {
    await GetStorage.init();
    g = GetStorage();
    await g.erase();
  });

  final counter = 'counter';
  final isDarkMode = 'isDarkMode';
  test('GetStorage read and write operation', () {
    g.write(counter, 101);
    expect(g.read(counter), 101);
  });

  test('save the state of brightness mode of app in GetStorage', () {
    g.write(isDarkMode, false);
    expect(g.read(isDarkMode), false);
  });
}

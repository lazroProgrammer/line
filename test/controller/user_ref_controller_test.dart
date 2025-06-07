import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

// Minimal AppUser class
class AppUser {
  final String id;
  AppUser({required this.id});
}

// Your controller, simplified just for this test
class UsersRefController {
  late RxList<AppUser> users;

  UsersRefController() {
    users = RxList();
  }

  // We'll expose this part for testing
  List<String> getMissingUserIds(List<String> allIDs) {
    final allIds = allIDs;
    final fetchedIds = users.map((e) => e.id).toList();
    final ids = allIds.where((id) => !fetchedIds.contains(id)).toList();
    return ids;
  }
}

void main() {
  test('getMissingUserIds returns IDs that are not in users list', () {
    final controller = UsersRefController();
    controller.users.value = [AppUser(id: '1'), AppUser(id: '2')];

    final inputIds = ['1', '2', '3', '4'];
    final missingIds = controller.getMissingUserIds(inputIds);

    expect(missingIds, ['3', '4']);
  });

  test('getMissingUserIds returns all if users list is empty', () {
    final controller = UsersRefController();
    controller.users.value = [];

    final inputIds = ['a', 'b'];
    final missingIds = controller.getMissingUserIds(inputIds);

    expect(missingIds, ['a', 'b']);
  });

  test('getMissingUserIds returns empty list if all are already fetched', () {
    final controller = UsersRefController();
    controller.users.value = [AppUser(id: 'x'), AppUser(id: 'y')];

    final inputIds = ['x', 'y'];
    final missingIds = controller.getMissingUserIds(inputIds);

    expect(missingIds, []);
  });
}

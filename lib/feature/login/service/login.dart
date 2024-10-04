import 'package:balibo_station/feature/app/service/admin.dart';
import 'package:balibo_station/feature/login/model/login.dart';
import 'package:balibo_station/feature/login/model/user.dart';
import 'package:balibo_station/feature/login/service/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginService {
  final AdminService _adminService;
  final UserService _userService;

  LoginService({
    required AdminService adminService,
    required UserService userService,
  })  : _adminService = adminService,
        _userService = userService;

  Stream<UserModel?> loginAndListenToUser(LoginModel loginModel) async* {
    loginModel.admin ??= await _adminService.admin;
    loginModel.username ??= await _userService.username;
    loginModel.password ??= await _userService.password;
    loginModel.stationId ??= await _userService.stationId;

    if (loginModel.admin != null) {
      final usersCollection = FirebaseFirestore.instance
          .collection('admins')
          .doc(loginModel.admin)
          .collection('users');

      QuerySnapshot userSnapshot = await usersCollection
          .where('username', isEqualTo: loginModel.username)
          .where('password', isEqualTo: loginModel.password)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        String userId = userSnapshot.docs.first.id;

        await _adminService.saveAdminId(loginModel.admin!);
        await _userService.save(
          username: loginModel.username,
          password: loginModel.password,
          stationId: loginModel.stationId,
        );

        yield* usersCollection.doc(userId).snapshots().map((snapshot) {
          if (snapshot.exists && loginModel.stationId != null) {
            final user = UserModel.fromMap(
              snapshot.id,
              snapshot.data() as Map<String, dynamic>,
            );
            if (user.status == 1 &&
                user.password == loginModel.password &&
                user.username == loginModel.username) {
              return user;
            }
            return null;
          } else {
            return null;
          }
        });
      } else {
        yield null;
      }
    } else {
      yield null;
    }
  }

  // Stream<UserModel?> listenToUser(String username, String password) async* {
  //   QuerySnapshot userSnapshot = await _usersCollection
  //       .where('username', isEqualTo: username)
  //       .where('password', isEqualTo: password)
  //       .limit(1)
  //       .get();

  //   if (userSnapshot.docs.isNotEmpty) {
  //     String userId = userSnapshot.docs.first.id;

  //     yield* _usersCollection.doc(userId).snapshots().map((snapshot) {
  //       if (snapshot.exists) {
  //         return UserModel.fromMap(
  //           snapshot.id,
  //           snapshot.data() as Map<String, dynamic>,
  //         );
  //       } else {
  //         return null;
  //       }
  //     });
  //   } else {
  //     yield null;
  //   }
  // }

  // Future<UserModel?> login(String username, String password) async {
  //   QuerySnapshot userSnapshot = await _usersCollection
  //       .where('username', isEqualTo: username)
  //       .where('password', isEqualTo: password)
  //       .limit(1)
  //       .get();

  //   if (userSnapshot.docs.isNotEmpty) {
  //     return UserModel.fromMap(
  //       userSnapshot.docs.first.id,
  //       userSnapshot.docs.first.data() as Map<String, dynamic>,
  //     );
  //   } else {
  //     return null;
  //   }
  // }
}

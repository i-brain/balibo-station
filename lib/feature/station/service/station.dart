import 'package:balibo_station/feature/app/service/admin.dart';
import 'package:balibo_station/feature/login/service/user.dart';
import 'package:balibo_station/feature/station/model/station.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StationService {
  final AdminService _adminService;
  final UserService _userService;

  Future<CollectionReference> get _stationsCollection async =>
      (await _adminService.adminDoc).collection('stations');

  StationService(
      {required AdminService adminService, required UserService userService})
      : _adminService = adminService,
        _userService = userService;

  Future<void> addStation(Station station) async {
    final stationsCollection = await _stationsCollection;

    await stationsCollection.add(station.toMap());
  }

  Future<void> updateStation(Station station) async {
    final stationsCollection = await _stationsCollection;

    await stationsCollection.doc(station.id).update(station.toMap());
  }

  Future<void> deleteStation(String id) async {
    final stationsCollection = await _stationsCollection;

    await stationsCollection.doc(id).delete();
  }

  Stream<List<Station>> getStations(String adminId) async* {
    final stationsCollection = FirebaseFirestore.instance
        .collection('admins')
        .doc(adminId)
        .collection('stations');

    yield* stationsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Station.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  Stream<Station> getCurrentStation() async* {
    final stationsCollection = await _stationsCollection;
    final stationId = await _userService.stationId;

    yield* stationsCollection.doc(stationId).snapshots().map((doc) {
      return Station.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    });
  }
}

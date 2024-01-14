// import 'package:get/get.dart';

// import './vote.dart';
// import '/models/committee.dart';
// import '/services/local_storage.dart';

// class ModeController extends GetxController {
//   late final RxInt _mode;

//   CommitteeController({required List<Mode> mode}) {
//     _tab = tab.obs;
//     _committee = committee.obs;
//   }

//   Committee get committee => _committee.value;

//   void setAgenda(String agenda) {
//     _committee.update((committee) {
//       if (committee != null) committee.agenda = agenda;
//     });

//     LocalStorage.updateCommittee("committee", committee.toJson());
//   }

//   void _saveRollCall() {
//     LocalStorage.updateCommittee("rollCall", committee.rollCall);

//     if (Get.isRegistered<VoteController>(tag: "vote")) {
//       Get.find<VoteController>(tag: "vote").voters =
//           _committee.value.presentAndVotingDelegates;
//     }

//     if (Get.isRegistered<VoteController>(tag: "motions")) {
//       Get.find<VoteController>(tag: "motions").voters =
//           _committee.value.presentAndVotingDelegates;
//     }
//   }

//   void setAllPresentAndVoting() {
//     _committee.update((committee) {
//       if (committee != null) {
//         committee.rollCall.updateAll((_, __) => RollCall.presentAndVoting);
//       }
//     });

//     _saveRollCall();
//   }

//   void setAllPresent() {
//     _committee.update((committee) {
//       if (committee != null) {
//         committee.rollCall.updateAll((_, __) => RollCall.present);
//       }
//     });

//     _saveRollCall();
//   }

//   void setAllAbsent() {
//     _committee.update((committee) {
//       if (committee != null) {
//         committee.rollCall.updateAll((_, __) => RollCall.absent);
//       }
//     });

//     _saveRollCall();
//   }

//   void setRollCall(String delegate, int attendance) {
//     _committee.update((committee) {
//       if (committee != null) committee.rollCall[delegate] = attendance;
//     });

//     _saveRollCall();
//   }

//   int get tab => _tab.value;
//   set tab(int newTab) => _tab.value = newTab;

//   Map<String, dynamic> toJson() => _committee.value.toJson();
// }

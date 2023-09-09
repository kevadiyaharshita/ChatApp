import 'package:flutter/cupertino.dart';
import 'package:platform_convertor_application_project/modals/ProfileModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  bool _updateProfile = false;
  SharedPreferences preferences;
  List<String> sp_profileData = [];
  String sp_key = 'profileData';
  String imagePath = "";

  ProfileController({required this.preferences});

  clearLocalData() {
    imagePath = "";
  }

  setimagePath({required String imagePath}) {
    this.imagePath = imagePath;
    notifyListeners();
  }

  get getUpdateProfile {
    return _updateProfile;
  }

  get getProfileData {
    sp_profileData = preferences.getStringList(sp_key) ?? [];
    if (sp_profileData.isNotEmpty) {
      ProfileModal profile = ProfileModal(
          profileName: sp_profileData[0],
          profileImage: sp_profileData[2],
          profileBio: sp_profileData[1]);

      return profile;
    } else {
      ProfileModal profile =
          ProfileModal(profileName: "", profileImage: "", profileBio: "");
      return profile;
    }
  }

  setUpdateProfile() {
    _updateProfile = !_updateProfile;
    notifyListeners();
  }

  List<String> setSp_Profile({required ProfileModal pm}) {
    sp_profileData.clear();
    sp_profileData.add(pm.profileName);
    sp_profileData.add(pm.profileBio);
    sp_profileData.add(pm.profileImage);
    return sp_profileData;
  }

  void setProfile({required ProfileModal pm}) {
    sp_profileData = setSp_Profile(pm: pm);
    preferences.setStringList(sp_key, sp_profileData);
    print("data : ${preferences.getStringList(sp_key)}");
    notifyListeners();
  }

  void editProfileData({required ProfileModal pm}) {
    sp_profileData = setSp_Profile(pm: pm);
    preferences.setStringList(sp_key, sp_profileData);
    notifyListeners();
  }
}

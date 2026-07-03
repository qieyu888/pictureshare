import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _likedPostsKey = 'liked_posts';
  static const String _inspiredPostsKey = 'inspired_posts';
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _agreedToTermsKey = 'agreed_to_terms';
  static const String _privacyProfileVisibleKey = 'privacy_profile_visible';
  static const String _privacyAllowMessagesKey = 'privacy_allow_messages';
  static const String _privacyShowActivityKey = 'privacy_show_activity';
  static const String _notifyLikesKey = 'notify_likes';
  static const String _notifyCommentsKey = 'notify_comments';
  static const String _notifyFollowsKey = 'notify_follows';
  static const String _notifyExhibitionsKey = 'notify_exhibitions';
  static const String _notifySystemKey = 'notify_system';
  static const String _blockedUsersKey = 'blocked_users';
  static const String _shieldedPostsKey = 'shielded_posts';
  static const String _reportedPostsKey = 'reported_posts';
  static const String _savedPostsKey = 'saved_posts';

  Future<bool> hasCompletedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  Future<void> setOnboardingCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, value);
  }

  Future<bool> hasAgreedToTerms() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_agreedToTermsKey) ?? false;
  }

  Future<void> setAgreedToTerms(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_agreedToTermsKey, value);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_agreedToTermsKey, false);
  }

  Future<bool> getPrivacyProfileVisible() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_privacyProfileVisibleKey) ?? true;
  }

  Future<void> setPrivacyProfileVisible(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_privacyProfileVisibleKey, value);
  }

  Future<bool> getPrivacyAllowMessages() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_privacyAllowMessagesKey) ?? true;
  }

  Future<void> setPrivacyAllowMessages(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_privacyAllowMessagesKey, value);
  }

  Future<bool> getPrivacyShowActivity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_privacyShowActivityKey) ?? true;
  }

  Future<void> setPrivacyShowActivity(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_privacyShowActivityKey, value);
  }

  Future<bool> getNotifyLikes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notifyLikesKey) ?? true;
  }

  Future<void> setNotifyLikes(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notifyLikesKey, value);
  }

  Future<bool> getNotifyComments() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notifyCommentsKey) ?? true;
  }

  Future<void> setNotifyComments(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notifyCommentsKey, value);
  }

  Future<bool> getNotifyFollows() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notifyFollowsKey) ?? true;
  }

  Future<void> setNotifyFollows(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notifyFollowsKey, value);
  }

  Future<bool> getNotifyExhibitions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notifyExhibitionsKey) ?? true;
  }

  Future<void> setNotifyExhibitions(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notifyExhibitionsKey, value);
  }

  Future<bool> getNotifySystem() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notifySystemKey) ?? true;
  }

  Future<void> setNotifySystem(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notifySystemKey, value);
  }

  Future<Set<String>> getLikedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> likedPosts = prefs.getStringList(_likedPostsKey) ?? [];
    return likedPosts.toSet();
  }

  Future<void> toggleLikedPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final likedPosts = await getLikedPosts();
    
    if (likedPosts.contains(postId)) {
      likedPosts.remove(postId);
    } else {
      likedPosts.add(postId);
    }
    
    await prefs.setStringList(_likedPostsKey, likedPosts.toList());
  }

  Future<Set<String>> getInspiredPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> inspiredPosts = prefs.getStringList(_inspiredPostsKey) ?? [];
    return inspiredPosts.toSet();
  }

  Future<void> toggleInspiredPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final inspiredPosts = await getInspiredPosts();
    
    if (inspiredPosts.contains(postId)) {
      inspiredPosts.remove(postId);
    } else {
      inspiredPosts.add(postId);
    }
    
    await prefs.setStringList(_inspiredPostsKey, inspiredPosts.toList());
  }

  Future<Set<String>> getBlockedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_blockedUsersKey) ?? []).toSet();
  }

  Future<void> blockUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final blocked = await getBlockedUsers()..add(userId);
    await prefs.setStringList(_blockedUsersKey, blocked.toList());
  }

  Future<void> unblockUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final blocked = await getBlockedUsers()..remove(userId);
    await prefs.setStringList(_blockedUsersKey, blocked.toList());
  }

  Future<Set<String>> getShieldedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_shieldedPostsKey) ?? []).toSet();
  }

  Future<void> shieldPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final shielded = await getShieldedPosts()..add(postId);
    await prefs.setStringList(_shieldedPostsKey, shielded.toList());
  }

  Future<Set<String>> getReportedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_reportedPostsKey) ?? []).toSet();
  }

  Future<void> reportPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final reported = await getReportedPosts()..add(postId);
    await prefs.setStringList(_reportedPostsKey, reported.toList());
  }

  Future<bool> isUserBlocked(String userId) async {
    final blocked = await getBlockedUsers();
    return blocked.contains(userId);
  }

  Future<bool> isPostShielded(String postId) async {
    final shielded = await getShieldedPosts();
    return shielded.contains(postId);
  }

  Future<Set<String>> getSavedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_savedPostsKey) ?? []).toSet();
  }

  Future<bool> isPostSaved(String postId) async {
    final saved = await getSavedPosts();
    return saved.contains(postId);
  }

  Future<bool> toggleSavedPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = await getSavedPosts();
    final wasSaved = saved.contains(postId);
    if (wasSaved) {
      saved.remove(postId);
    } else {
      saved.add(postId);
    }
    await prefs.setStringList(_savedPostsKey, saved.toList());
    return !wasSaved;
  }
}

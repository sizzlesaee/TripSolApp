// lib/auth_service.dart

class AuthService {
  // ✅ Dummy Google Sign-In for now
  Future<void> signInWithGoogle() async {
    print("Mock sign-in: Google user signed in");
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> signOut() async {
    print("Mock sign-out: User signed out");
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // ✅ You can return a dummy email if needed
  String? get currentUserEmail => "mockuser@example.com";
}

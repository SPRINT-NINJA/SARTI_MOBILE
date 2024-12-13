import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sarti_mobile/services/auth_service.dart';
import 'package:sarti_mobile/models/sellers/profile_seller.dart';

// Define el provider para el servicio de autenticación
final profileSellerProvider =
    StateNotifierProvider<ProfileSellerViewModel, ProfileSellerState>(
  (ref) => ProfileSellerViewModel(AuthService()),
);

class ProfileSellerState {
  final ProfileSeller? profile;
  final bool isLoading;
  final String? error;

  ProfileSellerState({this.profile, this.isLoading = false, this.error});

  ProfileSellerState copyWith({
    ProfileSeller? profile,
    bool? isLoading,
    String? error,
  }) {
    return ProfileSellerState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ProfileSellerViewModel extends StateNotifier<ProfileSellerState> {
  final AuthService _authService;

  ProfileSellerViewModel(this._authService)
      : super(ProfileSellerState(isLoading: true)) {
    fetchProfileSeller();
  }

  Future<void> fetchProfileSeller() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final profile = await _authService.getProfileSeller();
      if (profile != null) {
        state = state.copyWith(profile: profile, isLoading: false);
      } else {
        state = state.copyWith(
            error: 'No se pudo cargar el perfil', isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
          error: 'Error al cargar el perfil: \$e', isLoading: false);
    }
  }
}

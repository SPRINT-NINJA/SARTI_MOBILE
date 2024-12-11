// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_seller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getUserByEmailHash() => r'92b4bdbad438bba53c06bbde5325bfa72182ecd4';

/// See also [getUserByEmail].
@ProviderFor(getUserByEmail)
final getUserByEmailProvider = AutoDisposeFutureProvider<bool>.internal(
  getUserByEmail,
  name: r'getUserByEmailProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUserByEmailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetUserByEmailRef = AutoDisposeFutureProviderRef<bool>;
String _$createUserSellerHash() => r'0c645359361313ec4fd4381d7a66934c46d2b9b7';

/// See also [createUserSeller].
@ProviderFor(createUserSeller)
final createUserSellerProvider = AutoDisposeFutureProvider<bool>.internal(
  createUserSeller,
  name: r'createUserSellerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createUserSellerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreateUserSellerRef = AutoDisposeFutureProviderRef<bool>;
String _$stepsFormSellerHash() => r'bda52d85434c91de65c98882bf95850b1551f5bc';

/// See also [StepsFormSeller].
@ProviderFor(StepsFormSeller)
final stepsFormSellerProvider =
    AutoDisposeNotifierProvider<StepsFormSeller, StepsForm>.internal(
  StepsFormSeller.new,
  name: r'stepsFormSellerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stepsFormSellerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StepsFormSeller = AutoDisposeNotifier<StepsForm>;
String _$userSellerStateHash() => r'f0b0309718b4e6c55b8528db66e7abe208d3922e';

/// See also [UserSellerState].
@ProviderFor(UserSellerState)
final userSellerStateProvider = AutoDisposeNotifierProvider<UserSellerState,
    CreateAccountUserSellerState>.internal(
  UserSellerState.new,
  name: r'userSellerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userSellerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserSellerState = AutoDisposeNotifier<CreateAccountUserSellerState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

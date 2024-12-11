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
String _$createUserSellerHash() => r'51bd01c3d5003870bc115e8f957f43c5af44a818';

/// See also [createUserSeller].
@ProviderFor(createUserSeller)
final createUserSellerProvider = AutoDisposeFutureProvider<String>.internal(
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
typedef CreateUserSellerRef = AutoDisposeFutureProviderRef<String>;
String _$stepsFormSellerHash() => r'77fe34af1129c856d58d959056e6ffca30d467e2';

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
String _$userSellerStateHash() => r'8b4674d523ce53d87169044cb91f47f727c40bfc';

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

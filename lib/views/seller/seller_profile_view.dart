import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sarti_mobile/viewmodels/sellers/profile_seller_viewmodel.dart';

class ProfileSellerView extends ConsumerWidget {
  static const name = 'profile-seller';
  const ProfileSellerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileSellerProvider);

    if (state.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            state.error!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    final profile = state.profile;
    if (profile == null) {
      return const Scaffold(
        body: Center(child: Text('Perfil no disponible.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Vendedor'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      profile.name[0],
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${profile.name} ${profile.fistLastName} ${profile.secondLastName ?? ''}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(profile.user.email),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Información de la Tienda',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nombre de la tienda: ${profile.bussinessName}'),
                    Text('Descripción: ${profile.description}'),
                    Text('Wallet: ${profile.wallet}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Dirección',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('País: ${profile.address.country}'),
                    Text('Estado: ${profile.address.state}'),
                    Text('Ciudad: ${profile.address.city}'),
                    Text('Colonia: ${profile.address.colony}'),
                    Text('Calle: ${profile.address.street}'),
                    Text('Código Postal: ${profile.address.zipCode}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

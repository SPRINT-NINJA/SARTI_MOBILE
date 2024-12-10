import 'package:flutter/material.dart';
import 'package:sarti_mobile/config/constant/enums.dart';
import 'package:sarti_mobile/views/auth/widgets/create_account_business_form_widget.dart';
import 'package:sarti_mobile/views/auth/widgets/create_account_costumer_form_widget.dart';

class CreateAccountView extends StatelessWidget {
  static const name = 'create_account';

  final String? role;

  const CreateAccountView({super.key, this.role});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: theme.appBarTheme.iconTheme,
          title: const Text('Crea tu cuenta'),
        ),
        body: _CreateAccountView(
            theme: theme, role: role ?? ERoles.costumer.toString()));
  }
}

class _CreateAccountView extends StatefulWidget {
  final String role;
  final ThemeData theme;

  const _CreateAccountView({required this.theme, required this.role});

  @override
  State<_CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<_CreateAccountView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
        builder: (BuildContext context) {
          if (widget.role == ERoles.business.toString()) {
            return CreateAccountBusinessFormWidget(theme: widget.theme);
          } else {
            return CreateAccountCostumerFormWidget(theme: widget.theme);
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sarti_mobile/utils/enums.dart';
import 'package:sarti_mobile/views/auth/widgets/create_account_business_form_widget.dart';
import 'package:sarti_mobile/views/auth/widgets/create_account_costumer_form_widget.dart';
import 'package:sarti_mobile/views/auth/widgets/create_account_delivery_form_widget.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';

class CreateAccountView extends StatefulWidget {
  final String? role;
  const CreateAccountView({super.key,
    this.role
  });

  @override
  State<CreateAccountView> createState() =>
      _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: theme.appBarTheme.iconTheme,
        title: const Text('Crea tu cuenta'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
           if (widget.role == ERoles.delivery.toString()) {
              return CreateAccountDeliveryFormWidget(theme: theme);
            } else if (widget.role == ERoles.business.toString()) {
              return CreateAccountBusinessFormWidget(theme: theme);
            } else {
              return CreateAccountCostumerFormWidget(theme: theme);
           }
          },
        ),
      ),
    );
  }
}








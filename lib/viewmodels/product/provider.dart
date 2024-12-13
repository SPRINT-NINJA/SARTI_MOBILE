import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarti_mobile/viewmodels/product/product_viewmodel.dart';

// Define un provider para el ProductViewModel
final productViewModelProvider = ChangeNotifierProvider((ref) => ProductViewModel());

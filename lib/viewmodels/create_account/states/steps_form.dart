import 'package:flutter/material.dart';
import 'package:sarti_mobile/config/config.dart';

class StepsForm {
  final int currentStep;
  final int totalSteps;
  final PageController controller;

  final List<bool> isStepPosted;
  final List<bool> isStepValid;
  final bool isLoading;
  final bool isSaved;


  StepsForm({
    required this.currentStep,
    required this.totalSteps,
    required this.controller,
    required this.isStepPosted,
    required this.isStepValid,
    required this.isLoading,
    required this.isSaved,
  });

  StepsForm copyWith({
    int? currentStep,
    int? totalSteps,
    PageController? controller,
    List<bool>? isStepPosted,
    List<bool>? isStepValid,
    bool? isLoading,
    bool? isSaved,


  }) {
    return StepsForm(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      controller: controller ?? this.controller,
      isStepPosted: isStepPosted ?? this.isStepPosted,
      isStepValid: isStepValid ?? this.isStepValid,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  String toString() {
    return 'StepsForm{currentStep: $currentStep, totalSteps: $totalSteps, controller: $controller, isStepPosted: $isStepPosted, isStepValid: $isStepValid, isLoading: $isLoading, isSaved: $isSaved}';
  }
}

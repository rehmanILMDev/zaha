import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:zaha/features/on_broad_feat/data/models/onboarding_model.dart';

abstract class OnboardingLocalDataSource {
  Future<List<OnboardingModel>> getOnboardingData();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  @override
  Future<List<OnboardingModel>> getOnboardingData() async {
    final jsonString = await rootBundle.loadString('lib/core/assets/data/onboarding.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => OnboardingModel.fromJson(data)).toList();
  }
}

import 'package:tractian_challenge/core/domain/entities/companie.dart';

class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  HomeLoadedState({required this.companies});
  final List<Companie> companies;
}

class HomeErrorState extends HomeState {}

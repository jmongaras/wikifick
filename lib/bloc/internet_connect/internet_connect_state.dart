part of 'internet_connect_bloc.dart';

@immutable
sealed class InternetConnectState {}

final class InternetConnectInitial extends InternetConnectState {}

class InternetConnectedSucess extends InternetConnectState {}

class InternetConnectedFailure extends InternetConnectState {}

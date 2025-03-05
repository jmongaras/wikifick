part of 'internet_connect_bloc.dart';

@immutable
sealed class InternetConnectEvent {}

class ConnectedInternetEvent extends InternetConnectEvent {}

class NotConnectedInternetEvent extends InternetConnectEvent {}

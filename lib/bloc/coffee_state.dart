part of 'coffee_bloc.dart';

abstract class CoffeeState extends Equatable {
  const CoffeeState();
}

class CoffeeInitial extends CoffeeState {
  const CoffeeInitial();
  @override
  List<Object> get props => [];
}

class CoffeeLoading extends CoffeeState {
  const CoffeeLoading();
  @override
  List<Object> get props => [];
}

class CoffeeCheck extends CoffeeState {
  final bool isCoffee;
  final String name;
  const CoffeeCheck(this.isCoffee, this.name);
  @override
  List<Object> get props => [isCoffee,name];
}

class CoffeeDetails extends CoffeeState {
  final Coffee coffee;
  const CoffeeDetails(this.coffee);
  @override
  List<Object> get props => [coffee];
}

class CoffeeError extends CoffeeState {
  final String message;
  const CoffeeError(this.message);
  @override
  List<Object> get props => [message];
}
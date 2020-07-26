part of 'coffee_bloc.dart';

abstract class CoffeeEvent extends Equatable {
  const CoffeeEvent();
}

class GetIsCoffee extends CoffeeEvent {
  final String coffeeName;

  const GetIsCoffee(this.coffeeName); // hvis arg er brugt, brug gammel instans
  
  @override
  List<Object> get props => [coffeeName];
}

class GetCoffeeDetails extends CoffeeEvent {
  final String coffeeName;

  const GetCoffeeDetails(this.coffeeName); // hvis arg er brugt, brug gammel instans
  
  @override
  List<Object> get props => [coffeeName];
}
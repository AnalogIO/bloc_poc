import 'package:bloc_poc_lib/bloc/coffee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_poc_lib/data/model/coffee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'details_page.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coffee Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocListener<CoffeeBloc, CoffeeState>(
          listener: (context, state) {
            // snackbar skal kun vises en gang og skal derfor v;re i listener ikke builder
            if (state is CoffeeError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } 
          },
        child: BlocBuilder<CoffeeBloc, CoffeeState>(
            builder: (context, state) {
              if (state is CoffeeInitial)
                return buildInitialInput();
              else if (state is CoffeeLoading)
                return buildLoading();
              else if (state is CoffeeCheck)
                return buildColumnWithData(context, state.isCoffee, state.name);
              else
                return buildInitialInput(); //Container(width: 0.0, height: 0.0);
              // Alternativt bør man sætte initial som default
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CoffeeInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, bool isCoffee, String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          '$name is ${isCoffee ? "" : "not "}coffee',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        RaisedButton(
          child: Text('See Details'),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<CoffeeBloc>(context),
                child: DetailsPage(
                  coffeeName: name,
                ),
              ),
            ));
          },
        ),
        CoffeeInputField(),
      ],
    );
  }

}

class CoffeeInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCoffeeName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a type of coffee",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCoffeeName(BuildContext context, String name) {
    final coffeeBloc = BlocProvider.of<CoffeeBloc>(context);
    coffeeBloc.add(GetIsCoffee(name));
  }
}

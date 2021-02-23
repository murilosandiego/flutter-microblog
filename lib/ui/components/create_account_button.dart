import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final bool backgroundWhite;
  final Function onPressed;
  final String nameButton;

  const CreateAccountButton({
    Key key,
    this.backgroundWhite = true,
    @required this.onPressed,
    this.nameButton = 'Não tem conta? Cadastrar',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            nameButton,
            style: TextStyle(
                color: backgroundWhite
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).backgroundColor,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.41),
          ),
        ],
      ),
    );
  }
}

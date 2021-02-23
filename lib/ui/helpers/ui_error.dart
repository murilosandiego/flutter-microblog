enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse,
  invalidEmail,
  invalidMessageNewPost
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return 'Campo obrigatório';
      case UIError.invalidField:
        return 'Campo inválido';
      case UIError.invalidCredentials:
        return 'Credenciais inválidas.';
      case UIError.emailInUse:
        return 'O email já está em uso.';
      case UIError.invalidEmail:
        return 'E-mail inválido';
      case UIError.invalidMessageNewPost:
        return 'Mensagem maior que o permitido';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}

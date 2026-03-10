import '../model/configuracaomodel.dart';

class ConfiguracaoViewModel {
  ConfiguracaoPartida criarConfiguracao({
    required String nomeJogador1,
    required String nomeJogador2,
    required String simboloJogador1,
    required String avatarJogador1,
    required String avatarJogador2,
  }) {
    final simboloJogador2 = simboloJogador1 == 'X' ? 'O' : 'X';

    return ConfiguracaoPartida(
      nomeJogador1: nomeJogador1,
      nomeJogador2: nomeJogador2,
      simboloJogador1: simboloJogador1,
      simboloJogador2: simboloJogador2,
      avatarJogador1: avatarJogador1,
      avatarJogador2: avatarJogador2,
    );
  }

  bool validar({
    required String nomeJogador1,
    required String nomeJogador2,
    required String avatarJogador1,
    required String avatarJogador2,
  }) {
    return nomeJogador1.trim().isNotEmpty &&
        nomeJogador2.trim().isNotEmpty &&
        avatarJogador1.trim().isNotEmpty &&
        avatarJogador2.trim().isNotEmpty;
  }
}
class Tabuleiro {
  final List<String> posicoes;

  Tabuleiro({List<String>? posicoes})
      : posicoes = posicoes ?? List.filled(9, '');

  bool posicaoVazia(int index) {
    return posicoes[index].isEmpty;
  }

  void marcarPosicao(int index, String simbolo) {
    if (posicaoVazia(index)) {
      posicoes[index] = simbolo;
    }
  }

  void resetar() {
    for (int i = 0; i < posicoes.length; i++) {
      posicoes[i] = '';
    }
  }
}
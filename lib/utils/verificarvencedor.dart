class VerificarVencedor {
  String? verificarVencedor(List<String> posicoes) {
    final combinacoesVitoriosas = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final combinacao in combinacoesVitoriosas) {
      final a = combinacao[0];
      final b = combinacao[1];
      final c = combinacao[2];

      if (posicoes[a].isNotEmpty &&
          posicoes[a] == posicoes[b] &&
          posicoes[a] == posicoes[c]) {
        return posicoes[a];
      }
    }

    if (!posicoes.contains('')) {
      return 'Empate';
    }

    return null;
  }
}
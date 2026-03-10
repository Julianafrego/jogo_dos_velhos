import '../model/jogadormodel.dart';
import '../model/partidamodel.dart';
import '../model/tabuleiromodel.dart';
import '../data/repositories/partidarepository.dart';
import '../utils/verificarvencedor.dart';

class JogoViewModel {
  final PartidaRepository partidaRepository;
  final VerificarVencedor verificarVencedor;

  late Partida partidaAtual;
  late Jogador jogadorAtual;

  JogoViewModel({
    required this.partidaRepository,
    required this.verificarVencedor,
  });

  void iniciarPartida(Jogador jogador1, Jogador jogador2) {
    partidaAtual = Partida(
      jogador1: jogador1,
      jogador2: jogador2,
      tabuleiro: Tabuleiro(),
      data: DateTime.now(),
    );

    jogadorAtual = jogador1;
  }

  String get simboloJogadorAtual => jogadorAtual.simbolo;

  String get nomeJogadorAtual => jogadorAtual.nome;

  String get avatarJogadorAtual => jogadorAtual.avatar;

  List<String> get posicoesTabuleiro => partidaAtual.tabuleiro.posicoes;

  String? realizarJogada(int index) {
    if (!partidaAtual.tabuleiro.posicaoVazia(index) || partidaAtual.finalizada) {
      return null;
    }

    partidaAtual.tabuleiro.marcarPosicao(index, jogadorAtual.simbolo);

    final vencedor = verificarVencedor.verificarVencedor(
      partidaAtual.tabuleiro.posicoes,
    );

    if (vencedor != null) {
      partidaAtual.vencedor = vencedor;
      partidaAtual.finalizada = true;
      return vencedor;
    }

    alternarJogador();
    return null;
  }

  void alternarJogador() {
    if (jogadorAtual.simbolo == partidaAtual.jogador1.simbolo) {
      jogadorAtual = partidaAtual.jogador2;
    } else {
      jogadorAtual = partidaAtual.jogador1;
    }
  }

  Future<void> salvarPartidaFinalizada() async {
    if (partidaAtual.finalizada) {
      await partidaRepository.salvarPartida(partidaAtual);
    }
  }

  void reiniciarComMesmosJogadores() {
    final jogador1 = partidaAtual.jogador1;
    final jogador2 = partidaAtual.jogador2;

    partidaAtual = Partida(
      jogador1: jogador1,
      jogador2: jogador2,
      tabuleiro: Tabuleiro(),
      data: DateTime.now(),
    );

    jogadorAtual = jogador1;
  }
}
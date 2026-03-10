import 'jogadormodel.dart';
import 'tabuleiromodel.dart';

class Partida {
    final int? id;
    final Jogador jogador1;
    final Jogador jogador2;
    final Tabuleiro tabuleiro;
    final DateTime data;
    String? vencedor;
    bool finalizada;

    Partida({
        this.id,
        required this.jogador1,
        required this.jogador2,
        required this.tabuleiro,
        required this.data,
        this.vencedor,
        this.finalizada = false,
    });
}
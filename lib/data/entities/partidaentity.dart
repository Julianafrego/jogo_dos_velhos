import '../../model/jogadormodel.dart';
import '../../model/partidamodel.dart';
import '../../model/tabuleiromodel.dart';

class PartidaEntity {
  final int? id;
  final String nomeJogador1;
  final String simboloJogador1;
  final String avatarJogador1;
  final String nomeJogador2;
  final String simboloJogador2;
  final String avatarJogador2;
  final String posicao0;
  final String posicao1;
  final String posicao2;
  final String posicao3;
  final String posicao4;
  final String posicao5;
  final String posicao6;
  final String posicao7;
  final String posicao8;
  final String vencedor;
  final String dataPartida;

  PartidaEntity({
    this.id,
    required this.nomeJogador1,
    required this.simboloJogador1,
    required this.avatarJogador1,
    required this.nomeJogador2,
    required this.simboloJogador2,
    required this.avatarJogador2,
    required this.posicao0,
    required this.posicao1,
    required this.posicao2,
    required this.posicao3,
    required this.posicao4,
    required this.posicao5,
    required this.posicao6,
    required this.posicao7,
    required this.posicao8,
    required this.vencedor,
    required this.dataPartida,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome_jogador1': nomeJogador1,
      'simbolo_jogador1': simboloJogador1,
      'avatar_jogador1': avatarJogador1,
      'nome_jogador2': nomeJogador2,
      'simbolo_jogador2': simboloJogador2,
      'avatar_jogador2': avatarJogador2,
      'posicao_0': posicao0,
      'posicao_1': posicao1,
      'posicao_2': posicao2,
      'posicao_3': posicao3,
      'posicao_4': posicao4,
      'posicao_5': posicao5,
      'posicao_6': posicao6,
      'posicao_7': posicao7,
      'posicao_8': posicao8,
      'vencedor': vencedor,
      'data_partida': dataPartida,
    };
  }

  factory PartidaEntity.fromMap(Map<String, dynamic> map) {
    return PartidaEntity(
      id: map['id'],
      nomeJogador1: map['nome_jogador1'],
      simboloJogador1: map['simbolo_jogador1'],
      avatarJogador1: map['avatar_jogador1'],
      nomeJogador2: map['nome_jogador2'],
      simboloJogador2: map['simbolo_jogador2'],
      avatarJogador2: map['avatar_jogador2'],
      posicao0: map['posicao_0'] ?? '',
      posicao1: map['posicao_1'] ?? '',
      posicao2: map['posicao_2'] ?? '',
      posicao3: map['posicao_3'] ?? '',
      posicao4: map['posicao_4'] ?? '',
      posicao5: map['posicao_5'] ?? '',
      posicao6: map['posicao_6'] ?? '',
      posicao7: map['posicao_7'] ?? '',
      posicao8: map['posicao_8'] ?? '',
      vencedor: map['vencedor'] ?? '',
      dataPartida: map['data_partida'],
    );
  }

  factory PartidaEntity.fromPartida(Partida partida) {
    return PartidaEntity(
      id: partida.id,
      nomeJogador1: partida.jogador1.nome,
      simboloJogador1: partida.jogador1.simbolo,
      avatarJogador1: partida.jogador1.avatar,
      nomeJogador2: partida.jogador2.nome,
      simboloJogador2: partida.jogador2.simbolo,
      avatarJogador2: partida.jogador2.avatar,
      posicao0: partida.tabuleiro.posicoes[0],
      posicao1: partida.tabuleiro.posicoes[1],
      posicao2: partida.tabuleiro.posicoes[2],
      posicao3: partida.tabuleiro.posicoes[3],
      posicao4: partida.tabuleiro.posicoes[4],
      posicao5: partida.tabuleiro.posicoes[5],
      posicao6: partida.tabuleiro.posicoes[6],
      posicao7: partida.tabuleiro.posicoes[7],
      posicao8: partida.tabuleiro.posicoes[8],
      vencedor: partida.vencedor ?? '',
      dataPartida: partida.data.toIso8601String(),
    );
  }

  Partida toPartida() {
    final jogador1 = Jogador(
      nome: nomeJogador1,
      simbolo: simboloJogador1,
      avatar: avatarJogador1,
    );

    final jogador2 = Jogador(
      nome: nomeJogador2,
      simbolo: simboloJogador2,
      avatar: avatarJogador2,
    );

    final resultado = vencedor.isNotEmpty ? vencedor : null;

    return Partida(
      id: id,
      jogador1: jogador1,
      jogador2: jogador2,
      tabuleiro: Tabuleiro(
        posicoes: [
          posicao0,
          posicao1,
          posicao2,
          posicao3,
          posicao4,
          posicao5,
          posicao6,
          posicao7,
          posicao8,
        ],
      ),
      data: DateTime.parse(dataPartida),
      vencedor: resultado,
      finalizada: resultado != null,
    );
  }
}
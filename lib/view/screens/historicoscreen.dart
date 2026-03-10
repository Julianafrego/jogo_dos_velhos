import 'package:flutter/material.dart';
import '../../data/database/localdatabase.dart';
import '../../data/repositories/partidarepository.dart';
import '../../model/partidamodel.dart';
import '../../viewmodel/historicoviewmodel.dart';
import '../widgets/quadradotabuleirowidget.dart';

class HistoricoScreen extends StatelessWidget {
  HistoricoScreen({super.key});

  final HistoricoViewModel viewModel = HistoricoViewModel(
    partidaRepository: PartidaRepository(
      database: LocalDatabase.instance,
    ),
  );

  String formatarData(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  final ano = data.year.toString();
  final hora = data.hour.toString().padLeft(2, '0');
  final minuto = data.minute.toString().padLeft(2, '0');

  return '$dia/$mes/$ano $hora:$minuto';
}

  Color _corResultado(BuildContext context, Partida partida) {
    if (partida.vencedor == 'Empate') {
      return const Color.fromARGB(255, 210, 148, 5);
    }

    return Theme.of(context).colorScheme.primary;
  }


  Widget _buildInfoJogadorHistorico({
    required String avatar,
    required String nome,
    required String simbolo,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(avatar),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text('Símbolo: $simbolo'),
            ],
          ),
        ),
      ],
    );
  }

  void _mostrarZoom(BuildContext context, Partida partida) {
    final posicoes = partida.tabuleiro.posicoes;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tabuleiro final'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QuadradoTabuleiroWidget(filling: posicoes[0]),
                    QuadradoTabuleiroWidget(filling: posicoes[1]),
                    QuadradoTabuleiroWidget(filling: posicoes[2]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QuadradoTabuleiroWidget(filling: posicoes[3]),
                    QuadradoTabuleiroWidget(filling: posicoes[4]),
                    QuadradoTabuleiroWidget(filling: posicoes[5]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QuadradoTabuleiroWidget(filling: posicoes[6]),
                    QuadradoTabuleiroWidget(filling: posicoes[7]),
                    QuadradoTabuleiroWidget(filling: posicoes[8]),
                  ],
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Jogador 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoJogadorHistorico(
                  avatar: partida.jogador1.avatar,
                  nome: partida.jogador1.nome,
                  simbolo: partida.jogador1.simbolo,
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Jogador 2',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoJogadorHistorico(
                  avatar: partida.jogador2.avatar,
                  nome: partida.jogador2.nome,
                  simbolo: partida.jogador2.simbolo,
                ),
                const SizedBox(height: 16),
                Text(
                  partida.vencedor == 'Empate'
                      ? 'Deu veeeelha!!!'
                      : 'Vencedor: ${partida.vencedor == partida.jogador1.simbolo ? partida.jogador1.nome : partida.jogador2.nome} (${partida.vencedor})',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _corResultado(context, partida),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResumoPartida(BuildContext context, Partida partida) {
    final resultado = partida.vencedor == 'Empate'
        ? 'Deu veeeelha!!!'
        : 'Vencedor: ${partida.vencedor == partida.jogador1.simbolo ? partida.jogador1.nome : partida.jogador2.nome} (${partida.vencedor})';

    final corResultado = _corResultado(context, partida);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(partida.jogador1.avatar),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(partida.jogador2.avatar),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatarData(partida.data),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  '${partida.jogador1.nome} (${partida.jogador1.simbolo}) x ${partida.jogador2.nome} (${partida.jogador2.simbolo})',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                Text(resultado, style: TextStyle(color: corResultado, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de partidas'),
      ),
      body: FutureBuilder<List<Partida>>(
        future: viewModel.carregarHistorico(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhuma partida salva ainda.'),
            );
          }

          final partidas = snapshot.data!;

          return ListView.builder(
            itemCount: partidas.length,
            itemBuilder: (context, index) {
              final partida = partidas[index];

              return GestureDetector(
                onTap: () => _mostrarZoom(context, partida),
                child: _buildResumoPartida(context, partida),
              );
            },
          );
        },
      ),
    );
  }
}
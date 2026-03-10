import 'package:flutter/material.dart';
import '../../data/database/localdatabase.dart';
import '../../data/repositories/partidarepository.dart';
import '../../model/configuracaomodel.dart';
import '../../model/jogadormodel.dart';
import '../../utils/verificarvencedor.dart';
import '../../viewmodel/jogoviewmodel.dart';
import '../widgets/quadradotabuleirowidget.dart';
import 'configuracaoscreen.dart';
import 'historicoscreen.dart';

class JogoScreen extends StatefulWidget {
  final VoidCallback onAlternarTema;
  final bool temaEscuro;

  const JogoScreen({
    super.key,
    required this.onAlternarTema,
    required this.temaEscuro,
  });

  @override
  State<JogoScreen> createState() => _JogoScreenState();
}

class _JogoScreenState extends State<JogoScreen> {
  late JogoViewModel viewModel;

  ConfiguracaoPartida configuracao = ConfiguracaoPartida(
    nomeJogador1: 'Jogador 1',
    nomeJogador2: 'Jogador 2',
    simboloJogador1: 'X',
    simboloJogador2: 'O',
    avatarJogador1: 'assets/avatar_feminino1.jpeg',
    avatarJogador2: 'assets/avatar_masculino1.jpeg',
  );

  @override
  void initState() {
    super.initState();

    viewModel = JogoViewModel(
      partidaRepository: PartidaRepository(
        database: LocalDatabase.instance,
      ),
      verificarVencedor: VerificarVencedor(),
    );

    _iniciarPartida();
  }

  void _iniciarPartida() {
    final jogador1 = Jogador(
      nome: configuracao.nomeJogador1,
      simbolo: configuracao.simboloJogador1,
      avatar: configuracao.avatarJogador1,
    );

    final jogador2 = Jogador(
      nome: configuracao.nomeJogador2,
      simbolo: configuracao.simboloJogador2,
      avatar: configuracao.avatarJogador2,
    );

    viewModel.iniciarPartida(jogador1, jogador2);
  }

  Future<void> _abrirConfiguracao() async {
    final resultado = await Navigator.push<ConfiguracaoPartida>(
      context,
      MaterialPageRoute(
        builder: (context) => ConfiguracaoScreen(configuracaoInicial: configuracao),
      ),
    );

    if (resultado != null) {
      setState(() {
        configuracao = resultado;
        _iniciarPartida();
      });
    }
  }

  Future<void> _realizarJogada(int index) async {
    final resultado = viewModel.realizarJogada(index);

    setState(() {});

    if (resultado != null) {
      await viewModel.salvarPartidaFinalizada();

      final String mensagem;
      if (resultado == 'Empate') {
        mensagem = 'Deu veeeelha!!!';
      } else {
        final nomeVencedor =
            resultado == viewModel.partidaAtual.jogador1.simbolo
                ? viewModel.partidaAtual.jogador1.nome
                : viewModel.partidaAtual.jogador2.nome;

        mensagem = '$nomeVencedor venceu!';
      }

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                const Icon(
                  Icons.emoji_events,
                  size: 50,
                  color: Color.fromARGB(255, 210, 148, 5),
                ),
                const SizedBox(height: 8),
                Text(
                  mensagem,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    viewModel.reiniciarComMesmosJogadores();
                  });
                },
                child: const Text('Recomeçar'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildInfoJogador({
    required String nome,
    required String simbolo,
    required String avatar,
    required bool ativo,
  }) {

  final Color destaque = Theme.of(context).colorScheme.primary;
  final Color borda = ativo
      ? destaque
      : Theme.of(context).colorScheme.onSurface.withOpacity(0.35);

  final Color fundo = ativo
      ? destaque.withOpacity(0.12)
      : Colors.transparent;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: fundo,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: borda,
        width: ativo ? 2.2 : 1,
      ),
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(avatar),
        ),
        const SizedBox(height: 6),
        Text(
          nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          'Símbolo: $simbolo',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (ativo) ...[
          const SizedBox(height: 6),
          Text(
            'Sua vez',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: destaque,
            ),
          ),
        ],
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final posicoes = viewModel.posicoesTabuleiro;

    return Scaffold(
    floatingActionButton: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Theme.of(context).colorScheme.onSurface,
        width: 1.5,
      ),
    ),
    child: FloatingActionButton(
      onPressed: widget.onAlternarTema,
      child: Icon(
        widget.temaEscuro ? Icons.light_mode : Icons.dark_mode,
      ),
    ),
  ),
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _abrirConfiguracao,
                  icon: const Icon(Icons.settings, size: 34),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoricoScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.emoji_events,
                    size: 40,
                    color: Color.fromARGB(255, 210, 148, 5),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoJogador(
                            nome: viewModel.partidaAtual.jogador1.nome,
                            simbolo: viewModel.partidaAtual.jogador1.simbolo,
                            avatar: viewModel.partidaAtual.jogador1.avatar,
                            ativo: viewModel.jogadorAtual == viewModel.partidaAtual.jogador1,
                          ),
                          _buildInfoJogador(
                            nome: viewModel.partidaAtual.jogador2.nome,
                            simbolo: viewModel.partidaAtual.jogador2.simbolo,
                            avatar: viewModel.partidaAtual.jogador2.avatar,
                            ativo: viewModel.jogadorAtual == viewModel.partidaAtual.jogador2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QuadradoTabuleiroWidget(
                          filling: posicoes[0],
                          onTap: () => _realizarJogada(0),
                        ),
                        QuadradoTabuleiroWidget(
                          filling: posicoes[1],
                          onTap: () => _realizarJogada(1),
                        ),
                        QuadradoTabuleiroWidget(
                          filling: posicoes[2],
                          onTap: () => _realizarJogada(2),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QuadradoTabuleiroWidget(
                          filling: posicoes[3],
                          onTap: () => _realizarJogada(3),
                        ),
                        QuadradoTabuleiroWidget(
                          filling: posicoes[4],
                          onTap: () => _realizarJogada(4),
                        ),
                        QuadradoTabuleiroWidget(
                          filling: posicoes[5],
                          onTap: () => _realizarJogada(5),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QuadradoTabuleiroWidget(
                          filling: posicoes[6],
                          onTap: () => _realizarJogada(6),
                        ),
                        QuadradoTabuleiroWidget(
                          filling: posicoes[7],
                          onTap: () => _realizarJogada(7),
                        ),
                        QuadradoTabuleiroWidget(
                          filling: posicoes[8],
                          onTap: () => _realizarJogada(8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}}
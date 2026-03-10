import 'package:flutter/material.dart';
import '../../model/configuracaomodel.dart';
import '../../viewmodel/configuracoesviewmodel.dart';
import '../widgets/avataroptionwidget.dart';

class ConfiguracaoScreen extends StatefulWidget {
  final ConfiguracaoPartida? configuracaoInicial;

  const ConfiguracaoScreen({super.key, this.configuracaoInicial});

  @override
  State<ConfiguracaoScreen> createState() => _ConfiguracaoScreenState();
}

class _ConfiguracaoScreenState extends State<ConfiguracaoScreen> {
  final ConfiguracaoViewModel viewModel = ConfiguracaoViewModel();

  final TextEditingController nomeJogador1Controller = TextEditingController();
  final TextEditingController nomeJogador2Controller = TextEditingController();

  String simboloJogador1 = 'X';

  final List<String> avatares = [
    'assets/avatar_feminino1.jpeg',
    'assets/avatar_feminino3.jpeg',
    'assets/avatar_masculino1.jpeg',
    'assets/avatar_masculino2.jpeg',
  ];

  String avatarJogador1 = '';
  String avatarJogador2 = '';

  @override
  void initState() {
    super.initState();

    if (widget.configuracaoInicial != null) {
      nomeJogador1Controller.text = widget.configuracaoInicial!.nomeJogador1;
      nomeJogador2Controller.text = widget.configuracaoInicial!.nomeJogador2;
      simboloJogador1 = widget.configuracaoInicial!.simboloJogador1;
      avatarJogador1 = widget.configuracaoInicial!.avatarJogador1;
      avatarJogador2 = widget.configuracaoInicial!.avatarJogador2;
    }
  }

  void _salvarConfiguracao() {
    final valido = viewModel.validar(
      nomeJogador1: nomeJogador1Controller.text,
      nomeJogador2: nomeJogador2Controller.text,
      avatarJogador1: avatarJogador1,
      avatarJogador2: avatarJogador2,
    );

    if (!valido) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha os nomes e escolha os avatares.'),
        ),
      );
      return;
    }

    final configuracao = viewModel.criarConfiguracao(
      nomeJogador1: nomeJogador1Controller.text,
      nomeJogador2: nomeJogador2Controller.text,
      simboloJogador1: simboloJogador1,
      avatarJogador1: avatarJogador1,
      avatarJogador2: avatarJogador2,
    );

    Navigator.pop(context, configuracao);
  }

  @override
  void dispose() {
    nomeJogador1Controller.dispose();
    nomeJogador2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuração da partida'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
          
          const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Jogador 1',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'nome',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: nomeJogador1Controller,
              decoration: const InputDecoration(
                labelText: 'Nome do Jogador 1',
                border: OutlineInputBorder(),
              ),
            ),

          const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Avatar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: avatares.map((avatar) {
                return AvatarOptionWidget(
                  avatarPath: avatar,
                  selecionado: avatarJogador1 == avatar,
                  onTap: () {
                    setState(() {
                      avatarJogador1 = avatar;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Símbolo do Jogador 1',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RadioListTile<String>(
              value: 'X',
              groupValue: simboloJogador1,
              onChanged: (value) {
                setState(() {
                  simboloJogador1 = value!;
                });
              },
              title: const Text('X'),
            ),
            RadioListTile<String>(
              value: 'O',
              groupValue: simboloJogador1,
              onChanged: (value) {
                setState(() {
                  simboloJogador1 = value!;
                });
              },
              title: const Text('O'),
            ),


            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Jogador 2',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'nome',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
              TextField(
              controller: nomeJogador2Controller,
              decoration: const InputDecoration(
                labelText: 'Nome do Jogador 2',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Avatar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: avatares.map((avatar) {
                return AvatarOptionWidget(
                  avatarPath: avatar,
                  selecionado: avatarJogador2 == avatar,
                  onTap: () {
                    setState(() {
                      avatarJogador2 = avatar;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _salvarConfiguracao,
                child: const Text('Salvar configuração'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import '../data/repositories/partidarepository.dart';
import '../model/partidamodel.dart';

class HistoricoViewModel {
    final PartidaRepository partidaRepository;

    HistoricoViewModel({ required this.partidaRepository});

    Future<List<Partida>> carregarHistorico() async {
        return await partidaRepository.recuperarPartidas();
    }
}
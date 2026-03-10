import '../database/localdatabase.dart';
import '../entities/partidaentity.dart';
import '../../model/partidamodel.dart';

class PartidaRepository {
  final LocalDatabase database;

  PartidaRepository({required this.database});

  Future<void> salvarPartida(Partida partida) async {
    final entity = PartidaEntity.fromPartida(partida);
    await database.inserir('partidas', entity.toMap());
  }

  Future<List<Partida>> recuperarPartidas() async {
    final result = await database.consultar(
      'partidas',
      orderBy: 'data_partida DESC',
    );

    return result.map((map) => PartidaEntity.fromMap(map).toPartida()).toList();
  }
}
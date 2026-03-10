import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  LocalDatabase._init();

  Future<Database> get database async {
    _database ??= await _initDB('batalha_dos_velhos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE partidas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome_jogador1 TEXT NOT NULL,
        simbolo_jogador1 TEXT NOT NULL,
        avatar_jogador1 TEXT NOT NULL,
        nome_jogador2 TEXT NOT NULL,
        simbolo_jogador2 TEXT NOT NULL,
        avatar_jogador2 TEXT NOT NULL,
        posicao_0 TEXT,
        posicao_1 TEXT,
        posicao_2 TEXT,
        posicao_3 TEXT,
        posicao_4 TEXT,
        posicao_5 TEXT,
        posicao_6 TEXT,
        posicao_7 TEXT,
        posicao_8 TEXT,
        vencedor TEXT,
        data_partida TEXT NOT NULL
      )
    ''');
  }

  Future<int> inserir(String tabela, Map<String, dynamic> dados) async {
    final db = await database;
    return db.insert(tabela, dados);
  }

  Future<List<Map<String, dynamic>>> consultar(
    String tabela, {
    String? orderBy,
  }) async {
    final db = await database;
    return db.query(tabela, orderBy: orderBy);
  }

  Future<void> fechar() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
const dbName = 'notes.db';
const noteTable = 'note';
const userTable = 'user';
const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const textColumn = 'text';
const isSyncedWithCloudColumn = 'is_synced_with_cloud';

const createUserTable = '''
  create table if not exists user (
  'id' integer not null unique,
  'email' text not null unique,
  primary key ('id' autoincrement)
  );
''';

const createNoteTable = '''
  create table if not exists note (
  'id' integer not null unique,
  'user_id' integer not null,
  'text' text,
  'is_synced_with_cloud' integer default 0,
  foreign key ('user_id') references "user"("id"),
  primary key ('id' autoincrement)
  );
''';
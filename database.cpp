#include "database.h"

database::database(QObject *parent) : QObject(parent)
{

}

database::~database()
{

}
// Методы для подключения к базе данных
void database::connectToDataBase()
{
    //Перед подключением к базе данных производим проверку на её существование.
    //В зависимости от результата производим открытие базы данных или её восстановление
    if(!QFile(DATABASE_NAME).exists()){
        this->restoreDataBase();
    } else {
        this->openDataBase();
    }
}

// Методы восстановления базы данных
bool database::restoreDataBase()
{
    // Если база данных открылась ...
    if(this->openDataBase()){
        // Производим восстановление базы данных
        return (this->createTable()) ? true : false;
    } else {
        qDebug() << "Не удалось восстановить базу данных";
        return false;
    }
    return false;
}
// Метод для открытия базы данных
bool database::openDataBase()
{
    // База данных открывается по заданному пути
    // и имени базы данных, если она существует
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName(DATABASE_NAME);
    if(db.open()){
        return true;
    } else {
        return false;
    }
}

// Методы закрытия базы данных
void database::closeDataBase()
{
    db.close();
}
//Метод для создания таблицы в базе данных
bool database::createTable()
{
    // В данном случае используется формирование сырого SQL-запроса
    // с последующим его выполнением.
    QSqlQuery query;

    if(!query.exec( "CREATE TABLE `1` ("
                    "`id`	INTEGER PRIMARY KEY AUTOINCREMENT,"
                    "`round_time`	TEXT NOT NULL DEFAULT '03:00',"
                    "`round_text`	TEXT,"
                    "`period`	TEXT NOT NULL DEFAULT '00:00',"
                    "`rest_time`	TEXT NOT NULL DEFAULT '01:00',"
                    "`rest_text`	TEXT);"))
    {
        qDebug() << "DataBase: error of create " << TABLE;
        qDebug() << query.lastError().text();
    }
    else {
            QSqlQuery query;
            for(int i=0;i<12;i++){
                query.exec( " INSERT INTO `1` ('round_text','rest_text') VALUES (\"Раунд"+QString::number(+i)+"\",\"отдых"+QString::number(+i)+"\")");


            }
        }

    if(!query.exec( "CREATE TABLE `parametrs` ("
                    "`colorScreen`	TEXT NOT NULL DEFAULT '#000',"
                    "`colorPanel`	TEXT NOT NULL DEFAULT '#000',"
                    "`colorTimerFont`	TEXT NOT NULL DEFAULT '#fff',"
                    "`colorRound`	TEXT NOT NULL DEFAULT '#008000',"
                    "`colorRoundEnd`	TEXT NOT NULL DEFAULT '#ffff00',"
                    "`colorRest`	TEXT NOT NULL DEFAULT '#ff0000',"
                    "`begin`	TEXT NOT NULL DEFAULT '00:05')"))
    {
        qDebug() << "DataBase: error of create " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        QSqlQuery query;
        query.exec( "INSERT INTO parametrs DEFAULT VALUES");
        return true;
    }
    return false;
}
// Метод для вставки записи в базу данных
bool database::inserIntoTable(const QVariantList &data)
{
    // Запрос SQL формируется из QVariantList,
    // в который передаются данные для вставки в таблицу.

    QSqlQuery query;
    // В начале SQL запрос формируется с ключами,
    // которые потом связываются методом bindValue
    // для подстановки данных из QVariantList

    query.prepare("INSERT INTO " TABLE " ( " TABLE_FNAME ", "
                  TABLE_SNAME ", "
                  TABLE_NIK " ) "
                            "VALUES (:FName, :SName, :Nik)");
    query.bindValue(":FName",       data[0].toString());
    query.bindValue(":SName",       data[1].toString());
    query.bindValue(":Nik",         data[2].toString());

    // После чего выполняется запросом методом exec()
    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
}
//Второй метод для вставки записи в базу данных
bool database::inserIntoTable(const QString &fname, const QString &sname, const QString &nik)
{
    QVariantList data;
    data.append(fname);
    data.append(sname);
    data.append(nik);

    if(inserIntoTable(data))
        return true;
    else
        return false;
}
//Метод для удаления записи из таблицы
bool database::removeRecord(const int id)
{
    // Удаление строки из базы данных будет производитсья с помощью SQL-запроса
    QSqlQuery query;

    // Удаление производим по id записи, который передается в качестве аргумента функции
    query.prepare("DELETE FROM " TABLE " WHERE id= :ID ;");
    query.bindValue(":ID", id);

    // Выполняем удаление
    if(!query.exec()){
        qDebug() << "error delete row " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

void database::requestDB()
{
    //Подключаем базу данных
    db.open();
    //Осуществляем запрос
    QString zapros=" INSERT INTO `parametrs` (`colorScreen`, `colorPanel`, `colorTimerFont`, `colorRound`, `colorRoundEnd`, `colorRest`) VALUES (\"fff\",\"fff\",\"fff\",\"fff\")";

    QSqlQuery query;
    query.exec(zapros);
}


QList<QString> database::getTitle(QString name)
{
    //Заголовки столбцов
    QList<QString> titleTable;
    QSqlQuery query;
    query.exec( "PRAGMA table_info("+name+")");
    while (query.next())
    {
        titleTable.append(query.value(1).toString());

    }
    return titleTable;
}

QString database::getValue(QString TableName,QString ColumnName,QString id)
{
    //Заголовки столбцов
    QList<QString> dataRow;
    QSqlQuery query;
    query.exec( "SELECT "+ColumnName+" FROM '"+TableName+"' where id="+id+"");
    query.next();
    qDebug()<<query.value(0).toString();

     speak spek;
     spek.speech("Проверка связи");
    return query.value(0).toString();
}

QString database::getColor(QString name)
{
    QSqlQuery query;
    query.exec( "SELECT "+name+" FROM 'parametrs' ");
    query.next();
    return query.value(0).toString();
}

void database::setColor(QString name ,QString colors)
{
    QSqlQuery query;
    query.exec( "UPDATE 'parametrs' SET "+name+"='"+colors+"'");

}

int database::getCountCol(QString name)
{
    //Количество столбцов
    QSqlQuery query;
    query.exec( "PRAGMA table_info("+name+")");
    query.last();
    return query.at() + 1;
}

int database::getCountRow(QString name)
{
    //Количество строк
    QSqlQuery query;
    query.exec( "select count(*) from '"+name+"'");
    query.next();
    return query.value(0).toInt();
}

//void database::govor(QString text)
//{
//    speak * spek=new speak(this);
//    spek->speech(text);
//}

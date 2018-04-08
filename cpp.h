#ifndef CPP_H
#define CPP_H

#include <QObject>
#if defined(Q_OS_ANDROID)
#include <QAndroidJniObject>
#endif
//#include <QtAndroidExtras>
class cpp : public QObject
{
    Q_OBJECT
public:
    explicit cpp(QObject *parent = nullptr);
#if defined(Q_OS_ANDROID)
    Q_INVOKABLE void scrinFullLuck();
    Q_INVOKABLE void scrinDimLuck();
    Q_INVOKABLE void scrinUnluck();
#endif


signals:

public slots:

private:
    #if defined(Q_OS_ANDROID)
    QAndroidJniObject m_wakeLock;
    #endif
};

#endif // CPP_H

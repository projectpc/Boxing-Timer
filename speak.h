#ifndef SPEAK_H
#define SPEAK_H

#include <QObject>
#include <QTextToSpeech>
#include <QVector>
class speak : public QObject
{
    Q_OBJECT
public:
    explicit speak(QObject *parent = nullptr);

signals:

public slots:
    void speech(QString text);
    void stop();

    void setRate(int rate);
    void setPitch(int pitch);
    void setVolume(int volume);

    void stateChanged(QTextToSpeech::State state);
    void engineSelected(int index);
    void languageSelected(int language);
    void voiceSelected(int index);

    void localeChanged(const QLocale &locale);

private:
    QTextToSpeech *m_speech;
    QVector<QVoice> m_voices;
};

#endif // SPEAK_H

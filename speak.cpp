#include "speak.h"
#include <QLoggingCategory>

speak::speak(QObject *parent) : QObject(parent),
    m_speech(0)
{
  QLoggingCategory::setFilterRules(QStringLiteral("qt.speech.tts=true \n qt.speech.tts.*=true"));

}

void speak::speech(QString text)
{
    m_speech->say(text);
}

void speak::stop()
{
   m_speech->stop();
}

void speak::setRate(int rate)
{
    m_speech->setRate(rate / 10.0);
}

void speak::setPitch(int pitch)
{
    m_speech->setPitch(pitch / 10.0);
}

void speak::setVolume(int volume)
{
    m_speech->setVolume(volume / 100.0);
}

void speak::stateChanged(QTextToSpeech::State state)
{

}

void speak::engineSelected(int index)
{
    delete m_speech;
    m_speech = new QTextToSpeech(this);

    // Populate the languages combobox before connecting its signal.
    QVector<QLocale> locales = m_speech->availableLocales();
    qDebug()<<"------------------------------------------------";
    qDebug()<<locales;
    QLocale current = m_speech->locale();
    qDebug()<<current;
    foreach (const QLocale &locale, locales) {
        QString name(QString("%1 (%2)")
                     .arg(QLocale::languageToString(locale.language()))
                     .arg(QLocale::countryToString(locale.country())));
        QVariant localeVariant(locale);
        qDebug()<<name<<"localeVariant= "<<localeVariant;
        if (locale.name() == current.name())
            current = locale;
    }
    setRate(0);
    setPitch(0);
    setVolume(100);

    localeChanged(current);
}

void speak::languageSelected(int language)
{
    QLocale locale =QLocale(QLocale::English, QLocale::UnitedStates);
    m_speech->setLocale(locale);
}

void speak::voiceSelected(int index)
{
     m_speech->setVoice(m_voices.at(index));
}

void speak::localeChanged(const QLocale &locale)
{
    QVariant localeVariant(locale);

    m_voices = m_speech->availableVoices();
    QVoice currentVoice = m_speech->voice();

}

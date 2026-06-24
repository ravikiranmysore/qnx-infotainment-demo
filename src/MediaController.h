#pragma once
#include <QObject>
#include <QString>
#include <QStringList>

class MediaController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool    playing    READ playing    NOTIFY playingChanged)
    Q_PROPERTY(QString trackTitle READ trackTitle NOTIFY trackChanged)
    Q_PROPERTY(QString artist     READ artist     NOTIFY trackChanged)
    Q_PROPERTY(int     volume     READ volume     WRITE setVolume NOTIFY volumeChanged)

public:
    explicit MediaController(QObject *parent = nullptr);

    bool    playing()    const { return m_playing; }
    QString trackTitle() const;
    QString artist()     const;
    int     volume()     const { return m_volume; }

    void setVolume(int v);

    Q_INVOKABLE void playPause();
    Q_INVOKABLE void nextTrack();
    Q_INVOKABLE void prevTrack();

signals:
    void playingChanged();
    void trackChanged();
    void volumeChanged();

private:
    bool    m_playing { false };
    int     m_volume  { 60 };
    int     m_trackIndex { 0 };

    // Simulated playlist
    const QList<QPair<QString,QString>> m_playlist {
        { "Night Drive",       "Kavinsky"        },
        { "Midnight City",     "M83"             },
        { "Digital Love",      "Daft Punk"       },
        { "Born to Run",       "Bruce Springsteen"},
        { "Road to Hell",      "Chris Rea"       }
    };
};

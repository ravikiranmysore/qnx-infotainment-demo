#include "MediaController.h"

MediaController::MediaController(QObject *parent) : QObject(parent) {}

QString MediaController::trackTitle() const
{
    return m_playlist.at(m_trackIndex).first;
}

QString MediaController::artist() const
{
    return m_playlist.at(m_trackIndex).second;
}

void MediaController::setVolume(int v)
{
    v = qBound(0, v, 100);
    if (v == m_volume) return;
    m_volume = v;
    emit volumeChanged();
}

void MediaController::playPause()
{
    m_playing = !m_playing;
    emit playingChanged();
}

void MediaController::nextTrack()
{
    m_trackIndex = (m_trackIndex + 1) % m_playlist.size();
    emit trackChanged();
}

void MediaController::prevTrack()
{
    m_trackIndex = (m_trackIndex - 1 + m_playlist.size()) % m_playlist.size();
    emit trackChanged();
}

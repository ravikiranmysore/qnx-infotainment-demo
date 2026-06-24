#include "SystemInfoProvider.h"
#include <QDateTime>
#include <QRandomGenerator>

SystemInfoProvider::SystemInfoProvider(QObject *parent)
    : QObject(parent)
{
    updateData();
    m_timer.setInterval(1000); // 1-second tick
    connect(&m_timer, &QTimer::timeout, this, &SystemInfoProvider::updateData);
    m_timer.start();
}

void SystemInfoProvider::updateData()
{
    // ── Clock ────────────────────────────────────────────────────────────────
    const QString newTime = QDateTime::currentDateTime().toString("hh:mm:ss");
    if (newTime != m_currentTime) {
        m_currentTime = newTime;
        emit currentTimeChanged();
    }

    // ── Simulated vehicle data ────────────────────────────────────────────────
    // In production: read from QNX PPS node /pps/qnxcar/sensors/...
    int delta = QRandomGenerator::global()->bounded(-3, 4);
    m_speed = qBound(0, m_speed + delta, 220);
    emit speedChanged();

    m_rpm = 800 + m_speed * 22 + QRandomGenerator::global()->bounded(-50, 51);
    emit rpmChanged();

    // Slowly drain fuel
    m_fuelLevel = qMax(0.0, m_fuelLevel - 0.0001);
    emit fuelLevelChanged();
}

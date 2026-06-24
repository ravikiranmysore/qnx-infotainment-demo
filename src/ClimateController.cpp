#include "ClimateController.h"

ClimateController::ClimateController(QObject *parent) : QObject(parent) {}

void ClimateController::setDriverTemp(double t)
{
    t = qBound(16.0, t, 30.0);
    if (qFuzzyCompare(t, m_driverTemp)) return;
    m_driverTemp = t;
    emit driverTempChanged();
}

void ClimateController::setPassengerTemp(double t)
{
    t = qBound(16.0, t, 30.0);
    if (qFuzzyCompare(t, m_passengerTemp)) return;
    m_passengerTemp = t;
    emit passengerTempChanged();
}

void ClimateController::setFanSpeed(int s)
{
    s = qBound(0, s, 5);
    if (s == m_fanSpeed) return;
    m_fanSpeed = s;
    emit fanSpeedChanged();
}

void ClimateController::setAcOn(bool on)
{
    if (on == m_acOn) return;
    m_acOn = on;
    emit acOnChanged();
}

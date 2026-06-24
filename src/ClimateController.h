#pragma once
#include <QObject>

class ClimateController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double driverTemp   READ driverTemp   WRITE setDriverTemp   NOTIFY driverTempChanged)
    Q_PROPERTY(double passengerTemp READ passengerTemp WRITE setPassengerTemp NOTIFY passengerTempChanged)
    Q_PROPERTY(int    fanSpeed     READ fanSpeed     WRITE setFanSpeed     NOTIFY fanSpeedChanged)
    Q_PROPERTY(bool   acOn        READ acOn         WRITE setAcOn         NOTIFY acOnChanged)

public:
    explicit ClimateController(QObject *parent = nullptr);

    double driverTemp()    const { return m_driverTemp; }
    double passengerTemp() const { return m_passengerTemp; }
    int    fanSpeed()      const { return m_fanSpeed; }
    bool   acOn()          const { return m_acOn; }

    void setDriverTemp(double t);
    void setPassengerTemp(double t);
    void setFanSpeed(int s);
    void setAcOn(bool on);

signals:
    void driverTempChanged();
    void passengerTempChanged();
    void fanSpeedChanged();
    void acOnChanged();

private:
    double m_driverTemp    { 22.0 };
    double m_passengerTemp { 22.0 };
    int    m_fanSpeed      { 2 };
    bool   m_acOn          { false };
};

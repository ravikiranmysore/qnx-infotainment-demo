#pragma once
#include <QObject>
#include <QTimer>
#include <QString>

/**
 * @brief Exposes vehicle / system telemetry to QML.
 *
 * On a real QNX CAR platform these values would come from
 * PPS (Persistent Publish/Subscribe) or a CAN gateway service.
 * Here we simulate with a QTimer so the desktop build stays runnable.
 */
class SystemInfoProvider : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int     speed       READ speed       NOTIFY speedChanged)
    Q_PROPERTY(int     rpm         READ rpm         NOTIFY rpmChanged)
    Q_PROPERTY(double  fuelLevel   READ fuelLevel   NOTIFY fuelLevelChanged)
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY currentTimeChanged)

public:
    explicit SystemInfoProvider(QObject *parent = nullptr);

    int     speed()       const { return m_speed; }
    int     rpm()         const { return m_rpm; }
    double  fuelLevel()   const { return m_fuelLevel; }
    QString currentTime() const { return m_currentTime; }

signals:
    void speedChanged();
    void rpmChanged();
    void fuelLevelChanged();
    void currentTimeChanged();

private slots:
    void updateData();

private:
    QTimer  m_timer;
    int     m_speed     { 0 };
    int     m_rpm       { 800 };
    double  m_fuelLevel { 0.72 };
    QString m_currentTime;
};

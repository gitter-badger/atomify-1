#ifndef NAVIGATOR_H
#define NAVIGATOR_H
#include <QQuickItem>

class Camera;
class Navigator : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(Camera* camera READ camera WRITE setCamera NOTIFY cameraChanged)

protected:
    Camera* m_camera = NULL;
    // QQuickItem* m_parent = NULL;
public:
    explicit Navigator(Camera *camera = 0, QQuickItem *parent = 0);
    ~Navigator();
    Camera* camera() const;
public slots:
    void setCamera(Camera* arg);
signals:
    void cameraChanged(Camera* arg);
};

#endif // NAVIGATOR_H

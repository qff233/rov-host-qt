#ifndef FRAMELESS_WINDOW_H__
#define FRAMELESS_WINDOW_H__

#include <QList>
#include <QQuickItem>
#include <QQuickWindow>
#include <QSize>
#include <qobject.h>
#include <qquickitem.h>
#include <qquickwindow.h>
#include <qtmetamacros.h>
#include <qwindow.h>

class FrameLessWindow : public QQuickWindow {
    Q_OBJECT
    Q_PROPERTY(bool resizable MEMBER m_resizable)
    Q_PROPERTY(QList<QRect> moveArea MEMBER m_moveArea)
    Q_PROPERTY(bool maximized READ maximized WRITE setMaximized NOTIFY maximizedChanged)

    enum class MouseEvent {
        None = 0,
        Pressed,
        TopLeft,
        Top,
        TopRight,
        Left,
        Move,
        Right,
        BottomLeft,
        Bottom,
        BottomRight
    };

public:
    explicit FrameLessWindow(QWindow* parent = nullptr);
    bool maximized();
    void setMaximized(bool max);
    Q_INVOKABLE void setCursorDrag(bool dragging);

protected:
    bool eventFilter(QObject* obj, QEvent* evt) override;
signals:
    void resizeUpdate(QSize size);
    void maximizedChanged();

private:
    MouseEvent getMousePressEvent(const QPoint &pos);
    MouseEvent getResizeArea(const QPoint &pos);
    void setWindowGeometry(const QPoint &pos);
    void setCursorEvent(MouseEvent event, bool isRefrensh = true);
    void setGeometryCalc(const QSize &size, const QPoint &pos);

    bool m_resizable;
    MouseEvent m_event;
    QPoint m_globalPressPos;    // 鼠标按下的全局坐标
    QPoint m_pressPos;          // 鼠标按下的应用程序内的坐标
    bool m_move;
    QSize  m_preSize;
    QList<QRect> m_moveArea;

    bool m_monitorEnable{true};
};

#endif
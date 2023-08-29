#include "frameless_window.h"
#include <QCoreApplication>
#include <QDebug>
#include <qquickwindow.h>
#include <qwindow.h>

FrameLessWindow::FrameLessWindow(QWindow* parent)
    : QQuickWindow(parent)
    , m_resizable(true)
    , m_event(MouseEvent::None)
{
    this->setFlags(Qt::Window | Qt::FramelessWindowHint);
    QCoreApplication::instance()->installEventFilter(this); // 加事件过滤器,用来实现拖动窗口
}

bool FrameLessWindow::maximized()
{
    return windowStates() == Qt::WindowMaximized ? true : false;
}

void FrameLessWindow::setMaximized(bool max)
{
    if (max)
        showMaximized();
    else
        showNormal();
    emit maximizedChanged();
    emit resizeUpdate(this->size());
}

bool FrameLessWindow::eventFilter(QObject* obj, QEvent* evt)
{
    QMouseEvent* mouse = dynamic_cast<QMouseEvent*>(evt);

    if (m_event != MouseEvent::None && evt->type() == QEvent::WindowStateChange) {
        unsetCursor();
        m_event = MouseEvent::None;
    } else if (obj == this && mouse && windowStates() != Qt::WindowMaximized) {
        if (mouse->button() == Qt::LeftButton && mouse->type() == QEvent::MouseButtonPress) { // 按下
            m_globalPressPos = mouse->globalPos();
            m_pressPos = position();
            m_preSize = size();
            setCursorEvent(getMousePressEvent(mouse->pos()));
        } else if (m_event != MouseEvent::None && mouse->buttons() == Qt::LeftButton && mouse->type() == QEvent::MouseMove) {
            if (m_event == MouseEvent::Move) { // 按下鼠标移动中
                setPosition(m_pressPos + mouse->globalPos() - m_globalPressPos);
            } else if (m_event != MouseEvent::Move && m_resizable) {
                setCursorEvent(m_event); // 按下鼠标设置窗口大小中
                setWindowGeometry(mouse->globalPos());
            }
        } else if (m_event != MouseEvent::None && mouse->button() == Qt::LeftButton && mouse->type() == QEvent::MouseButtonRelease) {
            unsetCursor();
            m_event = MouseEvent::None;
        } else if (m_event == MouseEvent::None && mouse->type() == QEvent::MouseMove) { // 鼠标徘徊
            MouseEvent currentEven = getResizeArea(mouse->pos());
            setCursorEvent(currentEven, false);
        }
    } 
    return QQuickWindow::eventFilter(obj, evt);
}

FrameLessWindow::MouseEvent FrameLessWindow::getMousePressEvent(const QPoint& pos)
{
    int x = pos.x();
    int y = pos.y();
    int w = width();
    int h = height();
    int i;

    if (x <= 8 && y <= 8) {
        return MouseEvent::TopLeft;
    } else if (x >= (w - 8) && y <= 8) {
        return MouseEvent::TopRight;
    } else if (x <= 8 && y >= (h - 8)) {
        return MouseEvent::BottomLeft;
    } else if (x >= (w - 8) && y >= (h - 8)) {
        return MouseEvent::BottomRight;
    } else if (y <= 8) {
        return MouseEvent::Top;
    } else if (x <= 8) {
        return MouseEvent::Left;
    } else if (x >= (w - 8)) {
        return MouseEvent::Right;
    } else if (y >= (h - 8)) {
        return MouseEvent::Bottom;
    } else {
        for (i = 0; i < m_moveArea.length(); i++) {
            if (m_moveArea[i].contains(x, y))
                return MouseEvent::Move;
        }
        return MouseEvent::None;
    }
}

FrameLessWindow::MouseEvent FrameLessWindow::getResizeArea(const QPoint& pos)
{
    int x = pos.x();
    int y = pos.y();
    int w = width();
    int h = height();

    if (x <= 8 && y <= 8) {
        return MouseEvent::TopLeft;
    } else if (x >= (w - 8) && y <= 8) {
        return MouseEvent::TopRight;
    } else if (x <= 8 && y >= (h - 8)) {
        return MouseEvent::BottomLeft;
    } else if (x >= (w - 8) && y >= (h - 8)) {
        return MouseEvent::BottomRight;
    } else if (y <= 8) {
        return MouseEvent::Top;
    } else if (x <= 8) {
        return MouseEvent::Left;
    } else if (x >= (w - 8)) {
        return MouseEvent::Right;
    } else if (y >= (h - 8)) {
        return MouseEvent::Bottom;
    } else {
        return MouseEvent::None;
    }
}

void FrameLessWindow::setWindowGeometry(const QPoint &pos)
{
    QPoint offset = m_globalPressPos - pos;

    if (m_globalPressPos == pos)
        return;


    switch (m_event) {
    case MouseEvent::TopLeft:
        setGeometryCalc(m_preSize + QSize(offset.x(), offset.y()), m_pressPos - offset);
        break;
    case MouseEvent::Top:
        setGeometryCalc(m_preSize + QSize(0, offset.y()), m_pressPos - QPoint(0, offset.y()));
        break;
    case MouseEvent::TopRight:
        setGeometryCalc(m_preSize - QSize(offset.x(), -offset.y()), m_pressPos - QPoint(0, offset.y()));
        break;
    case MouseEvent::Left:
        setGeometryCalc(m_preSize + QSize(offset.x(), 0), m_pressPos - QPoint(offset.x(), 0));;
        break;
    case MouseEvent::Right:
        setGeometryCalc(m_preSize - QSize(offset.x(), 0), position());
        break;
    case MouseEvent::BottomLeft:
        setGeometryCalc(m_preSize + QSize(offset.x(), -offset.y()), m_pressPos - QPoint(offset.x(), 0));
        break;
    case MouseEvent::Bottom:
        setGeometryCalc(m_preSize + QSize(0, -offset.y()), position());
        break;
    case MouseEvent::BottomRight:
        setGeometryCalc(m_preSize - QSize(offset.x(), offset.y()), position());
        break;
    default:
        break;
    }

}

void FrameLessWindow::setGeometryCalc(const QSize &size, const QPoint &pos)
{
    QPoint endPos = m_pressPos;
    QSize endSize = minimumSize();
    if (size.width() > minimumWidth()) {
        endPos.setX(pos.x());
        endSize.setWidth(size.width());
    } else if (pos.x() != endPos.x()) {
        endPos.setX(m_pressPos.x() +  m_preSize.width() - minimumWidth());
    }

    if (size.height() > minimumHeight()) {
        endPos.setY(pos.y());
        endSize.setHeight(size.height());
    } else if (pos.y() != endPos.y()) {
        endPos.setY(m_pressPos.y() + m_preSize.height() - minimumHeight());
    }
    setGeometry(QRect(endPos, endSize));
    emit resizeUpdate(endSize);
}

void FrameLessWindow::setCursorDrag(bool dragging)
{
    setCursor(dragging ? Qt::OpenHandCursor : Qt::ArrowCursor);
}

void FrameLessWindow::setCursorEvent(MouseEvent event, bool isRefrensh)
{

    switch (event) {
    case MouseEvent::TopLeft:
    case MouseEvent::BottomRight:
        setCursor(Qt::SizeFDiagCursor);
        break;
    case MouseEvent::Top:
    case MouseEvent::Bottom:
        setCursor(Qt::SizeVerCursor);
        break;
    case MouseEvent::TopRight:
    case MouseEvent::BottomLeft:
        setCursor(Qt::SizeBDiagCursor);
        break;
    case MouseEvent::Left:
    case MouseEvent::Right:
        setCursor(Qt::SizeHorCursor);
        break;
    default :
        if(m_event != event)
            unsetCursor();
        break;
    }
    if(isRefrensh)
        m_event = event;
}


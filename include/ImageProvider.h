#pragma once

#include <QQuickImageProvider>

class ImageProvider : public QQuickImageProvider
{
public:
    ImageProvider() : QQuickImageProvider(QQuickImageProvider::Image) {}

    QImage image;

    QImage requestImage(const QString&, QSize *size, const QSize &requestedSize) override
    {
        if(size)
        {
            *size = image.size();
        }

        if(requestedSize.width() > 0 && requestedSize.height() > 0)
        {
            return image.scaled(requestedSize.width(), requestedSize.height(), Qt::KeepAspectRatio);
        }

        return image;
    }
};

#ifndef GRILLE_H
#define GRILLE_H

#include <iostream>
#include <QObject>

class Grille : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QString> grilleQML READ readGrille NOTIFY grilleChanged)
public:
    explicit Grille(QObject *parent = nullptr);
    Q_INVOKABLE void recommencer();
    Q_INVOKABLE void gauche();
    Q_INVOKABLE void droite();
    Q_INVOKABLE void bas();
    Q_INVOKABLE void haut();
    Q_INVOKABLE void annuler();
    QList<QString> readGrille();
    int& getValeur(int x,int y);
    Q_INVOKABLE QString getCase(qint32 x,qint32 y);

signals:
    void grilleChanged();
public slots:

private:
    int tab[4][4];
};

#endif // GRILLE_H









#include "grille.h"

using namespace std;

Grille::Grille(QObject *parent) : QObject(parent)
{
    std::cout<<"creation grille"<<endl;
    for(int x = 0; x <4; x ++){
        for(int y = 0; y<4; y ++){
            this->tab[x][y] = 0;
        }
    }
    emit grilleChanged();
}



void Grille::annuler(){
    cout<<"creation grille"<<endl;
    emit grilleChanged();
}

void Grille::recommencer(){
    cout<<"creation grille"<<endl;
    emit grilleChanged();
}

void Grille::gauche(){
    cout<<"creation grille"<<endl;
    emit grilleChanged();
}

void Grille::droite(){
    cout<<"creation grille"<<endl;
    emit grilleChanged();
}

void Grille::bas(){
    cout<<"creation grille"<<endl;
    emit grilleChanged();
}

void Grille::haut(){
    cout<<"creation grille"<<endl;
    emit grilleChanged();
}

QList<QString> Grille::readGrille(){
    QList<QString> l;
    for (int i=0;i<16;i++)
        l.append(QString("2"));
    cout<<"creation grille"<<endl;
    return l;
}

QString Grille::getCase(qint32 x, qint32 y){
    return QString("243");
}

int& Grille::getValeur(int x, int y){
    if(x>=0 && x <4 && y>=0 && y<4){
        int& ret = this->tab[x][y];
        return ret;

    }else{
        cout << "erreur : dépassement de tableau" << endl;
        int x = -1;
        return x;
    }

}



import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 400
    height: 600
    title: qsTr("Hello World")


    GridView {
        id : grille2048
        x: 5
        y: 205
        width: 400
        height: 400
        focus:true

        Keys.onLeftPressed: {
            grille2048.push("gauche");
        }
        Keys.onRightPressed: {
            grille2048.push("droite");
        }
        Keys.onUpPressed: {
            grille2048.push("haut");
        }
        Keys.onDownPressed: {
            grille2048.push("bas");
        }
        //permet de tester si le jeu est fini
        function finJeu(){
            var couplesVoisin = [];
            // i correspond a la ligne ou a la colone sur laquelle on se situe
            // pour chacune de ces lignes / colonnes, il faudra ajouter 3 couples de voisins
            // soit un total de 24 couples
            for(var i=0;i<4;i++){
                for(var j=0;j<3;j++){
                    couplesVoisin.push([4*i+j,4*i+j+1]);
                    couplesVoisin.push([i+4*j,i+4*j+4]);
                }
            }
            var k = 0;
            var fin = true;
            while(fin && k<couplesVoisin.length){
                var el1 = this.model.get(couplesVoisin[k][0]);
                var el2 = this.model.get(couplesVoisin[k][1]);
                fin = !(el1.value == el2.value || el1.value == "" || el2.value == "");
                k+=1;
            }
            if(fin){
                text4.text = "Partie Terminée";
            }

            return fin;

        }

        //permet d'échanger deux cases dans la grille
        function echange(n1,n2){

            if(n1>n2){
                //this.model.move(5,12,1);
                this.model.move(n1,n2,1);
                if(n2+1 < n1){
                    this.model.move(n2+1,n1,1);
                }
            }
            if(n2>n1){
                this.echange(n2,n1);
            }

        }
        // permet de pousser tous les elements derriere un element en particulier dans la grille suivant une direction définie
        function pushLigne(direction,n){
            var continuer = true;
            var y = Math.floor(n/4);
            var x = n%4;
            var ytravail = y;
            var xtravail = x;
            this.model.set(n,{"value" : ""})
            while(continuer){
                var ntravail = 4 * ytravail + xtravail;
                var n = 4 * y + x;
                this.echange(ntravail,n);
                y = ytravail;
                x = xtravail;
                if(direction == "haut"){
                    ytravail += 1;
                }
                if(direction == "bas"){
                    ytravail -= 1;
                }
                if(direction == "droite"){
                    xtravail -= 1;
                }
                if(direction == "gauche"){
                    xtravail +=1;
                }
                continuer = xtravail>=0 && xtravail < 4 && ytravail >= 0 && ytravail < 4;
            }
        }
        //trouve la valeur après qu'une case ait fusionné
        // ex la valeur suivante de "2" est "4"
        function valeurSuivante(valeur){
            var valeurs = ["2","4","8","16","32","64","128","256","1024","2048","4096","8192","16384"];
            var i = 0;
            var suivant = "-1";
            while(i<13){
                if(valeur == valeurs[i]){
                    suivant = valeurs[i+1];
                }
                i += 1;
            }
            return suivant;
        }
        function nouvelleTuile(){
            var casesVides = [];
            for(var i=0;i<16;i++){
                if(this.model.get(i).value == ""){
                    casesVides.push(i);
                }
            }
            var r = Math.floor(casesVides.length*Math.random());
            console.log(casesVides);
            console.log(r);
            this.model.get(casesVides[r]).value = "2";
        }
        function nouvellePartie(){
            for(var i=0;i<16;i++){
                this.model.get(i).value = "";
            }
            text4.text = "";
        }
        function push(direction){
            var cases = [];
            //ordre des cases dans lequel on devra tester si la fusion est possible
            // ex le tableau [0,4,8,12] indique qu'il faudra commencer par la fusion entre les cases 0 et 4 puis entre 4 et 8 etc ...


            if(direction == "haut"){
                cases = [[0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15]];
            }
            if(direction == "bas"){
                cases = [[12,8,4,0],[13,9,5,1],[14,10,6,2],[15,11,7,3]];
            }
            if(direction == "droite"){
                cases = [[3,2,1,0],[7,6,5,4],[11,10,9,8],[15,14,13,12]];
            }
            if(direction == "gauche"){
                cases = [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15]];
            }

            for(var i=0;i<4;i++){
                var ligne = cases[i];
                for(var j=0;j<3;j++){
                    var el1 = this.model.get(ligne[j]);
                    var el2 = this.model.get(ligne[j+1]);
                    // si les cases ont la même valeur, on les fusionne et on pousse les cases qui sont au bout de la ligne
                    if(el1.value!="" && el1.value == el2.value){
                        el1.value = this.valeurSuivante(el1.value);
                        this.pushLigne(direction,ligne[j+1])
                    }
                    // si la case est vide on tente de pousser les cases qui sont au bout de la ligne
                    // mais pour ca il faut d'abord vérifier que la ligne n'est pas vide
                    if(el1.value == ""){
                        var ligneVide = true;
                        var k=j+1;
                        while(k<4){
                            if(this.model.get(ligne[k]).value != ""){
                                ligneVide = false;
                            }
                            k+=1;
                        }

                        if(!ligneVide){
                            this.pushLigne(direction,ligne[j]);
                            j -= 1;
                        }
                    }
                }
            }


            this.nouvelleTuile();
            this.finJeu();
        }



        // contient les valeurs sur les élements de la grille
        model: TuileModel {}
        delegate: MaTuile2 {

            text: value
        }


    }

    MouseArea {
        id: mouseArea
        x: 31
        y: 101
        width: 100
        height: 52
        onClicked: {
            console.log("nouvelle partie");
            grille2048.nouvellePartie();
        }
        Rectangle {
            id: rectangle
            color: "#e9e9e9"
            radius: 11
            anchors.fill: parent
            transformOrigin: Item.Top


            Text {
                id: text1
                x: 8
                y: 19
                text: qsTr("Nouvelle Partie")
                font.pixelSize: 12
            }
        }
    }

    Text {
        id: text3
        x: 140
        y: 21
        text: qsTr("2048")
        font.pixelSize: 50
    }

    Text {
        id: text4
        x: 115
        y: 169
        text: qsTr("")
        font.pixelSize: 25
    }

}

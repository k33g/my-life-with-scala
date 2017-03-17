# Setup de "ma plateforme"

- J'ai décider d'utiliser Visual Studio Code, un éditeur de code à base d'Electron (pas trop gourmand en ressource) codé par Microsoft
- J'utilise OSX, mais je proposerais des version Linux et Windows (quand j'aurais le temps 😝)

## Installer SBT

SBT? C'est sbt l'outil de build par excellence quand on fait du Scala

### OSX

- http://www.scala-sbt.org/0.13/docs/Installing-sbt-on-Mac.html

```shell
brew install sbt
```

## Support du langage Scala dans VSCode

### Scala Syntax

Utiliser https://marketplace.visualstudio.com/items?itemName=daltonjorge.scala

Dans VSCode, choisir le menu `Go /Go to file...` et utiliser la commande ci-dessous:

```
ext install scala
```

> ⚠️ Bien choisir la version de Dalton Jorge

### Scala Language Server

Ou comment obtenir dans VSCode:

- errors as you type
- code completion
- goto definition (F12 and CMD-F12)
- ...

#### Installer ENSIME

Voir http://ensime.org/build_tools/sbt/

- Créer le fichier `~/.sbt/0.13/plugins/plugins.sbt`
- remarque si le répertoire `plugins` n'existe pas, créez le
- dans `plugins.sbt` ajoutez:

```
addSbtPlugin("org.ensime" % "sbt-ensime" % "1.12.5")
```

## créer une structure de projet Scala

```shell
mkdir awesome-projet
cd awesome-projet
mkdir -p src/{main,test}/{java,resources,scala}
mkdir lib project target
```

```
.
├── lib
├── project
├── src
│   ├── main
│   │   ├── java
│   │   ├── resources
│   │   └── scala
│   └── test
│       ├── java
│       ├── resources
│       └── scala
└── target
```

## Préciser la version de Scala à utiliser

A la racine du projet, céer un fichier `build.sbt` avec ce contenu:

```scala
scalaVersion := "2.11.8"
```

### Ajouter le support d'ENSIME au projet

- dans votre répertoire projet, tapez la commande:

```
sbt ensimeConfig
```

Cette commande va générer le fichier `.ensime` "qui va bien".

### Ajouter le support d'ENSIME pour VSCode

Utiliser https://marketplace.visualstudio.com/items?itemName=dragos.scala-lsp

Dans VSCode, choisir le menu `Go /Go to file...` et utiliser la commande ci-dessous:

```
ext install scala-lsp
```

> Remarque: si vous avez des erreurs, relancez la commande:

```
sbt ensimeConfig
```


## 1er code Scala pour vérifier

Créer un fichier `src/main/scala/Hello.scala`

```scala
object Hello {
  def main(args: Array[String]) = {
    println("Hello 🌍")
  }        
}
```

Et lancer:

```shell
sbt run
```

Et si tout va bien vous obtiendrez après un looooonnnng moment `Hello 🌍`


## Donc c'est long 😡

Alors on va installer un plugin dans le projet qui permet de faire de "la compilation optimisée" (le plugin va compiler à chaque fois que votre code change)

Nous allons utiliser https://github.com/spray/sbt-revolver

Dans le répertoire `project/`, créer un fichier `plugins.sbt` avec le contenu suivant:

```scala
addSbtPlugin("io.spray" % "sbt-revolver" % "0.8.0")
```

Et maintenant, lancer la commande:

```
sbt ~re-start
````

A partir de maintenant, votre projet va se compiler à chaque changement, et cela va accélérer notablement vos compilations (sauf la 1ère fois, le temps de charger le plugin).

Cela semble permettre des temps de compilations tout à fait respectables même sur une petite configuration.


A suivre...

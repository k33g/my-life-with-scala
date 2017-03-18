# Packages & Case classes

Allons un peu plus loin que notre simple `println`

## Les packages en Scala

C'est comme en Java. Dans notre projet, dans `src/main/scala`, nous allons créer un sous-répertoire `org/` qui lui même va contenir un sous-répertoire `typeunsafe/` (ou ce que vous voulez), et ensuite nous y ajoutons un fichier `User.scala`:

```
├── src
│   ├── main
│   │   ├── java
│   │   ├── resources
│   │   ├── scala
│   │   │   ├── Hello.scala
│   │   │   └── org
│   │   │       └── typeunsafe
│   │   │           └── User.scala
```

Et vous pouvez commencer par éditer `User.scala` avec une 1ère ligne

```scala
/*--- User.scala ---*/
package org.typeunsafe


```
Voilà, vous avez créé un package et vous commencez à créer du "contenu" au sein de ce package

## Les case classes

Mais qu'est-ce qu'une "case class"? Vous pouvez voir ça comme une sorte de POJO (http://www.touilleur-express.fr/2014/04/08/passer-a-scala-ce-quil-faut-retenir/) ou une structure, ou une classe "facile" à créer/décrire dont les propriétés sont définies par les paramètres du constructeur. En le codant ça sera plus clair. Par exemple, vous voulez une classe/structure avec une propriété `name` et une propriété `avatar`, il vous suffit d'écrire:

```scala
/*--- User.scala ---*/
package org.typeunsafe

case class User(name: String, avatar: String)
```
Plutôt simple, non?

### Utilisation

C'est plutôt simple, il suffira de faire: `new User("Bob Morane", "😎")`

Mais modifions notre fichier `Hello.scala` de la manière suivante:

```scala
import org.typeunsafe.User

object Hello {
  def main(args: Array[String]) = {

    var robot = new User("robot", "🤖")
    println(s"${robot.name}: ${robot.avatar}")

  }        
}
```

> Donc:

- on a importé `User`: `import org.typeunsafe.User`
- on a instancié `User`: `new User("robot", "🤖")`
- et 🍒/🍰 on a fait de l'interpolation de chaîne de caractères (⚠️ notez bien le **s** juste avant les **"**): `s"${robot.name}: ${robot.avatar}"`

## case class "à la volée"

A savoir: vous pouvez déclarer des case classes un peu n'importe où:

```scala
import org.typeunsafe.User

object Hello {
  def main(args: Array[String]) = {

    var robot = new User("robot", "🤖")
    println(s"${robot.name}: ${robot.avatar}")

    case class Toon(nickName: String, avatar: String)

    println(new Toon("Elmira", "🐹"))
  }        
}
```

## augment my case class

Et vous pouvez aussi ajouter des méthodes à votre case class:

```scala
import org.typeunsafe.User

object Hello {
  def main(args: Array[String]) = {

    var robot = new User("robot", "🤖")

    println(s"${robot.name}: ${robot.avatar}")

    case class Toon(nickName: String, avatar: String)

    println(new Toon("Elmira", "🐹"))

    implicit class ToonsImprovements(val t: Toon) {
      def yo: String = {
        return s"Yo, I'm ${t.nickName} the ${t.avatar}"
      }
    }

    println(new Toon("Babs", "🐰").yo) // Yo, I'm Babs the 🐰
  }        
}
```

Pour "greffer" une méthode sur une classe existante, on utilise une classe implicite que l'on nomme avec le nom de la classe que l'on veut "augmenter" suivi du terme `Improvements` et avec un constructeur qui attend en paramètre un argument du type de la classe que l'on augmente (`val t: Toon`). Et ensuite vous pouvez implémenter vos méthodes dans le corps de la classe implicite.

Voilà, simple et pratique

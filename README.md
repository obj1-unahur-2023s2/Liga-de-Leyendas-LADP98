Liga de Leyendas
----------------

Se nos pide modelar un pequeño sistema de batallas basado en el popular video juego League of Legends (a.k.a. Lol).
El sistema se basará en batallas de **campeones** contra **oleadas de minions**. 
No se contemplarán batallas entre campeones (conocidas popularmente como batallas en equipo).

En las sucesivas etapas del desarrollo, se contemplarán distintos aspectos de las batallas.

<br>

Etapa 1 
-------
Los objetivos de esta etapa son
- desarrollar los modelos básicos de campeones y minions, 
- incluir los **items** que puede tener un campeón, y
- resolver el efecto que una batalla tiene en el campeón que participa (dejamos para una etapa siguiente el efecto sobre la oleada de minions).

Como ya dijimos, cada batalla involucra a un campeón y a una oleada de minions.

De cada **oleada** sabemos cuántos minions la componen. El _daño que produce_ una oleada es esta cantidad, más un _plus de daño_ que se define para cada oleada.   
P.ej. una oleada con 35 minions y que tiene definido un plus de daño de 5 unidades, produce 40 unidades de daño.

En cada batalla, el **campeón** acumula como _puntos de daño_, el daño que produce la oleada contra la que está batallando.  
Por otro lado, cada campeón maneja un valor de _puntos de vida_, que es un número. 
Los puntos de vida representan la cantidad de daño que puede resistir el campeón antes de morir. 
De esta forma, cuando los puntos de daño acumulado son iguales o mayores a los puntos de vida, al campeón se lo considera muerto.

Otro valor que maneja cada campeón es el de _puntos de ataque_, que vamos a definir en esta etapa para usarlo en la siguiente.

Finalmente, un campeón posee uno o varios **items**, que le otorgan puntos de ataque y puntos de vida. El campeón también tiene una cantidad de puntos de vida propios, y una similar de ataque. Estos dos valores se asignan para cada campeón.  
La cantidad total de puntos de vida del campeón entonces será: su cantidad de puntos de vida propios, más la suma de lo que le otorgan los ítems que tenga equipados.

De cada ítem se conoce el peso, en gramos. Si un ítem pesa 500 gramos o menos, entonces de base otorga 20 puntos de vida y 10 de ataque. Si pesa más de 500 gramos, entonces los valores base son 40 de vida y 5 de ataque.

A estos valores base se le deben sumar otros, que son determinados por la _clase_ del ítem. Hay que considerar estas tres clases de items.    

* **Anillo de Doran:** Suma 60 puntos de vida y 15 de ataque. 
* **Tomo Amplificador:** Suma el 25% del acumulado de puntos de daño recibidos por el campeón como puntos de vida y el 10% del mismo acumulado como puntos de ataque. 
* **Sombrero de Rabadon:** Es una variante del Tomo Amplificador. Suma el doble de puntos de vida que los que suma un Tomo Amplificador, y 2 puntos más de ataque. 

**Ejemplo:**  
Consideremos un campeón que tiene 20 puntos de vida y 10 de ataque propios, que tiene equipado un anillo de Doran de 200 gramos, y un tomo amplificador de 1000 gramos. No participó en ninguna batalla, por lo tanto su acumulado de puntos de daño es 0.
Este campeón tiene un total de 140 puntos de vida: 20 propios, más 80 del anillo, más 40 del tomo. Los puntos de ataque son 40: 10 propios, más 25 del anillo, más 5 del tomo. 
Finalmente, supongamos que el campeón no tiene ninguna unidad de bloqueo.  
Si este campeón tiene una batalla con la oleada de minions de los ejemplos anteriores (que provoca 40 unidades de daño), entonces su acumulado de puntos de daño pasa a 40. Ahora su total de puntos de vida pasa a 150, porque ahora el tomo aporta 50: los 40 por el peso más el 25% de los 40 de acumulado de daño, que da 10. Los puntos de ataque pasan a 44, porque el tomo ahora aporta 9: 5 por peso más 4 por el 10% de daño acumulado.    
Finalmente, supongamos que el campeón se equipa un sombrero de Rabadón de 200 gramos. Este sombrero aporta 40 puntos de vida: 20 por peso, más 20 que suma, el doble de los 10 que está sumando un tomo. De ataque aporta 16: 10 por peso más 6 que son 2 más que los 4 que aporta un tomo.
Entonces, el total de puntos de vida del campeón es 190: 20 propios, 80 del anillo, 50 del tomo, 40 del sombrero. Los de ataque son 60: 10 propios, 25 del anillo, 9 del tomo, 16 del sombrero.   

<br>

**Nota**  
El modelo tiene que dar la posibilidad de _equipar_ (o sea agregar) o _desequipar_ (o sea sacar) un ítem a un campeón.

### Consultas sobre los items de un campeón

Agregar la posibilidad de responder, dado un campeón
- cuál es el ítem que tiene equipado que le da más puntos de vida.
- cuáles de los ítems otorgan más puntos de ataque que de vida.
- si tiene algún ítem que otorgue más de 70 puntos de vida, o más de 30 puntos de ataque.
- la lista formada por el peso de cada ítem, una lista de números.
- cuántos ítems tiene que pesen menos de 300 gramos.

<br>

## Etapa 2
En esta etapa vamos a agregar al modelo las unidades de bloqueo.

Cada campeón también tiene una cantidad de _unidades de bloqueo_, un número. 
Cada unidad de bloqueo le permite al campeón resistir todo el daño que el campeón recibe en una batalla contra una oleada de minions. 
Si un campeón que posee una o más unidades de bloqueo batalla contra una oleada de minions, en esa batalla no recibirá daño alguno, pero se descontará en uno su cantidad de bloqueos.

Veamos algunos ejemplos, considerando la oleada definida en la etapa 1, que produce 40 unidades de daño, y un campeón que acumula hasta el momento 45 puntos de daño.
- Si el campeón tiene dos unidades de bloqueo y batalla contra la oleada, entonces sigue teniendo 45 puntos de daño acumulados, porque usa una de sus unidades de bloqueo para resistir el daño que le provoca la oleada. Por otro lado, su cantidad de unidades de bloqueo baja de dos a una; cada unidad de bloqueo sirve para una sola batalla.
- Si el campeón no tiene unidades de bloqueo, entonces su acumulado de puntos de daño pasa de 45 a 85. Si el campeón tiene p.ej. 75 puntos de vida, entonces pasa a estar muerto. Si tiene p.ej. 120 puntos de vida, entonces sigue vivo. 

<br>

## Etapa 3
En esta etapa vamos a agregar al modelo
- el efecto que la batalla tiene en la oleada de minions.
- el efecto que tiene para un campeón equiparse o desequiparse un ítem.

### Efecto de una batalla en la oleada de minions
Cuando una oleada de minions participa en una batalla, la cantidad de minions que la compone disminuye en la mitad de los puntos de ataque del campeón contra el que se está batallando. Además, si el campeón tiene entre 20 y 40 puntos de ataque, entonces el plus de daño de la oleada disminuye en una unidad; si el campeón tiene más de 40 puntos de ataque, entonces este plus disminuye en dos unidades.

Notar que ahora una batalla tiene efecto en el campeón, y también en la oleada. Decidir qué objeto se encarga de cada efecto, y cómo interactúan la oleada y el campeón; esto se va a evaluar.

### Efecto de equiparse o desequiparse un ítem
Ahora, cuando un campeón se equipa un ítem, además de agregarse a la colección de ítems que tiene, se produce un efecto adicional que depende de la clase de ítem. Lo mismo cuando se desequipa. Para las clases de ítems que hay que considerar tenemos que:

* **Anillo de Doran:** Al equiparse, el campeón recibe 5 puntos de daño y, al desequiparse, descuenta 10 puntos de daño.
* **Tomo Amplificador:** Al equiparse otorga dos unidades de bloqueo al campeón, al desequiparse el campeón recibe 30 puntos de daño.
* **Sombrero de Rabadon:** Al equiparse, hace lo mismo que un Tomo Amplificador, y el campeón recibe además 10 puntos de daño. Al desequiparse, no hace nada, <u>ni siquiera lo que está definido para el tomo</u>.

<br> 

## Etapa 4
En esta etapa se agregan al modelo:
- un nuevo tipo de ítem: el **bastón del vacío**.
- una variante de la oleada de minions: el **ejército de minions**.

### Bastón del vacío
Es un ítem que contiene a otros ítems en su interior. El peso de los ítems que tiene no se suma al peso del bastón: por más que un bastón de 600 gramos tenga adentro tres anillos y dos tomos amplificadores, el peso sigue siendo 600 gramos. Esto es por una cualidad mágica del vacío que no nos interesa entender.  
La cantidad de puntos de vida y de ataque que suma el bastón del vacío a la base del peso, son la suma de lo que suman los ítems que tiene adentro.
Un bastón de vacío no tiene ningún efecto al equiparse ni al desequiparse, los efectos que puedan tener los ítems que contiene se ignoran.

### Ejército de minions
Un ejército está formado por una o varias oleadas.  
El daño que produce equivale al total de minions en sus oleadas, más el plus por daño más alto entre todas las oleadas que lo componen.   
Al participar en una batalla, el efecto se maneja de esta forma: si el ejército tiene una sola oleada, entonces todo el efecto pasa a la oleada; si tiene más de una, entonces se pasa a cada oleada un efecto por la mitad de la cantidad de puntos que recibe el ejército. 
P.ej. un ejército que tiene tres oleadas y batalla contra un campeón que tiene 60 puntos de ataque, le pasa a cada oleada un ataque de 30 puntos (con lo cual, cada oleada se va a reducir en 15 minions, la mitad de los 30 puntos que recibió).
 

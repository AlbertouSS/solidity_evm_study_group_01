# Sesión 4 - Variables de Almacenamiento

Temas:

- Variables de almacenamiento (storage variables)
- Arreglos en almacenamiento
- Mappings y Nested mappings

## Variables de almacenamiento

Hasta este punto, todas nuestras funciones solo han devuelto valores que dependen únicamente de los argumentos de la función. No dependen de nada más que del input inmediato que les pasamos. Por eso se les llama funciones puras o _pure_. No tienen conocimiento del estado de la blockchain ni de nada que haya sucedido en el pasado.

Esto sería bastante problemático si estuviéramos haciendo un seguimiento de algo, como cuánto dinero se le debe a una persona o cuántos puntos tenemos en un juego.

Vamos a ver una solución a esto, llamada _variables de almacenamiento_.

Estas se parecen a las "variables de clase" en otros lenguajes, pero no se comportan realmente igual. Puedes pensar en ellas como variables que actúan como una pequeña base de datos.

Veamos un ejemplo:

```solidity

contract ExampleContract {

    uint256 internal x;

    function setX(
        uint256 newValue
    )
        public {
            x = newValue;
    }

    function getX()
        public
        view
        returns (uint256) {
            return x;
    }
}
```

¡Aquí hay mucho que explicar!

Las variables declaradas fuera de las funciones son variables de almacenamiento. Mantienen su valor después de que termina la transacción.

Nota que `getX()` tiene el modificador `view` en lugar de `pure`. Esto se debe a que consulta el estado de la blockchain, es decir, lo que está almacenado en la variable `x`. Si cambias `view` a `pure` en este ejemplo, el código no compilará. También puedes pensar en `view` como de solo lectura. Además, observa que el valor de retorno de `getX` tiene el mismo tipo que `x`, ambos son `uint256`.

En segundo lugar, nota que `setX` no tiene un modificador `view` ni `pure`. Esto se debe a que es una función que cambia el estado. Las funciones que cambian las variables de almacenamiento o hacen algún otro cambio duradero en la blockchain no pueden tener el modificador `view` o `pure`, ya que no son de solo lectura y, por lo tanto, no pueden etiquetarse como `view`, y ciertamente no como `pure`.

Para enfatizar el punto, observa que el siguiente código es inválido:

```solidity
contract ExampleContract {

    uint256 internal x;

    function setX(
        uint256 newValue
    )
        public {
            x = newValue;
    }

    // error: esta función no puede ser pure
    function getX()
        public
        pure
        returns (uint256) {
            return x;
    }
}
```

Observa que la variable `x` en sí tiene el modificador `internal`. Esto significa que otros contratos inteligentes no pueden ver su valor.

El hecho de que una variable sea `internal` no significa que esté oculta. Sigue estando almacenada en la blockchain y cualquiera puede analizar la blockchain para obtener el valor.

Aquí es donde las cosas se vuelven confusas.

El siguiente código también es válido, pero se considera una mala práctica.

```solidity
contract ExampleContract {

    uint256 x;

    function setX(
        uint256 newValue
    )
        public {
            x = newValue;
    }

    function getX()
        public
        view
        returns (uint256) {
            return x;
    }
}

```

En este caso, eliminamos el modificador `internal` de `x`, y aún así se compila. Esto se considera una mala práctica porque no estás siendo explícito sobre tus intenciones para la visibilidad de `x`.

El siguiente código también es válido:

```solidity
contract ExampleContract {

    uint256 public x;

    function setX(
        uint256 newValue
    )
        public {
            x = newValue;
    }

    function getX()
        public
        view
        returns (uint256) {
            return x;
    }
}
```

Cuando una variable se declara `public`, significa que otros contratos inteligentes pueden leer su valor, pero no modificarlo.

Esto es confuso porque las funciones públicas pueden modificar variables, pero las variables `public` no se pueden modificar a menos que haya una función para cambiar su valor.

Resumen:

- Las variables de almacenamiento se declaran fuera de las funciones.
- Las funciones públicas que no tienen el modificador `view` o `pure` pueden cambiar las variables de almacenamiento.
- Las funciones `pure` no pueden acceder a variables de almacenamiento.

# Sesión 4 - Arrays en Almacenamiento

Es posible que hayas notado que en nuestra sección sobre arrays omitimos, curiosamente:

Escribir en índices específicos del array
Añadir elementos a un array
Eliminar el último elemento de un array
Esto se debe a que rara vez se realizan estas operaciones en arrays que se pasan como argumentos de función.

Sin embargo, cuando los arrays están en almacenamiento, estas operaciones son más comunes.

Aquí tienes un ejemplo de código:

```solidity
contract ExampleContract {
    uint256[] public myArray;

    function setMyArray(uint256[] calldata newArray) public {
        myArray = newArray;
    }

    function addToArray(uint256 newItem) public {
        myArray.push(newItem);
    }

    function removeFromArray() public {
        myArray.pop();
    }

    function getLength() public view returns (uint256) {
        return myArray.length;
    }

    function getEntireArray() public view returns (uint256[] memory) {
        return myArray;
    }
}
```

Te recomiendo copiar y pegar este código en Remix para que puedas ganar intuición sobre lo que está ocurriendo.

Llama a setArray con `[1,2,3,4,5,6]`.

Ahora llama a `getLength()`, y devuelve `6`, que es la longitud del array.

Luego, llama a `addToArray` con el argumento `10`. Vuelve a llamar a `getLength()`. Ahora devuelve `7`.

Llama a `removeFromArray()` seguido de `getLength()`. Ahora devuelve `6`, como esperabas.

Vale la pena mencionar que, dado que `myArray` es `public`, Remix lo muestra como visible como una función. Esto significa que el compilador generará automáticamente una función llamada `myArray()` que se puede llamar para leer los valores almacenados en `myArray`.

Sin embargo, no devolverá todo el array. Pedirá un índice y devolverá el valor en ese índice. La función `myArray` se comporta de esta forma:

```solidity
function myArray(uint256 index)
    public
    view
    returns (uint256) {
        return myArray[index];
}
```

Sin embargo, la función `getEntireArray()` devuelve el array completo.

Nota que `pop()` no devuelve el valor.

### Eliminando un Elemento

Solidity no tiene una forma de eliminar un elemento en el medio de una lista y reducir la longitud en uno. El siguiente código es válido, pero no cambia la longitud de la lista:

```solidity
contract ExampleContract {
    uint256[] public myArray;

    function removeAt(uint256 index) public {
        delete myArray[index];
        // establece el valor en el índice a cero

        // el siguiente código es equivalente
        // myArray[index] = 0;

        // la longitud de myArray no cambia en ninguna de estas circunstancias
    }
}
```

Si deseas eliminar un elemento y también reducir la longitud, debes hacer un "pop and swap" (eliminar y reemplazar).

Esto elimina el elemento en el índice especificado y lo intercambia con el último elemento en el array.

```solidity
contract ExampleContract {
    uint256[] public myArray;

    function popAndSwap(uint256 index) public {
        uint256 valueAtTheEnd = myArray[myArray.length - 1];
        myArray.pop(); // reduce la longitud;
        myArray[index] = valueAtTheEnd;
    }
}
```

Solidity no puede eliminar desde el medio de la lista y conservar el orden original del array.

### Strings

Los `strings` se comportan de manera similar a los arrays, excepto que cuando son `public` devuelven el string completo, ya que los `strings` no pueden ser indexados (confuso, ¿verdad?). No existe una operación `pop` o `length` para los strings.

```solidity
contract ExampleContract {
    string public name;

    function setName(string calldata newName)
            public {
        name = newName;
    }
}
```

# Block.timestamp y Block.number

Puedes obtener el timestamp Unix del bloque con `block.timestamp`:

```solidity
contract BlockTimeStamp01 {
    function timestamp() public view returns (uint256) {
        return block.timestamp;
    }
}
```

La función `timestamp()` te devolverá un número largo que corresponde a la cantidad de segundos transcurridos desde el 1 de enero de 1970 UTC, la tradicional época Unix.

Puedes usar este [link](https://www.epochconverter.com/) para convertirlo a un formato de tiempo legible por humanos.

En mi caso, se convirtió en: `sábado, 9 de noviembre de 2024, 3:00:10 PM GMT-06:00`.

El timestamp que obtienes es el que el validador incluyó en el bloque cuando lo produjo.

Así que, una vez más, aunque cuando llamas a la función en Remix a veces puede darte un timestamp que se alinea aproximadamente con la hora actual, en una blockchain real, `block.timestamp` **representa el tiempo registrado por el validador en el momento en que incluyó el bloque en la cadena**.

Con el siguiente código, puedes asegurarte de que alguien no llame a una función más de una vez al día:

```solidity
contract BlockTimestamp02 {

    uint256 public lastCall;

    function hasCooldown() public {
        uint256 day = 60 * 60 * 24;
        require(block.timestamp > lastCall + day, "hasn't been a day");
        lastCall = block.timestamp;
    }
}
```

Pero no necesitas hacer ese cálculo de `uint256 day = 60 _ 60 _ 24;` ya que Solidity permite esto:

```solidity
contract BlockTimestamp03 {

    uint256 public lastCall;

    function hasCooldown() public {
        require(block.timestamp > lastCall + 1 days, "hasn't been a day");
        lastCall = block.timestamp;
    }
}

```

De hecho, `seconds`, `minutes`, `hours`, `days` y `weeks` son todas unidades de tiempo válidas.

### block.number

También puedes saber en qué número de bloque estás con esta variable.

No uses `block.number` para rastrear el tiempo, solo para garantizar el orden de las transacciones.

```solidity
contract Block03 {
    function whatBlockIsIt() external view returns (uint256) {
        return block.number;
    }
}
```

A mi por ejemplo, esto siempre me devuelve `159` en Remix.

Puedes usar el siguiente código para asegurarte de que una función se llame después de otra, es decir, en un bloque posterior:

```solidity
contract Block04 {
    // por defecto es cero
    uint256 private calledAt;

    function callMeFirst() external {
        calledAt = block.number;
    }

    function callMeSecond() external view {
        require(calledAt != 0 && block.number > calledAt, "callMeFirst() not called");
    }
}

```

### Links adicionales

- [Epoch Converter](https://www.epochconverter.com/)

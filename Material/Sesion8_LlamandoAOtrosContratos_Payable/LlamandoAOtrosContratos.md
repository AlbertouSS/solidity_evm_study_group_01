# Llamando a otros contratos

Todo lo que hemos estado haciendo hasta este punto es llamar a contratos inteligentes directamente. Pero también es posible, y de hecho, deseable, que los contratos inteligentes puedan comunicarse entre sí.

```solidity
contract CallingOtherContracts01 {
    function askTheMeaningOfLife(address source) public returns (uint256) {
        (bool ok, bytes memory result) = source.call(
            abi.encodeWithSignature("meaningOfLifeAndAllExistence()")
        );
        require(ok, "call failed");

        return abi.decode(result, (uint256));
    }
}

contract AnotherContract {
    function meaningOfLifeAndAllExistence() public pure returns (uint256) {
        return 42;
    }
}
```

Lo primero interesante aquí es que `askTheMeaningOfLife()` no es una función `view`. Si intentas añadir el modificador `view`, no compilará. ¿Por qué? Las funciones `view` son solo de lectura. Cuando nuestra función `askTheMeaningOfLife()` llama a otro contrato inteligente, nosotros (y el compilador de Solidity) no sabemos si ese otro contrato va a intentar hacer algún cambio de estado en la blockchain, por lo tanto, **Solidity no permite especificar una función como `view` si llama a otro contrato inteligente**.

¿Qué es la porción `bool ok` de la tupla? Las llamadas a funciones de otros contratos inteligentes pueden fallar, por ejemplo, si la función revierte. Para saber si la llamada externa revirtió, se devuelve un booleano. En esta implementación, la función que llama, `askTheMeaningOfLifeAndAllExistence()`, también revierte, pero eso no es necesariamente un requisito general.

## Llamando a un contrato inexistente

¿Qué sucede si llamas a un contrato inteligente inexistente, es decir, una dirección de billetera?

Intenta llamar a `askTheMeaningOfLife()` con nuestra dirección de billetera desde Remix:

`0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db`

Revierte porque intentaste decodificar datos vacíos. Cuando abres el desplegable de transacciones en Remix, ves la explicación de la reversión:

```shell
decoded output: {
	"error": "Failed to decode output: Error: data out-of-bounds (length=0, offset=32, code=BUFFER_OVERRUN, version=abi/5.7.0)"
}
```

Si comentas el código que intenta decodificar, la llamada a la función ya no revertirá:

```solidity
contract CallingOtherContracts01 {
    function askTheMeaningOfLife(address source) public returns (uint256) {
        (bool ok, bytes memory result) = source.call(
            abi.encodeWithSignature("meaningOfLifeAndAllExistence()")
        );
        require(ok, "call failed");

        // return abi.decode(result, (uint256));
        return 0;
    }
}

contract AnotherContract {
    function meaningOfLifeAndAllExistence() public pure returns (uint256) {
        return 42;
    }
}
```

## Llamando a otro contrato con argumentos

¿Qué pasa si el otro contrato recibe argumentos? Aquí está la sintaxis para llamar a un contrato con argumentos:

```solidity
contract CallingOtherContracts02 {
    function callAdd(address source, uint256 x, uint256 y) public returns (uint256) {
        (bool ok, bytes memory result) = source.call(
            abi.encodeWithSignature("add(uint256,uint256)", x, y)
        );
        require(ok, "call failed");

        uint256 sum = abi.decode(result, (uint256));
        return sum;
    }
}

contract Calc {
    function add(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }
}
```
